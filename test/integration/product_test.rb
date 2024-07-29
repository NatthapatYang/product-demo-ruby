require "test_helper"

class ProductTest < ActionDispatch::IntegrationTest
  test "should able to create a product" do
    post "/products", params: { product: { name: "Coca Cola", description: "The soda water", price: 15 }}

    assert_response 302
    follow_redirect!
    assert_response 200
    assert_select 'p', 'Name: Coca Cola'
    assert_select 'p', 'Price: 15.0'
    assert_select 'p', 'Description: The soda water'
  end

  test "should not able to create a producgt if name is dupivcate" do
    post "/products", params: { product: {name: "product1",description: "aroi makmak", price: 10.0 } }

    assert_response 422
  end

  test "should able to show all producgt" do
    get "/products"

    assert_response 200
    assert_select 'div' do
      assert_select 'li', 2
    end
  end

  test "product count should increase by 1 after post create product request" do
    assert_difference "Product.count", 1 do
      post "/products", params: { product: { name: "Coca Cola", description: "The soda water", price: 15 }}
    end
  end

  test "should not create the product if the params not in product object" do
    post "/products", params: { name: "Coca Cola", description: "The soda water", price: 15 }

    assert_response 400
  end

  test "should not create the product if the name is empty" do
    post "/products", params: { product: { name: "", description: "The soda water", price: 15 }}

    assert_response 422
    assert_select 'li', "Name can't be blank"
  end

  test "should not create the product if the description is empty" do
    assert_no_difference "Product.count" do
      post "/products", params: { product: { name: "Coca cola", description: "", price: 15 }}
  
      assert_response 422
      assert_select 'li', "Description can't be blank"
    end
  end

  test "should not create the product if the description is to short" do
    assert_no_difference "Product.count" do
      post "/products", params: { product: { name: "Coca cola", description: "wr", price: 15 }}

      assert_response 422
      assert_select 'li', "Description is too short (minimum is 5 characters)"
    end
  end

  test "should not create the product if the description is to long" do
    assert_no_difference "Product.count" do
      post "/products", params: { product: { name: "Coca cola", description: "water" * 100, price: 15 }}

      assert_response 422
      assert_select 'li', "Description is too long (maximum is 19 characters)"
      end
  end

  test "should show all product at index page" do
    get "/products"

    assert_response 200
    assert_equal Nokogiri::HTML5::Document, response.parsed_body.class
  end

  test "should show individual product at show page" do
    product1 = products(:one)
    get "/products/#{product1.id}"

    assert_response 200
    assert_select 'p', "Name: product1"
    assert_select 'p', "Price: 10.0"
    assert_select 'p', "Description: aroi makmak"
  end

  test "should able to update" do
    product1 = products(:one)

    assert_changes -> { product1.reload.name }, from: "product1", to: "new_productname" do
      patch "/products/#{product1.id}", params: { product: { name: "new_productname" }}

      assert_response :redirect # 302
    end
  end

  test "should not update when name is duplicate" do
    product1 = products(:one)

    assert_no_changes -> { product1.reload.name }, from: "product1" do
      patch "/products/#{product1.id}", params: { product: { name: "product2" }}

      assert_response 422
    end
  end

  test "should able to delete" do
    product1 = products(:one)

    assert_difference "Product.count", -1 do
      delete "/products/#{product1.id}"
      assert_response :redirect
    end
  end
end