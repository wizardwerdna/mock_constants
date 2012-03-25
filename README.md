# MockConstants [![Build Status](https://secure.travis-ci.org/wizardwerdna/mock_constants.png)](http://travis-ci.org/wizardwerdna/mock_constants)

Mock Constants for Isolation Testing  

## Installation

Add this line to your application's Gemfile:

    gem 'mock_constants'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mock_constants

## Usage

Blistering fast tests of framework software is possible when portions of code can be tested in isolation of the framework.  However, tests often require "mocking" constants from the framework, such as "ActiveRecord" which creates problems when the fast tests are joined of a suite including full framework testing.  This Gem facilitates the installation and removal of constants for isolation tests.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
