require 'rails_helper'

describe 'Dashbozu::InputErrbit' do
  context 'hook' do
    before {
    @payload = <<PAYLOAD
{
  "url": "https://example.com",
  "_id":"51e377fd523c72000c00012a",
  "app_id":"51e377fc523c72000c000002",
  "app_name":"Self.Errbit",
  "comments_count":0,
  "created_at":"2013-07-15T04:18:05Z",
  "environment":"production",
  "error_class":"Sprockets::FileNotFound",
  "first_notice_at":"2013-07-15T04:52:21+00:00",
  "hosts":{
    "8a07435a83be18a91f7987cc43d1d2b1":{
      "value":"errbit.example.com",
      "count":19
    }
  },
  "issue_link":null,
  "issue_type":null,
  "last_deploy_at":null,
  "last_notice_at":"2013-07-15T04:52:21+00:00",
  "message":"Sprockets::FileNotFound: couldn't find file 'jquery' (in /app/app/assets/javascripts/application.js.erb:2)",
  "messages":{
    "816817992a7ca753073b1cb651f64829":{
      "value":"Sprockets::FileNotFound: couldn't find file 'jquery' (in /app/app/assets/javascripts/application.js.erb:2)",
      "count":19
    }
  },
  "notices_count":19,
  "resolved":true,
  "resolved_at":"2013-07-15T14:45:33Z",
  "updated_at":"2013-07-15T14:45:33Z",
  "user_agents":{
    "d089610a8db08b72da93c9f7a1e78b98":{
      "value":"Chrome 29.0.1547.15 (OS X 10.7.5)",
      "count":19
    }
  },
  "where":"devise/sessions#new"
}
PAYLOAD
      @project = Project.new
      @activities = Dashbozu::InputErrbit.new.hook(@project, problem: @payload)
    }
    context 'length' do
      subject { @activities }
      its (:length) { should eq 1 }
    end
    context 'first' do
      subject { @activities[0] }
      its (:source) { should eq 'errbit' }
      its (:body) { should eq "Sprockets::FileNotFound: couldn't find file 'jquery' (in /app/app/assets/javascripts/application.js.erb:2)" }
      its (:url) { should eq "https://example.com" }
      its (:title) { should eq '[Error] Self.Errbit - Sprockets::FileNotFound' }
      its (:status) { should eq 'error' }
      its (:author) { should eq 'devise/sessions#new' }
    end
  end
end

