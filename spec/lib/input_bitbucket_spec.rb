require 'spec_helper'

describe 'Dashbozu::InputBitbucket' do
  context 'push' do
    before {
@payload = <<PAYLOAD
{
    "canon_url": "https://bitbucket.org",
    "commits": [
        {
            "author": "marcus",
            "branch": "master",
            "files": [
                {
                    "file": "somefile.py",
                    "type": "modified"
                }
            ],
            "message": "Added some more things to somefile.py",
            "node": "620ade18607a",
            "parents": [
                "702c70160afc"
            ],
            "raw_author": "Marcus Bertrand <marcus@somedomain.com>",
            "raw_node": "620ade18607ac42d872b568bb92acaa9a28620e9",
            "revision": null,
            "size": -1,
            "timestamp": "2012-05-30 05:58:56",
            "utctimestamp": "2012-05-30 03:58:56+00:00"
        }
    ],
    "repository": {
        "absolute_url": "/marcus/project-x/",
        "fork": false,
        "is_private": true,
        "name": "Project X",
        "owner": "marcus",
        "scm": "git",
        "slug": "project-x",
        "website": "https://atlassian.com/"
    },
    "user": "marcus"
}
PAYLOAD
      @project = Project.new
      @activities = Dashbozu::InputBitbucket.new.hook(@project, payload: @payload)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Commit] Project X - 620ade186' }
    its(:body) { should eq "Added some more things to somefile.py" }
    its(:url) { should eq 'https://bitbucket.org/marcus/project-x/commits/620ade18607ac42d872b568bb92acaa9a28620e9' }
    its(:author) { should eq 'marcus' }
    its(:icon_url) { should =~ /gravatar/ }
    its(:source) { should eq 'bitbucket' }
  end

  describe 'extract_email' do
    subject { Dashbozu::InputBitbucket.new.send(:extract_email, 'Marcus Bertrand <marcus@somedomain.com>') }
    it { should eq 'marcus@somedomain.com' }
  end

  describe 'pullrequest_created' do
    before {
@payload = <<PAYLOAD
{
  "pullrequest_created":{
      "description": "Added description",
      "links": {
        "html": {
          "href": "https://bitbucket.org/evzijst/bitbucket2/pull-request/24"
        }
      },
      "title": "PR title",
      "destination": {
        "commit": {
          "hash": "82d48819e5f7",
          "links": {
            "self": {
              "href": "https://api.bitbucket.org/2.0/repositories/evzijst/bitbucket2/commit/82d48819e5f7"
            }
          }
        },
        "branch": {
          "name": "staging"
        },
        "repository": {
          "full_name": "evzijst/bitbucket2",
          "links": {
            "self": {
              "href": "https://api.bitbucket.org/2.0/repositories/evzijst/bitbucket2"
            },
            "avatar": {
              "href": "https://bitbucket.org/m/bf1e763db20f/img/language-avatars/default_16.png"
            }
          },
          "name": "bitbucket2"
        }
      },
      "id": 24,
      "author": {
        "username": "evzijst",
        "display_name": "Erik van Zijst",
        "links": {
          "self": {
            "href": "https://api.bitbucket.org/2.0/users/evzijst"
          },
          "avatar": {
            "href": "https://bitbucket-staging-assetroot.s3.amazonaws.com/c/photos/2013/Oct/28/evzijst-avatar-3454044670-3_avatar.png"
          }
        }
      },
      "created_on": "2013-11-04T23:41:48.941334+00:00",
      "updated_on": "2013-11-08T18:55:37.272783+00:00",
      "merge_commit": null,
      "closed_by": null
    }
}
PAYLOAD
      @project = Project.new
      @activities = Dashbozu::InputBitbucket.new.hook(@project, MultiJson.load(@payload))
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Pull Request] evzijst/bitbucket2 - #24 created: PR title' }
    its(:body) { should eq 'Added description' }
    its(:url) { should eq 'https://bitbucket.org/evzijst/bitbucket2/pull-request/24' }
    its(:author) { should eq 'evzijst' }
    its(:icon_url) { should eq 'https://bitbucket-staging-assetroot.s3.amazonaws.com/c/photos/2013/Oct/28/evzijst-avatar-3454044670-3_avatar.png' }
    its(:source) { should eq 'bitbucket' }
  end

  describe 'extract_full_repo_name' do
    subject { Dashbozu::InputBitbucket.new.send(:extract_full_repo_name, '"https://bitbucket.org/evzijst/bitbucket2/pull-request/24/_/diff#comment-13"') }
    it { should eq 'evzijst/bitbucket2' }
  end

  describe 'extract_pullrequest_id' do
    subject { Dashbozu::InputBitbucket.new.send(:extract_pullrequest_id, '"https://bitbucket.org/evzijst/bitbucket2/pull-request/24/_/diff#comment-13"') }
    it { should eq '24' }
  end
end
