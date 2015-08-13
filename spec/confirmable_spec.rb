require "spec_helper"
require "confirmed_attributes/confirmable"

describe ConfirmedAttributes::Confirmable do

  before :each do
    clean_database

    @user = User.new email: "mail@mail.com"
  end

  describe ".attribute_confirmable?" do
    it "should return true" do
      expect(User.attribute_confirmable?).to eq true
    end
  end

  describe ".confirmable_attributes" do
    it "should have comfirmable_attributes method" do
      expect(@user.respond_to? :confirmable_attributes).to be true
    end

    it "should confirmable_attributes include :email" do
      expect(@user.confirmable_attributes).to include :email
    end
  end

  describe "#confirmed_attributes" do
    it "should be blank" do
      expect(@user.confirmed_attributes.blank?).to be true
    end
  end

  describe "#confirm" do
    it "should not verify attribute with not persisted record" do
      @user.confirm :email

      expect(@user.confirmed_attribute?(:email)).to be false
    end

    it "should verify attribute with persisted record" do
      @user.save
      @user.confirm :email

      expect(@user.confirmed_attribute?(:email)).to be true
      expect(@user.confirmed_attributes.count).to eq 1
    end
  end

  describe "#unconfirm" do
    it "should not unverify attribute if record is not persisted" do
      @user.confirm :email

      expect(@user.unconfirm(:email)).to be false
    end

    it "should not unverify attribute if attribute wasn't confirmed" do
      @user.save

      expect(@user.unconfirm(:email)).to be false
    end

    it "should unverify attribute" do
      @user.save
      @user.confirm :email

      expect(@user.confirmed_attribute?(:email)).to be true

      expect(@user.unconfirm(:email)).to be true

      expect(@user.confirmed_attribute?(:email)).to be false
      expect(@user.confirmed_attributes.count).to eq 0
    end
  end

end
