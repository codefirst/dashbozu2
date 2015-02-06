require 'rails_helper'

describe 'Dashbozu::InputTrello' do
  context 'post sample' do
    before {
      paylaod = MultiJson.load(File.read(File.dirname(__FILE__) + '/data/trello/sample.json'))
      @project = Project.new
      @activities = Dashbozu::InputTrello.new.hook(@project, 'hook' => paylaod)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Card] Trello Development - #1458 : Webhooks' }
    its(:body) { should eq "voteOnCard" }
    its(:url) { should eq "https://trello.com/b/nC8QJJoZ/trello-development" }
    its(:author) { should eq 'doug' }
    its(:icon_url) { should eq 'https://trello-avatars.s3.amazonaws.com/2da34d23b5f1ac1a20e2a01157bfa9fe/30.png' }
    its(:source) { should eq 'trello' }
  end
  context 'post empty' do
    before {
      @project = Project.new
      @activities = Dashbozu::InputTrello.new.hook(@project, {})
    }
    subject { @activities }
    its(:empty?) { should be true }
   end
end

