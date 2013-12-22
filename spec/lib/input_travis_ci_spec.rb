require 'spec_helper'

describe 'Dashbozu::InputTravisCI' do
  context 'hook' do
    before {
    @payload = <<PAYLOAD
  {
    "id": 1,
    "number": 1,
    "status": null,
    "started_at": null,
    "finished_at": null,
    "status_message": "Passed",
    "commit": "62aae5f70ceee39123ef",
    "branch": "master",
    "message": "the commit message",
    "compare_url": "https://github.com/svenfuchs/minimal/compare/master...develop",
    "committed_at": "2011-11-11T11: 11: 11Z",
    "committer_name": "Sven Fuchs",
    "committer_email": "svenfuchs@artweb-design.de",
    "author_name": "Sven Fuchs",
    "author_email": "svenfuchs@artweb-design.de",
    "repository": {
      "id": 1,
      "name": "minimal",
      "owner_name": "svenfuchs",
      "url": "http://github.com/svenfuchs/minimal"
     },
    "matrix": [
      {
        "id": 2,
        "repository_id": 1,
        "number": "1.1",
        "state": "created",
        "started_at": null,
        "finished_at": null,
        "config": {
          "notifications": {
            "webhooks": ["http://evome.fr/notifications", "http://example.com/"]
          }
        },
        "status": null,
        "log": "",
        "result": null,
        "parent_id": 1,
        "commit": "62aae5f70ceee39123ef",
        "branch": "master",
        "message": "the commit message",
        "committed_at": "2011-11-11T11: 11: 11Z",
        "committer_name": "Sven Fuchs",
        "committer_email": "svenfuchs@artweb-design.de",
        "author_name": "Sven Fuchs",
        "author_email": "svenfuchs@artweb-design.de",
        "compare_url": "https://github.com/svenfuchs/minimal/compare/master...develop"
      }
    ]
  }
PAYLOAD
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
      its (:title) { should eq 'Passed' }
      its (:url) { should eq 'https://travis-ci.org/svenfuchs/minimal/builds/1' }
      its (:status) { should eq 'success' }
      its (:author) { should eq 'Sven Fuchs' }
    end
  end
end

