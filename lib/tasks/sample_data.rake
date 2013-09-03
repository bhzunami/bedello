namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_categories
    make_products
  end
end


def make_users
  admin = User.create!(name: "Nicolas Mauchle",
                         email: "nmauchle@gmail.com",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)
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

  couverturen.each  do |c|
    category = Category.create!(name: c,
                                description: "Als Kuvertüre oder Couverture (von frz. couvert, „bedeckt“) wird eine Schokoladen-Grundmasse bezeichnet. Kuvertüre ist eine hochwertige Schokolade.")
  end
end


def make_products
# To be defined

end
