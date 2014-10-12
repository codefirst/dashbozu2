require 'spec_helper'

describe 'Dashbozu::InputGitHub' do
  context 'register' do
    before {
      @payload = File.read(File.dirname(__FILE__) + '/data/github/register.json')
      @project = Project.new
      @activities = Dashbozu::InputGitHub.new.hook(@project, payload: @payload)
    }
    context 'length' do
      subject { @activities }
      its (:length) { should eq 0 }
    end
  end

  context 'push' do
    context 'has payload param key' do
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
    context 'has payload param key without commits' do
      before {
        @payload = File.read(File.dirname(__FILE__) + '/data/github/empty_push.json')
        @project = Project.new
        @activities = Dashbozu::InputGitHub.new.hook(@project, payload: @payload)
      }
      context 'length' do
        subject { @activities }
        its (:length) { should eq 0 }
      end
    end

    context 'params as json' do
      before {
        @payload = File.read(File.dirname(__FILE__) + '/data/github/push.json')
        @project = Project.new
        @activities = Dashbozu::InputGitHub.new.hook(@project, MultiJson.load(@payload))
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

  context 'issue_comment' do
    before {
      @payload = File.read(File.dirname(__FILE__) + '/data/github/issue_comment.json')
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
      its (:body) { should eq 'Sorry! I have fixed!' }
      its (:title) { should eq '[Comment] QuoteIt - #10 created: Fix typo and mixed indents' }
      its (:url) { should eq 'https://github.com/codefirst/QuoteIt/pull/10#issuecomment-35151703' }
      its (:icon_url) { should eq 'https://gravatar.com/avatar/462233d5aedf66a793dcd95f814f8811?d=https%3A%2F%2Fidenticons.github.com%2Fb37ffe9e8f67937ea21dc01fd2c41a39.png&r=x' }
      its (:author) { should eq 'mallowlabs' }
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

