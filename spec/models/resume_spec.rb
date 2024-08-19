# spec/models/resume_spec.rb

require 'rails_helper'

RSpec.describe Resume, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(email: "test@example.com", password: "password")
    resume = Resume.new(resume: 'Some content', user_id: 1)
    expect(resume).to be_valid
  end

  it 'is not valid without a user' do
    resume = Resume.new(resume: 'Some content')
    expect(resume).to_not be_valid
  end

  it 'is not valid without content' do
    user = User.create(email: "test@example.com", password: "password")
    resume = Resume.new(user_id: 1)
    expect(resume).to_not be_valid
  end
end
