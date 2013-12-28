require 'spec_helper'

describe Activity do
  describe 'add encrypted identifier before save' do
    before do
      @activity = Activity.create!
      project = Project.create!
      project.activities << @activity
    end
    subject { @activity }
    its(:identifier) { should_not be_nil }
    its(:encrypted_identifier) { should_not be_nil }
  end
end
