# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'rocket_launcher/version'

Gem::Specification.new do |s|
  s.name        = 'rocket_launcher'
  s.version     = RocketLauncher::VERSION
  s.authors     = ['Enrico Pilotto']
  s.email       = ['enrico@megiston.it']
  s.homepage    = ''
  s.summary     = %q{A Ruby library to control your USB Rocket Launcher device}
  s.description = %q{A Ruby library to control your USB Rocket Launcher device.}

  s.rubyforge_project = 'rocket_launcher'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib', 'ext']
  s.extensions    = ['ext/extconf.rb']

  s.requirements  = ['libusb1.0 - Debian package name: libusb-1.0-0-dev - Mac port package name: libusb-devel']
end
