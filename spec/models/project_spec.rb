require 'spec_helper'

describe Project do
  describe 'api_key generated automatically' do
    before do
      @project = Project.create!(name: 'name')
    end
    it { @project.api_key.should_not be_empty }
  end

  describe 'find by api_key' do
    before do
      @project = Project.create!(api_key: 'abcdef')
    end
    subject { Project.with_api_key('abcdef') }
    it { should_not be_nil }
  end
end
