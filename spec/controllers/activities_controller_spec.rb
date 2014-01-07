require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ActivitiesController do

  before do
    @user = User.create!
    sign_in @user
  end


  # This should return the minimal set of attributes required to create a valid
  # Activity. As you add validations to Activity, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "title" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ActivitiesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns activities in a project as @activities" do
      activity = Activity.create! valid_attributes
      project = Project.create!
      project.activities << activity
      get :index, {api_key: project.api_key}, valid_session
      assigns(:activities).should eq([])
    end
  end

  describe "GET show" do
    it "assigns the requested activity as @activity" do
      activity = Activity.create! valid_attributes
      project = Project.create
      project.activities << activity
      get :show, {:id => activity.encrypted_identifier}, valid_session
      assigns(:activity).should eq(activity)
    end
  end

end
