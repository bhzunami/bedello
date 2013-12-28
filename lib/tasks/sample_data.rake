# -*- coding: utf-8 -*-
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    require 'faker'
    make_users
    make_categories
    make_products
    make_shipments
    make_payments
  end
end


def make_users
  admin = User.create!(name: "Nicolas Mauchle",
                         email: "nmauchle@gmail.com",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)

  admin_bedello = User.create!(name: "Bedello",
                         email: "j.bechtel@vtxmail.ch",
                         password: "bedello1234",
                         password_confirmation: "bedello1234",
                         admin: true)
  20.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@test.ch"
    password = "foobar"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password )
  end
end

def make_categories
  couverturen = ["Couverturen",
                 "Hohlkugeln",
                 "Trempiergabeln",
                 "Thermometer",
                 "Tortenzubehör",
                 "Dressiersäcke",
                 "Verpackungen",
                 "Gianduja",
                 "Marzipan",
                 "Diverses"]

  couverturen.each_with_index  do |c, index|
    category = Category.create!(name: c,
                                description: "Als Kuvertüre oder Couverture (von frz. couvert, „bedeckt“) wird eine Schokoladen-Grundmasse bezeichnet.",
                                category_order: index+1)
  end
end


def make_products
  10.times do |n|
    title = Faker::Commerce.product_name
    description = Faker::Lorem.paragraph(sentence_count = 5)
    productNr = Faker::Number.number(3)
    isActivate = true
    inStock = Faker::Number.digit
    sale_start_date = Time.now.to_date
    sale_end_date = (Time.now + 3.weeks).to_date
    category_id = rand(1..9)
    price = Faker::Number.number(2)
    Product.create!(title: title,
                    description: description,
                    productNr: productNr,
                    isActivate: isActivate,
                    inStock: inStock,
                    sale_start_date: sale_start_date,
                    sale_end_date: sale_end_date,
                    category_id: category_id,
                    price: price )
  end
end

def make_shipments
    name = ["Per Post",
            "wird abgeholt"]
    costs = 0.00
    name.each do |n|
        Shipment.create!(name: n, costs: costs )
    end

end

def make_payments
    name = ["Vorauszahlung",
            "per Nachnahme (+15.-)",
            "Rechnung (Stammkunde)",
            "Bar (Ware wird abgeholt)"]
    costs = [0.00,
             15.00,
             0.00,
             0.00 ]
    name.each_with_index do |n, index|
        Payment.create!(name: n, costs: costs[index] )
    end

end







