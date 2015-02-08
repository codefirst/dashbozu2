require 'rails_helper'

describe 'Dashbozu::InputSunline' do
  context 'execution' do
    before {
@payload = <<PAYLOAD
{
  "script": {
    "name":"test script",
    "body":"ls -l",
    "created_by_id":1,
    "updated_by_id":1,
    "archived":null,
    "created_at":"2014-01-22T11:53:58.257Z",
    "updated_at":"2014-01-22T11:53:58.257Z"
  },
  "log":{
    "host":"test.example.com",
    "result":"1\\n2\\n3\\n4\\n5\\n",
    "created_at":"2014-01-22T11:54:11.752Z",
    "updated_at":"2014-01-22T11:54:11.752Z",
    "memo":null
  },
  "url": "http://example.com/log/1"
}
PAYLOAD
      @project = Project.new
      @activities = Dashbozu::InputSunline.new.hook(@project, payload: @payload)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Sunline] test script - test.example.com' }
    its(:body) { should eq "3\n4\n5" }
    its(:url) { should eq "http://example.com/log/1" }
    its(:author) { should eq nil }
    its(:icon_url) { should eq nil }
    its(:source) { should eq 'sunline' }
  end
end
