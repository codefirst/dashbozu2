require 'spec_helper'

describe 'Dashbozu::InputWercker' do
  context 'hook' do
    before {
      params = {
                  type: 'build',
                  result: 'passed',
                  application_name: 'example',
                  git_branch: 'master',
                  started_by: 'John Doe'
               }
      @project = Project.new
      @activities = Dashbozu::InputWercker.new.hook(@project, params)
    }
    context 'length' do
      subject { @activities }
      its (:length) { should eq 1 }
    end
    context 'first' do
      subject { @activities[0] }
      its (:source) { should eq 'wercker' }
      its (:body) { should eq 'master' }
      its (:title) { should eq '[build] example - passed' }
      its (:status) { should eq 'success' }
      its (:author) { should eq 'John Doe' }
    end
  end
end

