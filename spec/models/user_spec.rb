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
end
