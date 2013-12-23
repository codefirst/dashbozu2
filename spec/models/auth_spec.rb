require 'spec_helper'

describe Auth do
  before do
    @authhash= OmniAuth::AuthHash.new({
      "provider" => "github",
      "uid" => "1",
      "info" => {
        "emial" => "test@example.com",
        "image" => "http://example.com/test.png",
        "name" => "Test User",
        "nickname" => "test"
      }
    })
  end

  describe 'get or create by authhash' do
    context 'first login' do
      before do
        Auth.delete_all(provider: 'github', uid: '1')
      end
      subject { Auth.get_or_create_by_authhash(@authhash) }
      its(:uid) { should eq '1' }
    end
    context 'second login' do
      before do
        Auth.delete_all(provider: 'github', uid: '1')
        Auth.create!(provider: 'github', uid: '1')
      end
      subject { Auth.get_or_create_by_authhash(@authhash) }
      its(:uid) { should eq '1' }
    end  end
end
