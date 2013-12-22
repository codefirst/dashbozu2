require 'spec_helper'

describe 'Dashbozu::Plugin' do
  context 'register_input' do
    before {
      class InputTest < Dashbozu::Input
        Dashbozu::Plugin.register_input('test', self)
      end
    }
    subject { Dashbozu::Plugin.input['test'] }
    its (:name) { should eq 'InputTest' }
  end

  context 'register_output' do
    before {
      class OutputTest < Dashbozu::Output
        Dashbozu::Plugin.register_output('test', self)
      end
    }
    subject { Dashbozu::Plugin.output['test'] }
    its (:name) { should eq 'OutputTest' }
  end
end
