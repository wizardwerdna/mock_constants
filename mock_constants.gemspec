# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mock_constants/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrew Greenberg"]
  gem.email         = ["wizardwerdna@gmail.com"]
  gem.description   = %q{Mock Constants for Isolation Testing}
  gem.summary       = %q{Blistering fast tests of framework software is possible when portions of code can be tested in isolation of the framework.  However, tests often require "mocking" constants from the framework, such as "ActiveRecord" which creates problems when the fast tests are joined of a suite including full framework testing.  This Gem facilitates the installation and removal of constants for isolation tests.}
  gem.homepage      = ""

  gem.add_development_dependency "minitest"
  gem.add_development_dependency "mocha"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "turn"
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mock_constants"
  gem.require_paths = ["lib"]
  gem.version       = MockConstants::VERSION
end
