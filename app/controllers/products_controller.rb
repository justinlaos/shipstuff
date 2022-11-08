class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy ]

  # GET /products - will return all products 
  # GET /products?length=26&width=16&height=22&weight=50 - will return the name of a product that fits the query
  def index
    check_params_exist(params); return if performed?
    check_all_params_exist(params); return if performed?
    check_params_are_valid(params); return if performed?
    
    products = product_size_query(params[:length], params[:width], params[:height], params[:weight])

    if products.empty?
      render json: "No product fits your query. Please check its correct", status: :unprocessable_entity
    else
      render json: products.first.name, status: :ok
    end
  end

  # GET /products/1
  def show
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

    def product_size_query(length, width, height, weight)
      Product.where({'length' => {'$gte' => length.to_i}}).where({'width' => {'$gte' => width.to_i}}).where({'height' => {'$gte' => height.to_i}}).where({'weight' => {'$gte' => weight.to_i}})
    end

    def check_params_exist(params)
      if !params.values_at(:length, :width, :height, :weight).any?
        @products = Product.all
        render json: @products and return
      end
    end

    def check_params_are_valid(params)
      if params.values_at(:length, :width, :height, :weight).to_a.map{ |i| i.to_i }.include?(0)
        render json: "Not valid input. Please include only numbers larger than 0", status: :unprocessable_entity and return
      end
    end

    def check_all_params_exist(params)
      if !params.values_at(:length, :width, :height, :weight).all?(&:present?)
        render json: "Missing input. Need length, width, height, weight", status: :unprocessable_entity and return
      end
    end
end
