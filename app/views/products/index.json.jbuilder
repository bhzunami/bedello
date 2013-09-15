json.array!(@products) do |product|
  json.extract! product, :title, :description, :productNr, :price, :promotionPrice, :promotionStartDate, :promotionEndDate, :image, :isActivate, :inStock, :sale_start_date, :sale_end_date
  json.url product_url(product, format: :json)
end
