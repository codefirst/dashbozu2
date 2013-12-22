require 'spec_helper'

describe Project do
  describe 'api_key generated automatically' do
    before do
      @project = Project.new(name: 'name')
      @project.save
    end
    it { @project.api_key.should_not be_empty }
  end
end
