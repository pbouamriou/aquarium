extern crate crc8;
extern crate i2cdev;

use crc8::*;
use docopt::Docopt;
use i2cdev::core::I2CDevice;
#[cfg(any(target_os = "linux", target_os = "android"))]
use i2cdev::linux::*;
use serde::Deserialize;

const USAGE: &'static str = "
Highlight led via i2c command

Usage:
    i2c-control led (on|off)
    i2c-control temp
    i2c-control other
    i2c-control (-h | --help)

Options:
    -h --help   Show this screen
";

const SLAVE_ADDR: u16 = 0x08;

#[derive(Debug, Deserialize)]
struct Args {
    cmd_temp: bool,
    cmd_other: bool,
    cmd_led: bool,
    cmd_on: bool,
    cmd_off: bool,
}

fn main() {
    let mut crc8 = Crc8::create_msb(0x07);
    let args: Args = Docopt::new(USAGE)
        .and_then(|d| d.deserialize())
        .unwrap_or_else(|e| e.exit());

    if args.cmd_led {
        let result = LinuxI2CDevice::new("/dev/i2c-1", SLAVE_ADDR);
        match result {
            Ok(mut i2cdev) => {
                if args.cmd_on {
                    i2cdev.smbus_write_byte_data(0x00, 0x01).unwrap();
                } else {
                    i2cdev.smbus_write_byte_data(0x00, 0x00).unwrap();
                }
            }
            Err(err) => {
                println!("Unable to open {:?}, err = {:?}", "/dev/i2c-1", err);
            }
        }
    }

    if args.cmd_temp {
        let result = LinuxI2CDevice::new("/dev/i2c-1", SLAVE_ADDR);
        match result {
            Ok(mut i2cdev) => {
                let reg = 0x01;
                let data = i2cdev.smbus_read_i2c_block_data(reg, 3).unwrap();
                println!("data = {:?}", data);
                let value: i16 = (data[0] as i16) << 8 | (data[1] as i16);
                let crc = data[2];
                let data_array = [data[0], data[1]];
                let crc_calculated = crc8.calc(&data_array, 2, 0);
                println!(
                    "Temp = {:?}, ok? : {:?}",
                    (value as f32) / 16f32,
                    crc == crc_calculated
                );
            }
            Err(err) => {
                println!("Unable to open {:?}, err = {:?}", "/dev/i2c-1", err);
            }
        }
    }

    if args.cmd_other {
        let result = LinuxI2CDevice::new("/dev/i2c-1", SLAVE_ADDR);
        match result {
            Ok(mut i2cdev) => {
                let reg = 0x02;
                let value = i2cdev.smbus_read_word_data(reg).unwrap() as f32;
                println!("Value = {:?}", value / 16f32);
            }
            Err(err) => {
                println!("Unable to open {:?}, err = {:?}", "/dev/i2c-1", err);
            }
        }
    }
}
