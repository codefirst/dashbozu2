require 'rails_helper'

describe 'Dashbozu::InputDploy' do
  context 'post deployment' do
    before {
      json = File.read(File.dirname(__FILE__) + '/data/dploy/post_deployment.json')
      @project = Project.new
      @activities = Dashbozu::InputDploy.new.hook(@project, json => nil)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Deploy] dashbozu2 - 58e79969c : server example' }
    its(:body) { should eq "comment example" }
    its(:author) { should eq 'John Smith' }
    its(:icon_url) { should =~ /gravatar/ }
    its(:source) { should eq 'dploy' }
  end
end

