require 'minitest_helper'
require File.expand_path('../../lib/mock_constants', __FILE__)

# estblish test scaffold after all tests are loaded, before any are run
at_exit do
  unless $!
    Object.const_set :MINITEST_CONSTANT_A, :initialA
    Object.const_set :MINITEST_CONSTANT_B, :initialB
    Object.const_set :MINITEST_CONSTANT_C, :initialC  
  end
end

# restore Object to its original state
# MiniTest::Unit::after_tests do
#   Object.send(:remove_const, :MINITEST_CONSTANT_A)
#   Object.send(:remove_const, :MINITEST_CONSTANT_B)
#   Object.send(:remove_const, :MINITEST_CONSTANT_C)
# end

describe "MiniTest" do

  i_suck_and_my_tests_are_order_dependent!

  MockConstants.minispec({MINITEST_CONSTANT_A: :newA, MINITEST_CONSTANT_Z: :initialZ}, :MINITEST_CONSTANT_C) do
    describe "constants should be adjusted correctly" do

      it "must modify A" do
        MINITEST_CONSTANT_A.must_equal :newA
      end

      it "must not change B" do
        MINITEST_CONSTANT_B.must_equal :initialB
      end

      it "must remove C" do
        Object.wont_be :const_defined?, :MINITEST_CONSTANT_C
      end

      it "must add Z" do
        MINITEST_CONSTANT_Z.must_equal :initialZ
      end

      # it "must permit single test changes" do
      #   MockConstants.with({MINITEST_CONSTANT_Y: :initialY}, :MINITEST_CONSTANT_A) do
      #     MINITEST_CONSTANT_Y.must_equal :initialY
      #     Object.wont_be :const_defined, :MINITEST_CONSTANT_A
      #   end
      #   A.must_equal :newA
      #   Object.wont_be :const_defined?, :MINITEST_CONSTANT_Y
      # end
    end
  end
  
  describe "should have constants properly restored after the tests" do
 
    it "must remove constants added in scaffold" do
      Object.wont_be :const_defined?, :MINITEST_CONSTANT_Z
    end

    it "must reset changed constants to original values" do
      MINITEST_CONSTANT_A.must_equal :initialA
    end

    it "must leave unchanged constants unchanged" do
      MINITEST_CONSTANT_B.must_equal :initialB
    end

    it "must restore removed constants with their initial values" do
      MINITEST_CONSTANT_C.must_equal :initialC
    end
  end
end
