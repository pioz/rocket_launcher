# :stopdoc:

ENV['RC_ARCHS'] = '' if RUBY_PLATFORM =~ /darwin/

require 'mkmf'

INCLUDE_DIRS = [
  RbConfig::CONFIG['includedir'],
  '/opt/local/include',
  '/usr/local/include',
  '/usr/include'
]

LIB_DIRS = [
  RbConfig::CONFIG['libdir'],
  '/opt/local/lib',
  '/usr/local/lib',
  '/usr/lib'
]

dir_config('rocket_launcher', INCLUDE_DIRS, LIB_DIRS)

unless find_header('libusb-1.0/libusb.h')
  abort 'libusb-1.0 is missing.'
end

unless find_library('usb-1.0', 'libusb_init')
  abort 'libusb-1.0 is missing.'
end

create_makefile('usb/usb')

# :startdoc:
