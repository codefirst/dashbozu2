require 'spec_helper'
describe ApplicationHelper do
  context 'strftime' do
    subject { strftime(Time.mktime(2011, 12, 24, 01, 02, 03)) }
    it { should eq '2011-12-24 01:02:03' }
  end
end
