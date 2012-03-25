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

For example, consider the following minitest spec:

  describe ForgottenPasswordServices do
    subject{ForgottenPasswordService.new}
    it "should send e-mail when requested" do
      user_information = stub
      UserMailer.expects(:notify_user).with(user)
      subject.requested(user_information)
    end
  end
  
Of course, we could simply load up rails, but this test does not require any knowledge of the UserMailer object, and would run much faster without the overhead.  We might run the test in isolation, stubbing the `UserMailer` constant with something like `class UserMailer; end`.  The difficulty with this approach is that the constant will leak when this test is run with other tests, including tests that do include rails.  In this case, we can run into various conflicts, particularly if our test runs first.  This is because we will bleed the creation of the UserMailer constant, and the load of Rails will fail to autoload the actual UserMailer class.  Somehow, we would like to "forget" the stubbed constant at the end of the test.

Ruby does not make this an easy task, because constants are supposed to be constants.  This module eases the complexity and assures that the "constant pool" will be restored to the state it was prior to the test.  This is accomplished in this example with:

  describe ForgottenPasswordServices do
    subject{ForgottenPasswordService.new}
    it "should send e-mail when requested" do
      MockConstants.with(UserMailer: Class) do
        user_information = stub
        UserMailer.expects(:notify_user).with(user)
        subject.requested(user_information)
      end
    end
  end
    
or if the entire test suite is to be wrapped:

  MockConstantScaffold.with(UserMailer: Class) do
    . . .
    describe ForgottenPasswordServices do
      subject{ForgottenPasswordService.new}
      it "should send e-mail when requested" do
        user_information = stub
        UserMailer.expects(:notify_user).with(user)
        subject.requested(user_information)
      end
    end
    . . .
  end
  
The `with` method takes two optional parameters, a hash of mock constants to be added or changed, and an array of Constants to be removed.  The target module or class can be modified using an `on` method before the `with`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
