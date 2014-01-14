require 'spec_helper'

describe 'Dashbozu::InputHeroku' do
  context 'hook' do
    before {
      params = {
                  app: 'the app name',
                  user: 'user@example.com',
                  url: 'http://myapp.heroku.com',
                  head: '1e198a0',
                  head_log: '1e198a005da34694034f006f1e1ffc712672bb6b',
                  git_log: 'log of commits between this deploy and the last'
               }
      @project = Project.new
      @activities = Dashbozu::InputHeroku.new.hook(@project, params)
    }
    context 'length' do
      subject { @activities }
      its (:length) { should eq 1 }
    end
    context 'first' do
      subject { @activities[0] }
      its (:source) { should eq 'heroku' }
      its (:body) { should eq 'log of commits between this deploy and the last' }
      its (:title) { should eq '[Deploy] the app name - 1e198a0' }
      its (:url) { should eq 'http://myapp.heroku.com' }
      its (:icon_url) { should =~ /gravatar/ }
      its (:author) { should eq 'user@example.com' }
    end
  end
end

