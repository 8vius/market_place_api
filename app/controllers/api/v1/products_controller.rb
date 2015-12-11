class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]
  respond_to :json

  def show
    @product = Product.find(params[:id])
    render :show, status: :ok
  end

  def index
    @products = Product.all
    render :index, status: :ok
  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save
      render :show, status: :created
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity
    end
  end

  def update
    @product = current_user.products.find(params[:id])

    if @product.update(product_params)
      render :show, status: :ok
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    product = current_user.products.find(params[:id])
    product.destroy
    head :no_content
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :user_id)
  end
end
