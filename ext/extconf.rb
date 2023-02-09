# :stopdoc:

ENV['RC_ARCHS'] = '' if RUBY_PLATFORM =~ /darwin/

require 'mkmf'

INCLUDE_DIRS = [
  RbConfig::CONFIG['includedir'],
  '/usr/local/include',
  '/usr/include',
  '/opt/homebrew/include'
]

LIB_DIRS = [
  RbConfig::CONFIG['libdir'],
  '/usr/local/lib',
  '/usr/lib',
  '/opt/homebrew/lib'
]

dir_config('rocket_launcher', INCLUDE_DIRS, LIB_DIRS)

abort 'libusb-1.0 is missing' unless find_header('libusb-1.0/libusb.h')
abort 'libusb-1.0 is missing' unless find_library('usb-1.0', 'libusb_init')

create_makefile('usb/usb')

# :startdoc:
