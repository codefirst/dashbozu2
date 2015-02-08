require 'rails_helper'

describe 'Dashbozu::InputWercker' do
  context 'hook' do
    before {
      params = {
                  type: 'build',
                  result: 'passed',
                  application_name: 'example',
                  build_url: 'http://wercker.com/hogehoge',
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
      its (:title) { should eq '[Build] example - passed' }
      its (:url) { should eq 'http://wercker.com/hogehoge' }
      its (:status) { should eq 'success' }
      its (:author) { should eq 'John Doe' }
    end
  end
end

