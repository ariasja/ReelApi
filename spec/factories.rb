FactoryGirl.define do
  sequence :geo_lat do |n|
    "#{n}.0".to_f
  end

  sequence :geo_long do |n|
    "#{n}.0".to_f
  end

  sequence :name do |n|
    "name #{n}"
  end

  sequence :username do |n|
    "username #{n}"
  end

  sequence :email do |n|
    "#{n}@example.com"
  end

  sequence :bio do |n|
    "Bio: #{n}"
  end

  sequence :password do |n|
    "password"
  end

  sequence :password_confirmation do |n|
    "password"
  end

  sequence :caption do |n|
    "Caption: #{n}"
  end

  sequence :token do
    SecureRandom.hex(3)
  end

  factory :post do
    geo_lat
    geo_long
    caption
    user
  end

  factory :user do
    name
    username
    email
    bio
    device_token { generate(:token) }
    password
    password_confirmation
  end

  factory :like do
    post
    user
  end
end