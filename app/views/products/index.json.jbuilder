json.array!(@products) do |product|
  json.extract! product, :title, :description, :product_nr, :price, :promotionPrice, :promotionStartDate, :promotionEndDate, :image, :isActivate, :inStock, :sale_start_date, :sale_end_date
  json.url product_url(product, format: :json)
end
