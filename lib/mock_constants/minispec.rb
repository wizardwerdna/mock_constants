module MockConstants
  class MiniSpec
    def self.minispec hash={}, list=[]
      describe "*" do
        let(:mock_constants_saved_state_for_restore){MockConstants::Base.new}
        before{mock_constants_saved_state_for_restore.with(hash, list)}
        after{mock_constants_saved_state_for_restore.restore}
        yield
      end
    end
  end
end
