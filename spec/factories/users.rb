# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    password { "password123" }
  end
end
