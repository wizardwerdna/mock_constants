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

Blistering fast tests of framework software is possible when portions of code can be tested in isolation of frameworks, such as Rails, and other dependencies.  Advocates such as Gary Bernhard, Corey Haines and others have convinced me of the virtues of this approach, and the sheer joy and productivity of TDD when test results appear almost as soon as you hit the key to initiate them.

However, isolation testing may require some doubles, creation or modification of the values for global constants from the framework or dependency, such as "ActiveRecord," and its progeny.  This can create problems when fast tests are joined as part of a test suite including tests requiring full framework testing.  

This Gem facilitates the installation, modification and removal of constants for isolation tests.  For example, consider the following minitest spec:

    describe PasswordResetService do
      subject{PasswordResetService.new}
      let(:user){stub}
      it "sends e-mail to user on request" do
        UserMailer.expects(:notify_user).with(user)
        subject.request_password_reset(user)
      end
    end

Of course, we could simply require Rails and let it go.  Unfortunately, loading and initializing the entire framework is costly and unnecessary (often by a factor of 40 or more!).  Because the test does not require any knowledge of `UserMailer`, apart from its notify_user protocol, or `User`, beyond it being a parameter to notify_user, this is a waste of resources, particularly the psyche of the programmer.

We might run the test in isolation, stubbing UserMailer and User with empty class definitions, such as: `Class User; end`  The difficulty is that the definition must be carefully defined to avoid conflicts when run in a suite with tests that require a full framework load.  Even so, the mere leaking of any definition of UserMailer can interfere with the proper autoloading behavior.  Despite Bernhards compelling arguments for this solution as simpler and less invasive, I have not been able to make them work for the autoloaded portions of Rails.

We might finesse all of this with the more rational dependency injection solutions.  (See _____ video at destroyallsoftware.com.)  However, many rails users might not be drawn to changing the models as an improvement in design, perceiving the only benefit to be somewhat faster tests.

The only solution I could find short of dependency injection is to expressly modify the environment, adding, changing or removing constants for mocking, while retaining the necessary information to reinstate the environment at the conclusion of the test.  The difficulty is that the code to do this is complex and invasive, requiring great care to ensure that what is done is undone.

Ruby does not make this an easy task, because constants are supposed to be constants.  This module eases the complexity and assures that the "constant pool" will be restored to the state it was prior to the test.  This is accomplished in this example with:

    MockConstants.minispec(User: Class, Usermailer: Class) do
      describe PasswordResetService do
        ... as above ..
      end
    end
    
or if a single test is needed:

    describe PasswordResetService do
      subject{PasswordResetService.new}
      let(:user){stub}
      it "sends e-mail to user on request" do
        MockConstants.with(User: Class, UserMailer: Class) do
          UserMailer.expects(:notify_user).with(user)
          subject.request_password_reset(user)
        end
      end
    end
  
The first example actually creates an outer 'describe' class, having `before` and `after` routines in that scope to establish the desired state and restore it thereafter from information retained in the before block.  The latter wraps and yields to the inner block, establishing the desired state with an ensure block to restore it thereafter.  It should be straightforward to implement this protocol for other testing regimes, and the author would welcome contributions to that effect.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
