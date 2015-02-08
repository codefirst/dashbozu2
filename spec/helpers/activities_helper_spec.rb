require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ActivitiesHelper. For example:
#
# describe ActivitiesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ActivitiesHelper, type: :helper do
  context 'activity_source_image_url' do
    before { @activity = Activity.new(source: 'github') }
    subject { activity_source_image_url(@activity) }
    it { should eq '/images/github.png' }
  end
end
