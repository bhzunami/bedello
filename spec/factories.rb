FactoryGirl.define do
  factory :user do
    name     "Nicolas Mauchle"
    email    "nmauchle@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end