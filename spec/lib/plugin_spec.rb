require 'spec_helper'

describe 'Dashbozu::Plugin' do
  context 'register_input' do
    before {
      class TestInput < Dashbozu::Input
        Dashbozu::Plugin.register_input('test', self)
      end
    }
    subject { Dashbozu::Plugin.input }
    its (:size) { should eq 1 }
  end

  context 'register_output' do
    before {
      class TestOutput < Dashbozu::Output
        Dashbozu::Plugin.register_output('test', self)
      end
    }
    subject { Dashbozu::Plugin.output }
    its (:size) { should eq 1 }
  end
end
