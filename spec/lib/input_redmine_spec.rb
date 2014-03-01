require 'spec_helper'

describe 'Dashbozu::InputRedmine' do
  context 'create' do
    before {
      @payload = MultiJson.load(File.read(File.dirname(__FILE__) + '/data/redmine/opened.json'))
      @project = Project.new
      @activities = Dashbozu::InputRedmine.new.hook(@project, @payload)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Issue] Test Project - #191 opened: Found a bug' }
    its(:body) { should eq "I'm having a problem with this." }
    its(:url) { should eq 'https://example.com' }
    its(:author) { should eq 'test' }
    its(:icon_url) { should =~ /gravatar/ }
    its(:source) { should eq 'redmine' }
  end

  context 'create' do
    before {
      @payload = MultiJson.load(File.read(File.dirname(__FILE__) + '/data/redmine/updated.json'))
      @project = Project.new
      @activities = Dashbozu::InputRedmine.new.hook(@project, @payload)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Issue] Test Project - #196 updated: Found a bug' }
    its(:body) { should eq "Fixed" }
    its(:url) { should eq 'https://example.com' }
    its(:author) { should eq 'test' }
    its(:icon_url) { should =~ /gravatar/ }
    its(:source) { should eq 'redmine' }
  end
end
