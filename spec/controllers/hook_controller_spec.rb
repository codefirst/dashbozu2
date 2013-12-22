require 'spec_helper'

describe HookController do

#  context 'get' do
#    before {
#      get :hook, :format => 'json'
#    }
#    subject { response.response_code }
#    it { should eq 404 }
#  end

  context 'post' do
    context 'name not found' do
      before {
        get :hook, format: 'json', name: 'not_exist'
      }
      subject { response.response_code }
      it { should eq 404 }
    end
    context 'payload not found' do
      before {
        get :hook, format: 'json', name: 'github'
      }
      subject { response.response_code }
      it { should eq 404 }
    end
    context 'api key not found' do
      before {
        get :hook, format: 'json', name: 'github', api_key: 'invalid_key', payload: '{}'
      }
      subject { response.response_code }
      it { should eq 403 }
    end
  end

end
