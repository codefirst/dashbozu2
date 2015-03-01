require 'rails_helper'

describe TopHelper, type: :helper do
  before do
    allow(ENV).to receive(:[]).and_call_original
  end
  describe "github?" do
    it "return false" do
      expect(helper.github?).to eq(false)
    end
  end
  describe "bitbucket?" do
    it "return false" do
      expect(helper.bitbucket?).to eq(false)
    end
  end
end
