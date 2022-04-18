#include <Arduino.h>
#include <Wire.h>
#include <OneWire.h>
#include "crc8.h"

extern volatile uint8_t twi_error;
extern volatile uint8_t twi_state;
extern volatile uint8_t twi_status;

// LED on pin 13
const int ledPin = LED_BUILTIN;
const int oneWirePin = 10;
uint8_t tempData[] = {0, 0, 0};
uint8_t *storemap[] = {tempData};

byte addr_temp[8];

#define BAD int16_t(0xFFFF)

OneWire ds(oneWirePin); // on pin 10 (a 4.7K resistor is necessary)

volatile int16_t celsius = BAD;
const int16_t bad = 0xDEAD;

CRC8 crc8;

enum class ADDR
{
  LED = 0,
  TEMP = 1,
  NONE = 255
};

ADDR addr = ADDR::NONE;

void storeData(int16_t celsius)
{
  storemap[0][0] = uint8_t(celsius >> 8);
  storemap[0][1] = uint8_t(celsius & 0xFF);
  storemap[0][2] = crc8.get_crc8(storemap[0], 2);
}

// Function that executes whenever data is received from master
void receiveEvent(int howMany)
{
  bool first = true;
  char reg = 0x0;
  //Serial.println("Receive event");
  while (Wire.available())
  {                       // loop through all but the last
    char c = Wire.read(); // receive byte as a character
    //Serial.print("Data read : ");
    //Serial.println(c, HEX);
    if (first)
    {
      reg = c;
      first = false;
      if (howMany == 1)
      {
        // Read
        switch (ADDR(reg))
        {
        case ADDR::TEMP:
        {
          addr = ADDR::TEMP;
        }
        break;
        default:
          addr = ADDR::NONE;
          break;
        }
      }
    }
    else
    {
      // Write
      switch (ADDR(reg))
      {
      case ADDR::LED:
        char level;
        if (c == 0)
        {
          level = LOW;
        }
        else
        {
          level = HIGH;
        }
        digitalWrite(ledPin, level);
        break;
      default:
        break;
      }
    }
  }
}

void requestEvent()
{
  switch (addr)
  {
  case ADDR::TEMP:
  {
    Wire.write(storemap[0], 3);
    //Serial.println("** Request event ** ");
    //Serial.print("Response = ");
    ////Serial.println(temp, DEC);
    break;
  }
  case ADDR::NONE:
  case ADDR::LED:
    Wire.write((char *)&bad, 2);
    //Serial.print("++ Request event ++  : ");
    //Serial.println(size);
    break;
  }
}

void setup(void)
{
  Serial.begin(115200);
  crc8.begin();

  // Join I2C bus as slave with address 8
  Wire.begin(0x8, false, false);

  // Call receiveEvent when data received
  Wire.onReceive(receiveEvent);
  Wire.onRequest(requestEvent);

  // Setup pin 13 as output and turn LED off
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);

  while (!ds.search(addr_temp))
  {
    delay(250);
  }

  if (OneWire::crc8(addr_temp, 7) != addr_temp[7])
  {
    Serial.println("CRC is not valid!");
  }
}

void getTemp(int16_t &temp)
{
  byte i;
  //byte type_s = 0;
  byte data[12];

#if 0
  if (!ds.search(addr))
  {
    ds.reset_search();
    delay(250);
    return;
  }

  if (OneWire::crc8(addr, 7) != addr[7])
  {
    Serial.println("CRC is not valid!");
    return;
  }

  // the first ROM byte indicates which chip
  switch (addr[0])
  {
  case 0x10:
    Serial.println("  Chip = DS18S20"); // or old DS1820
    type_s = 1;
    break;
  case 0x28:
    Serial.println("  Chip = DS18B20");
    type_s = 0;
    break;
  case 0x22:
    Serial.println("  Chip = DS1822");
    type_s = 0;
    break;
  default:
    Serial.println("Device is not a DS18x20 family device.");
    return;
  }
#endif

  ds.reset();
  ds.select(addr_temp);
  ds.write(0x44, 1); // start conversion, with parasite power on at the end

  delay(1000); // maybe 750ms is enough, maybe not
  // we might do a ds.depower() here, but the reset will take care of it.

  ds.reset();
  ds.select(addr_temp);
  ds.write(0xBE); // Read Scratchpad

  // Serial.print("  Data = ");
  // Serial.print(present, HEX);
  // Serial.print(" ");
  for (i = 0; i < 9; i++)
  { // we need 9 bytes
    data[i] = ds.read();
    //Serial.print(data[i], HEX);
    //Serial.print(" ");
  }
  //Serial.print(" CRC=");
  //Serial.print(OneWire::crc8(data, 8), HEX);
  //Serial.println();

  // Convert the data to actual temperature
  // because the result is a 16 bit signed integer, it should
  // be stored to an "int16_t" type, which is always 16 bits
  // even when compiled on a 32 bit processor.
  int16_t raw = (data[1] << 8) | data[0];
  byte cfg = (data[4] & 0x60);
  // at lower res, the low bits are undefined, so let's zero them
  if (cfg == 0x00)
    raw = raw & ~7; // 9 bit resolution, 93.75 ms
  else if (cfg == 0x20)
    raw = raw & ~3; // 10 bit res, 187.5 ms
  else if (cfg == 0x40)
    raw = raw & ~1; // 11 bit res, 375 ms
  //// default is 12 bit resolution, 750 ms conversion time

  temp = raw;
  //Serial.print("Temperature = ");
  //Serial.print(celsius);
  //Serial.println(" Celsius");
}

void loop(void)
{
  int16_t celsius = BAD;
  getTemp(celsius);
  if (celsius != BAD)
  {
    storeData(celsius);
    Serial.print("Temp : ");
    Serial.println(celsius, DEC);
    Serial.print("CRC : ");
    Serial.println(storemap[0][2], DEC);
  }
  delay(250);
}