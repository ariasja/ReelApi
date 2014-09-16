require 'spec_helper'

describe 'POST v1/users' do

  it 'saves id, name, email, bio, and a device_token' do

    post 'v1/users', {
      device_token: '123abc4556def',
      name: "Captain Jack Sparrow",
      username: "cjs",
      bio: "Where's all the rum gone?",
      email: "jasck_sparrow@pirates.com",
      password: "foobar",
      password_confirmation: "foobar"
    }.to_json, { 'Content-Type' => 'application/json' }

    user = User.last
    expect(response_json).to eq({ 
    'id' => user.id,
    'name' => user.name,
    'username' => user.username,
    'email' => user.email,
    'bio' => user.bio })
    expect(user.device_token).to eq '123abc4556def'
    expect(user.name).to eq "Captain Jack Sparrow"
    expect(user.email).to eq "jasck_sparrow@pirates.com"
    expect(user.bio).to eq "Where's all the rum gone?"
  end

  it 'returns an error message when invalid' do
    post 'v1/users',
    {}.to_json, { 'Content-Type' => 'application/json' }
      expect(response_json).to eq({
        'message' => 'Validation Failed',
        'errors' => [
          "Name can't be blank",
          "Email can't be blank", 
          "Email is invalid", 
          "Password can't be blank", 
          "Password is too short (minimum is 6 characters)"        
        ]
      })
    expect(response.code.to_i).to eq 422
  end
end