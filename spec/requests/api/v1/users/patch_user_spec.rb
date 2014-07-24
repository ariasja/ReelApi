require 'spec_helper'

describe 'PATCH /v1/users/:id' do

  it 'updates the user attribute' do
    user = create(
      :user,
      device_token: "a1b2c3d4",
      name: "Spiderman",
      bio: "dOeS wHaTeVeR a SpIdEr CaN",
      email: "spidy@marvel.com"
    )

    new_name = "Peter Parker"
    new_email = "peter@normalguy.com"
    new_bio = "dOeS wHaTeVeR a NoRmAl GuY cAn"

    patch "/v1/users/#{user.id}", {
      device_token: user.device_token,
      name: new_name,
      bio: new_bio,
      email: new_email,
    }.to_json, { 'Content-Type' => 'application/json' }
    
    user.reload
    expect(user.name).to eq new_name
    expect(user.bio).to eq new_bio
    expect(user.email).to eq new_email
    expect(response_json).to eq({ 'id' => user.id })

  end

  it 'returns an error message when name is blank' do
    user = create(:user)
    patch "/v1/users/#{user.id}", {
      device_token: user.device_token,
      name: nil,
      email: user.email,
      bio: user.bio
    }.to_json, { 'Content-Type' => 'application/json' }

    user.reload
    expect(user.name).to_not be nil

    expect(response_json).to eq({
    'message' => 'Validation Failed',
    'errors' => [
      "Name can't be blank"
    ]
  })

  expect(response.code.to_i).to eq 422

  end

  it 'returns an error message when name is too long' do
    user = create(:user)
    patch "/v1/users/#{user.id}", {
      device_token: user.device_token,
      name: "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz",
      email: user.email,
      bio: user.bio
    }.to_json, { 'Content-Type' => 'application/json' }

    user.reload
    expect(user.name).to_not be nil

    expect(response_json).to eq({
    'message' => 'Validation Failed',
    'errors' => [
      "Name is too long (maximum is 30 characters)"
    ]
  })

  expect(response.code.to_i).to eq 422

  end

  it 'returns an error message when email is blank' do
    user = create(:user)
    patch "/v1/users/#{user.id}", {
      device_token: user.device_token,
      name: user.name,
      email: nil,
      bio: user.bio
    }.to_json, { 'Content-Type' => 'application/json' }

    user.reload
    expect(user.email).to_not be nil

    expect(response_json).to eq({
    'message' => 'Validation Failed',
    'errors' => [
      "Email is invalid"
    ]
  })

  expect(response.code.to_i).to eq 422

  end

  it 'returns an error message when email is invalid format' do
    user = create(:user)
    patch "/v1/users/#{user.id}", {
      device_token: user.device_token,
      name: user.name,
      email: "ajs;fihjea;lkdfna;sldkjf",
      bio: user.bio
    }.to_json, { 'Content-Type' => 'application/json' }

    user.reload
    expect(user.email).to_not be nil

    expect(response_json).to eq({
    'message' => 'Validation Failed',
    'errors' => [
      "Email is invalid"
    ]
  })

  expect(response.code.to_i).to eq 422

  end

end