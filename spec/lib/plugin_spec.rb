require 'spec_helper'

describe 'Dashbozu::Plugin' do
  context 'register_input' do
    before {
      class InputTest < Dashbozu::Input
        Dashbozu::Plugin.register_input('test', self)
        def self.scope
          :project
        end
      end
    }
    subject { Dashbozu::Plugin.input['test'] }
    its (:name) { should eq 'InputTest' }
  end

  context 'register_output' do
    before {
      class OutputTest < Dashbozu::Output
        Dashbozu::Plugin.register_output('test', self)
        def self.scope
          :project
        end
      end
    }
    subject { Dashbozu::Plugin.output['test'] }
    its (:name) { should eq 'OutputTest' }
  end

  context 'get input plugin with scope' do
    before {
      class ProjectInputTest < Dashbozu::Input
        Dashbozu::Plugin.register_input('project_test', self)
        def self.scope
          :project
        end
      end
      class UserInputTest < Dashbozu::Input
        Dashbozu::Plugin.register_input('user_test', self)
        def self.scope
          :user
        end
      end
    }
    it { Dashbozu::Plugin.project_input.values.should include ProjectInputTest }
    it { Dashbozu::Plugin.user_input.values.should include UserInputTest }
  end
end
