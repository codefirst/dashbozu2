require 'spec_helper'

describe User do
  describe 'service_user' do
    before do
      @github_user = User.new(name: 'github_user', provider: 'github')
      @github_user.save

      @dashbozu_user = User.new(name: 'dashbozu_user')
      @dashbozu_user.service_users << @github_user
      @dashbozu_user.save
    end
    subject { @dashbozu_user.service_user('github') }
    its(:name) { should == 'github_user' }
    its(:provider) { should == 'github' }
  end
end
