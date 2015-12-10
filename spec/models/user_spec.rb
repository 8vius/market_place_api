require 'spec_helper'

describe User do
  before { @user = build(:user) }
  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }

  it { should validate_presence_of(:email) }
  it { should allow_value('example@domain.com').for(:email) }
  it { should validate_uniqueness_of(:auth_token) }
  it { should validate_confirmation_of(:password) }

  it { should be_valid }

  it { should have_many(:products) }

  describe "#generate_authentication_token!" do
    it "generates a unique auth token" do
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eq "auniquetoken123"
    end

    it "generates another token when one has already been taken" do
      existing_user = create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to_not eq existing_user.auth_token
    end
  end

  describe "#products association" do
    before do
      @user.save
      3.times { FactoryGirl.create :product, user: @user }
    end

    it "destroys the associated products on self destruct" do
      products = @user.products
      @user.destroy
      products.each do |product|
        expect(Product.find(product)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
