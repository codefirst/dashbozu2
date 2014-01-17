require 'spec_helper'

describe 'Dashbozu::InputJenkins' do
  context 'build' do
    before {
@payload = <<PAYLOAD
{
  "name":"test",
  "url":"JobUrl",
  "build":{
    "number":1,
    "phase":"COMPLETED",
    "status":"FAILURE",
    "url":"job/project/5",
    "full_url":"http://ci.jenkins.org/job/project/5",
    "parameters":{"branch":"master"}
  }
}
PAYLOAD
      p = MultiJson.load(@payload)
      @project = Project.new
      @activities = Dashbozu::InputJenkins.new.hook(@project, p)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Build] test - #1 Failure' }
    #its(:body) { should eq "" }
    its(:url) { should eq 'http://ci.jenkins.org/job/project/5' }
    its(:author) { should eq 'job/project/5' }
    its(:status) { should eq 'error' }
    its(:source) { should eq 'jenkins' }
  end

end
