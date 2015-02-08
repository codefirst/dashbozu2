require 'rails_helper'

describe ApplicationController, type: :controller do
  context "logged_provider" do
    before do
      allow(Settings).to receive(:omniauth) { {github: {}} }
      session['github_oauth_credentials'] = 'test'
    end
    subject { controller.logged_provider }
    it { should == :github }
  end
end
