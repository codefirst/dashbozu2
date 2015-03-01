require 'rails_helper'

describe 'Dashbozu::OutputAsakusaSatellite' do
  context 'url' do
    subject { Dashbozu::OutputAsakusaSatellite.new }
    its (:url) { should eq 'TEST_URL' }
  end

  context 'make_url' do
    subject { Dashbozu::OutputAsakusaSatellite.new }
    its (:make_url) { should eq 'TEST_URL/api/v1/message.json' }
  end

  context 'make_message' do
    before {
      @activity = Activity.new(title: 'test_title')
    }
    subject { Dashbozu::OutputAsakusaSatellite.new.make_message(@activity) }
    it { should eq 'test_title' }
  end

  context 'make_body' do
    before {
      @activity = Activity.new(title: 'test_title')
      @json = {room_id: 'TEST_ROOM_ID', api_key: 'TEST_API_KEY', message: 'test_title' }
    }
    subject { Dashbozu::OutputAsakusaSatellite.new.make_body(@activity) }
    it { should eq @json }
  end
end

