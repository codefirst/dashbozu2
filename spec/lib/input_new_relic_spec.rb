require 'rails_helper'

describe 'Dashbozu::InputNewRelic' do
  context 'hook' do
    before {
      @payload = File.read(File.dirname(__FILE__) + '/data/new_relic/alert.json')
      @project = Project.new
      @activities = Dashbozu::InputNewRelic.new.hook(@project, alert: @payload)
    }
    context 'length' do
      subject { @activities }
      its (:length) { should eq 1 }
    end
    context 'first' do
      subject { @activities[0] }
      its (:source) { should eq 'new_relic' }
      its (:body) { should eq 'Long description about alert' }
      its (:title) { should eq '[Alert] Application name - Message about alert' }
      its (:url) { should eq 'http://PATH_TO_NEW_RELIC' }
      its (:status) { should eq 'error' }
      its (:author) { should eq 'Account name' }
    end
  end
  context 'deployment' do
    before {
      @project = Project.new
      @activities = Dashbozu::InputNewRelic.new.hook(@project, deployment: '{}')
    }
    context 'length' do
      subject { @activities }
      its (:length) { should eq 0 }
    end
  end
end

