# Rocket Launcher

A Ruby library to use your USB Rocket Launcher!

![image](http://i.imgur.com/JkxCg.jpg)

This library include also a little bin file to manipulate your rocket launcher.

## Dependencies
To install `rocket_launcher` gem, you need to install libusb 1.0.

* Mac:

      sudo port install libusb-devel
    
* Debian:

      sudo apt-get install libusb-1.0-0-dev

## Install

    gem install rocket_launcher
    
## Usage

There are 3 way to control your rocket launcher:

* by single command: `rl -c left -p 2`
* by a list of commands: `rl -f path/to/list/of/commands.txt`
* by the rocket launcher control console: `rl -i`

See `rl --help` for more details.

## Library usage

    require 'rocket_launcher'
    
    rl = RocketLauncher.new
    rl.up
    rl.left(2.3)
    rl.fire
    rl.park
    rl.close

## Copyright
Copyright © 2012 [Enrico Pilotto (@pioz)](http://github.com/pioz). See [LICENSE](https://github.com/pioz/rocket_launcher/blob/master/LICENSE) for details.