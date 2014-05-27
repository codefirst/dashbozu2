require 'spec_helper'

describe User do
  describe 'auths' do
    before do
      @github_auth = Auth.new(name: 'github_user', provider: 'github')
      @github_auth.save

      @user = User.create!
      @user.auths << @github_auth
    end
    subject { @user.auth_of('github') }
    its(:name) { should == 'github_user' }
    its(:provider) { should == 'github' }
  end

  describe 'connect_with' do
    before do
      @user1 = User.create!
      @auth = Auth.create!(provider: 'github', name: 'name', email: 'test@example.com')
      @user1.auths << @auth
      @user2 = User.create!
      @user2.connect_with(@auth)
    end
    context 'user1' do
      subject { @user1 }
      its(:auths) { should have(0).items }
    end
    context 'user2' do
      subject { @user2 }
      its(:name) { should eq 'name' }
      its(:email) { should eq 'test@example.com' }
      its(:auths) { should include(@auth) }
      its(:auths) { should have(1).items }
    end
  end

  describe 'create dashbozu project' do
    before do
      Project.delete_all
      @user = User.create!(name: 'User name')
    end
    subject { @user.find_or_create_dashbozu_project }
    it { should_not be_nil }
  end
end
