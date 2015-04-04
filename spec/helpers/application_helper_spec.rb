require 'rails_helper'
describe ApplicationHelper, type: :helper do
  context 'strftime' do
    subject { strftime(Time.mktime(2011, 12, 24, 01, 02, 03)) }
    it { should eq '2011-12-24 01:02:03' }
  end

  context 'icon_link_to' do
    subject { icon_link_to('test', 'http://example.com', 'user', method: :delete) }
    it { should eq '<a data-method="delete" href="http://example.com" rel="nofollow"><i class="icon-user"></i> test</a>' }
  end

  context 'title' do
    context 'is empty' do
      subject { title('') }
      it { is_expected.to eq('Dashbozu') }
    end

    context 'is nil' do
      subject { title(nil) }
      it { is_expected.to eq('Dashbozu') }
    end

    context 'is "Profile"' do
      subject { title('Profile') }
      it { is_expected.to eq('Profile - Dashbozu') }
    end
  end
end
