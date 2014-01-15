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
    its(:url) { should eq 'https://bitbucket.org/marcus/project-x/' }
    its(:author) { should eq 'marcus' }
    its(:icon_url) { should =~ /gravatar/ }
    its(:source) { should eq 'bitbucket' }
  end

  describe 'extract_email' do
    subject { Dashbozu::InputBitbucket.new.send(:extract_email, 'Marcus Bertrand <marcus@somedomain.com>') }
    it { should eq 'marcus@somedomain.com' }
  end
end
