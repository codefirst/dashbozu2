require 'spec_helper'

describe 'Dashbozu::InputDploy' do
  context 'post deployment' do
    before {
      params = mock
      params.stub(:keys) { [File.read(File.dirname(__FILE__) + '/data/dploy/post_deployment.json')] }
      @project = Project.new
      @activities = Dashbozu::InputDploy.new.hook(@project, params)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Deploy] dashbozu2 - #5 : server example' }
    its(:body) { should eq "comment example" }
    its(:author) { should eq 'John Smith' }
    its(:source) { should eq 'dploy' }
  end
end

