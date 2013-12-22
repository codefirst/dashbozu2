require 'spec_helper'

describe 'Dashbozu::InputNewRelic' do
  context 'hook' do
    before {
    @payload = <<PAYLOAD
{
"created_at":"2012-10-22T20:46:34+00:00",
"application_name":"Application name",
"account_name":"Account name",
"severity":"Severity",
"message":"Message about alert",
"short_description":"Short description about alert",
"long_description":"Long description about alert",
"alert_url":"http://PATH_TO_NEW_RELIC",
"version":"1.0"
}
PAYLOAD
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
      its (:title) { should eq 'Application name: Message about alert' }
      its (:url) { should eq 'http://PATH_TO_NEW_RELIC' }
      its (:status) { should eq 'alert' }
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

