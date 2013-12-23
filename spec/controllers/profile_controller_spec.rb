require 'spec_helper'

describe ProfileController do

  before do
    user = User.create!
    user.save
    sign_in user
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
