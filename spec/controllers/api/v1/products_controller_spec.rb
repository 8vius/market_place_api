require 'spec_helper'

describe Api::V1::ProductsController do
  describe "GET #show" do
    before(:each) do
      @product = create(:product)
      get :show, id: @product.id
    end

    it "returns the information about a reporter on a hash" do
      product_response = json_response
      expect(product_response[:title]).to eq @product.title
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { create(:product) }
      get :index
    end

    it "returns 4 records from the database" do
      products_response = json_response
      expect(products_response[:products].count).to eq 4
    end

    it { should respond_with 200 }
  end

end