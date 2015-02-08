require 'rails_helper'

describe ProfileController, type: :controller do

  before do
    user = User.create!
    user.save
    sign_in user
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      expect(response).to be_success
    end
  end

end
