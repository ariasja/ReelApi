require 'spec_helper'

describe 'GET v1/users/:id' do
  it 'returns a user by :id' do
    
    user = create(:user)
    get "/v1/users/#{user.id}"

    expect(response_json).to eq(
      {
        'id' => user.id,
        'name' => user.name,
        'username' => user.username,
        'email' => user.email,
        'bio' => user.bio,
        'device_token' => user.device_token
      }
    )
  end
end