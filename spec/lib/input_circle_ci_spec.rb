require 'rails_helper'

describe 'Dashbozu::InputCircleCI' do
  context 'hook' do
    before {
      @payload = MultiJson.load(File.read(File.dirname(__FILE__) + '/data/circle_ci/build.json'))
      @project = Project.new
      @activities = Dashbozu::InputCircleCI.new.hook(@project, @payload)
    }
    context 'length' do
      subject { @activities }
      its (:length) { should eq 1 }
    end
    context 'first' do
      subject { @activities[0] }
      its (:source) { should eq 'circle_ci' }
      its (:body) { should eq "Don't explode when the system clock shifts backwards" }
      its (:title) { should eq '[Build] mongofinil - #22 Success' }
      its (:url) { should eq 'https://circleci.com/gh/circleci/mongofinil/22' }
      its (:icon_url) { should =~ /gravatar/ }
      its (:status) { should eq 'success' }
      its (:author) { should eq 'Allen Rohner' }
    end
  end
end

