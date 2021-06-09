require 'rails_helper'

RSpec.describe "Home", type: :request do    
      before do
        @user = create(:user)
      end
    
     describe "When signed in" do
       before do
          sign_in @user
       end
         
      it "should get index" do
        get root_path
        assert_response :success
      end
    end

    describe "when not signed in" do
      it "should not get index" do
        get root_path
        
        #what do we expect should happen if you are not signed in
        redirect_to(new_user_session_path)
      end
    end
end
