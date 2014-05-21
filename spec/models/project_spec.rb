require 'spec_helper'

describe Project do
  describe 'api_key generated automatically' do
    before do
      @project = Project.create!(name: 'name')
    end
    it { @project.api_key.should_not be_empty }
  end

  describe 'find by api_key' do
    before do
      @project = Project.create!(api_key: 'abcdef')
    end
    subject { Project.with_api_key('abcdef') }
    it { should_not be_nil }
  end

  describe 'provided by dashbozu' do
    before do
      @project1 = Project.create!(provider: Project::TYPE_DASHBOZU)
      @project2 = Project.create!(provider: 'github')
    end
    subject { Project.provided_by_dashbozu }
    it { should include(@project1) }
    it { should_not include(@project2) }
  end

  describe 'without provided by dashbozu' do
    before do
      @project1 = Project.create!(provider: Project::TYPE_DASHBOZU)
      @project2 = Project.create!(provider: 'github')
    end
    subject { Project.without_provided_by_dashbozu }
    it { should_not include(@project1) }
    it { should include(@project2) }
  end

  describe 'create association' do
    before do
      @project = Project.create!
      @user = User.create!
      UserProject.delete_all(project_id: @project.id)
    end

    context 'associated not yet' do
      before do
        @project.create_association(@user)
      end
      subject { @project.users.first }
      its(:id) { should eq @user.id }
    end

    context 'already associated' do
      before do
        @project.users << @user
        @project.create_association(@user)
      end
      it { @project.users.should have(1).items }
      it { @project.users.first.id.should eq @user.id }
    end
  end

  describe 'delete association' do
    before do
      @project = Project.create!
      @user = User.create!
      UserProject.delete_all(project_id: @project.id)
      @project.users << @user
      @project.delete_association(@user)
    end
    subject { @project }
    its(:users) { should have(0).items }
  end
end
