class ProductsController < ApplicationController
  before_action :set_product, only: %i[ update destroy ]

  

  # GET /products
  def index
    @products = Product.all

    render json: @products
  end

  # GET /products/?height=42&length=42&width=42&weight=42&name=42&type=42
  def show
    # recommended_product = find_product_fit(params[:height])
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :type, :length, :width, :height, :weight)
    end

    def find_product_fit(:length, :width, :height, :weight)

    end
end
