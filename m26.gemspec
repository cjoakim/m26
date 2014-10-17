$LOAD_PATH << 'lib'
require 'm26_constants'
require 'rake'

Gem::Specification.new do | s |
  s.name        = 'm26'
  s.version     = M26::Constants::VERSION
  s.date        = M26::Constants::DATE
  s.summary     = 'm26'
  s.description = 'A ruby gem for running, cycling, and swimming calculations.'
  s.authors     = [ M26::Constants::AUTHOR ]
  s.email       = M26::Constants::EMAIL
  s.homepage    = 'https://github.com/cjoakim/m26'
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.1.1'
  s.has_rdoc    = true
  s.files = FileList[
    'lib/**/*.rb'].to_a
  s.add_development_dependency("rspec", ">= 2.14.1")
  s.licenses = ['GPL-3']
end
