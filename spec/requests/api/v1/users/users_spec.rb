require 'spec_helper'

describe 'GET v1/users/:id' do
  it 'returns a user by :id' do
    
    user = create(:user)
    get "/v1/users/#{user.id}"

    expect(response_json).to eq(
      {
        'id' => user.id,
        'name' => user.name,
        'email' => user.email,
        'bio' => user.bio,
        'device_token' => user.device_token
      }
    )
  end
end

describe 'POST v1/users' do

  it 'saves id, name, email, bio, and a device_token' do

    post 'v1/users', {
      device_token: '123abc4556def',
      name: "Captain Jack Sparrow",
      bio: "Where's all the rum gone?",
      email: "jasck_sparrow@disney.com"
    }.to_json, { 'Content-Type' => 'application/json' }

    user = User.last
    expect(response_json).to eq({ 'id' => user.id })
    expect(user.device_token).to eq '123abc4556def'
    expect(user.name).to eq "Captain Jack Sparrow"
    expect(user.email).to eq "jasck_sparrow@disney.com"
    expect(user.bio).to eq "Where's all the rum gone?"
  end

  it 'returns an error message when invalid' do
    post 'v1/users',
    {}.to_json, { 'Content-Type' => 'application/json' }
      expect(response_json).to eq({
        'message' => 'Validation Failed',
        'errors' => [
          "Name can't be blank",
          "Email can't be blank"
        ]
      })
    expect(response.code.to_i).to eq 422
  end
end