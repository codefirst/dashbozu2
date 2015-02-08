require 'rails_helper'

describe 'Dashbozu::InputTravisCI' do
  context 'hook' do
    before {
      @payload = File.read(File.dirname(__FILE__) + '/data/travis_ci/build.json')
      @project = Project.new
      @activities = Dashbozu::InputTravisCI.new.hook(@project, payload: @payload)
    }
    context 'length' do
      subject { @activities }
      its (:length) { should eq 1 }
    end
    context 'first' do
      subject { @activities[0] }
      its (:source) { should eq 'travis_ci' }
      its (:body) { should eq 'the commit message' }
      its (:title) { should eq '[Build] minimal - #1 Passed' }
      its (:url) { should eq 'https://travis-ci.org/svenfuchs/minimal/builds/1' }
      its (:icon_url) { should =~ /gravatar/ }
      its (:status) { should eq 'success' }
      its (:author) { should eq 'Sven Fuchs' }
    end
  end
end

