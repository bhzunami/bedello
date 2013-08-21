json.array!(@products) do |product|
  json.extract! product, :title, :description, :productNr, :price, :promotionPrice, :promotionStartDate, :promotionEndDate, :image, :isActivate, :inStock, :saleStartDate, :salesEndDate
  json.url product_url(product, format: :json)
end
