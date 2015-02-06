# coding: utf-8
require 'rails_helper'

describe 'Dashbozu::InputEsaIo' do
  context 'post create' do
    before {
      paylaod = MultiJson.load(File.read(File.dirname(__FILE__) + '/data/esa_io/create.json'))
      @project = Project.new
      @activities = Dashbozu::InputEsaIo.new.hook(@project, paylaod)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Document] create: たいとる' }
    its(:body) { should eq "ほんぶん" }
    its(:url) { should eq "https://example.esa.io/posts/1253" }
    its(:icon_url) { should eq "http://img.esa.io/uploads/production/users/1/icon/thumb_s_402685a258cf2a33c1d6c13a89adec92.png" }
    its(:author) { should eq "fukayatsu" }
    its(:source) { should eq 'esa_io' }
  end
  context 'post update' do
    before {
      paylaod = MultiJson.load(File.read(File.dirname(__FILE__) + '/data/esa_io/update.json'))
      @project = Project.new
      @activities = Dashbozu::InputEsaIo.new.hook(@project, paylaod)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Document] update: たいとる' }
    its(:body) { should eq "ほんぶん" }
    its(:url) { should eq "https://example.esa.io/posts/1253" }
    its(:icon_url) { should eq "http://img.esa.io/uploads/production/users/1/icon/thumb_s_402685a258cf2a33c1d6c13a89adec92.png" }
    its(:author) { should eq "fukayatsu" }
    its(:source) { should eq 'esa_io' }
  end
  context 'post archive' do
    before {
      paylaod = MultiJson.load(File.read(File.dirname(__FILE__) + '/data/esa_io/archive.json'))
      @project = Project.new
      @activities = Dashbozu::InputEsaIo.new.hook(@project, paylaod)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Document] archive: Archived/たいとる' }
    its(:body) { should eq "ほんぶん" }
    its(:url) { should eq "https://example.esa.io/posts/1253" }
    its(:icon_url) { should eq "http://img.esa.io/uploads/production/users/1/icon/thumb_s_402685a258cf2a33c1d6c13a89adec92.png" }
    its(:author) { should eq "fukayatsu" }
    its(:source) { should eq 'esa_io' }
  end
  context 'post comment' do
    before {
      paylaod = MultiJson.load(File.read(File.dirname(__FILE__) + '/data/esa_io/comment.json'))
      @project = Project.new
      @activities = Dashbozu::InputEsaIo.new.hook(@project, paylaod)
    }
    subject { @activities.first }
    its(:project_id) { should eq @project.id }
    its(:title) { should eq '[Document] comment: Archived/たいとる' }
    its(:body) { should eq "こめんと" }
    its(:url) { should eq "https://example.esa.io/posts/1253#comment-6385" }
    its(:icon_url) { should eq "http://img.esa.io/uploads/production/users/1/icon/thumb_s_402685a258cf2a33c1d6c13a89adec92.png" }
    its(:author) { should eq "fukayatsu" }
    its(:source) { should eq 'esa_io' }
  end
end
