require 'spec_helper'

describe 'Dashbozu::InputGitHub' do
  context 'push' do
    before {
      @payload = File.read(File.dirname(__FILE__) + '/data/github/push.json')
      @project = Project.new
      @activities = Dashbozu::InputGitHub.new.hook(@project, payload: @payload)
    }
    context 'length' do
      subject { @activities }
      its (:length) { should eq 3 }
    end
    context 'first' do
      subject { @activities[0] }
      its (:source) { should eq 'github' }
      its (:body) { should eq "Test" }
      its (:title) { should eq '[Commit] testing - c441029cf' }
      its (:url) { should eq 'https://github.com/octokitty/testing/commit/c441029cf673f84c8b7db52d0a5944ee5c52ff89' }
      its (:author) { should eq 'octokitty' }
      its (:icon_url) { should =~ /gravatar/ }
    end
  end

  context 'issues' do
    before {
      @payload = File.read(File.dirname(__FILE__) + '/data/github/issues.json')
      @project = Project.new
      @activities = Dashbozu::InputGitHub.new.hook(@project, payload: @payload)
    }
    context 'length' do
      subject { @activities }
      its (:length) { should eq 1 }
    end
    context 'first' do
      subject { @activities[0] }
      its (:source) { should eq 'github' }
      its (:body) { should eq "I'm having a problem with this." }
      its (:title) { should eq '[Issue] Hello-World - #1347 opened: Found a bug' }
      its (:url) { should eq 'https://github.com/octocat/Hello-World/issues/1347' }
      its (:icon_url) { should eq 'https://github.com/images/error/octocat_happy.gif' }
      its (:author) { should eq 'octocat' }
    end
  end

  context 'pull_request' do
    before {
      @payload = File.read(File.dirname(__FILE__) + '/data/github/pull_request.json')
      @project = Project.new
      @activities = Dashbozu::InputGitHub.new.hook(@project, payload: @payload)
    }
    context 'length' do
      subject { @activities }
      its (:length) { should eq 1 }
    end
    context 'first' do
      subject { @activities[0] }
      its (:source) { should eq 'github' }
      its (:body) { should eq "Please pull these awesome changes" }
      its (:title) { should eq '[Pull Request] Hello-World - #1 opened: new-feature' }
      its (:url) { should eq 'https://github.com/octocat/Hello-World/pull/1' }
      its (:icon_url) { should eq 'https://github.com/images/error/octocat_happy.gif' }
      its (:author) { should eq 'octocat' }
    end
  end
end

