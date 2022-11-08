require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = Product.first
  end

  test "should get index" do
    get products_url, as: :json
    assert_response :success
  end

  test "should get index with correct params" do
    get products_url + "?length=26&width=16&height=22&weight=50", as: :json
    assert_response :success
  end

  test "should get product with correct params that fits params" do
    get products_url + "?length=26&width=16&height=22&weight=50", as: :json
    json_response = response.body
    assert_equal "Checked Bag", json_response
  end

  test "should NOT get product with incorrect params" do
    get products_url + "?length=test&width=16&height=22&weight=50", as: :json
    json_response = response.body
    assert_equal "Not valid input. Please include only numbers larger than 0", json_response
  end

  test "should NOT get product with not all params" do
    get products_url + "?&width=16&height=22&weight=50", as: :json
    json_response = response.body
    assert_equal "Missing input. Need length, width, height, weight", json_response
  end

  test "should NOT get product with correct params but not product that fits" do
    get products_url + "?length=12&width=160&height=220&weight=500 ", as: :json
    json_response = response.body
    assert_equal "No product fits your query. Please check its correct", json_response
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: { product: { height: @product.height, length: @product.length, name: @product.name, type: @product.type, weight: @product.weight, width: @product.width } }, as: :json
    end

    assert_response :created
  end

  test "should show product" do
    get product_url(@product), as: :json
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { height: @product.height, length: @product.length, name: @product.name, type: @product.type, weight: @product.weight, width: @product.width } }, as: :json
    assert_response :success
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product), as: :json
    end

    assert_response :no_content
  end
end
