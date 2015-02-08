require 'rails_helper'

describe 'Dashbozu::InputMackerel' do
  context 'post sample' do
    before {
      paylaod = MultiJson.load(File.read(File.dirname(__FILE__) + '/data/mackerel/alert.json'))
      @project = Project.new
      @activities = Dashbozu::InputMackerel.new.hook(@project, paylaod)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Mackerel] CRITICAL: connectivity' }
    its(:body) { should eq "app01 (working)" }
    its(:url) { should eq "https://mackerel.io/orgs/.../alerts/2bj..." }
    its(:status) { should eq "error" }
    its(:source) { should eq 'mackerel' }
  end
  context 'post register' do
    before {
      paylaod = MultiJson.load(File.read(File.dirname(__FILE__) + '/data/mackerel/register.json'))
      @project = Project.new
      @activities = Dashbozu::InputMackerel.new.hook(@project, paylaod)
    }
    subject { @activities }
    its(:length) { should eq 0}
  end
end
