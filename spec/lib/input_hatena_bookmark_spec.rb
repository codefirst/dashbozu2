require 'rails_helper'

describe 'Dashbozu::InputHatenaBookmark' do
  context 'add' do
    before {
      params = {
        username: 'test_user',
        title: 'test article',
        url: 'http://example.com',
        count: 10,
        permalink: 'http://permalink.example.com',
        status: 'add',
        comment: 'a comment'
      }
      @project = Project.new
      @activities = Dashbozu::InputHatenaBookmark.new.hook(@project, params)
    }
    subject { @activities.first }
    its (:source) { should eq 'hatena_bookmark' }
    its (:body) { should eq "a comment http://example.com" }
    its (:title) { should eq '[Bookmark] add - test article' }
    its (:url) { should eq 'http://permalink.example.com' }
    its (:author) { should eq 'test_user' }
    its (:icon_url) { should eq 'http://cdn1.www.st-hatena.com/users/su/test_user/profile.gif' }
  end
  context 'update' do
    before {
      params = {
        username: 'test_user',
        title: 'test article',
        url: 'http://example.com',
        count: 10,
        permalink: 'http://permalink.example.com',
        status: 'update',
        comment: 'a comment'
      }
      @project = Project.new
      @activities = Dashbozu::InputHatenaBookmark.new.hook(@project, params)
    }
    subject { @activities }
    it { should be_empty }
  end
end
