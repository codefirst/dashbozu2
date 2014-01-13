require 'spec_helper'

describe ApplicationController do
  context "logged_provider" do
    before do
      Settings.stub(:omniauth) { {github: {}} }
      session['github_oauth_credentials'] = 'test'
    end
    subject { controller.logged_provider }
    it { should == :github }
  end
end
