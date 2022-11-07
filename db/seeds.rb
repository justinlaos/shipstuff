products = JSON.parse(File.read('db/products.json'))
products["products"].each do |product|
    Product.create!(product)
end