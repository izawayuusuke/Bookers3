FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number:20) }
    password { 'password' }
    password_confirmation { 'password' }
    postal_code { 5600000 }
    prefecture_code { 'テスト県' }
    address_city { 'テスト市' }
    address_street { 'テスト町1丁目' }
  end
end
