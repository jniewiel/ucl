# spec/factories/resumes.rb

FactoryBot.define do
  factory :resume do
    resume { "Sample resume content" }
    user
  end
end
