FactoryGirl.define do

  factory :product do
    title { FFaker::Product.product_name }
    price { rand() * 100 }
    published false
    user
  end

  factory :user do
    email { FFaker::Internet.email }
    password "12345678"
    password_confirmation "12345678"
  end
end
