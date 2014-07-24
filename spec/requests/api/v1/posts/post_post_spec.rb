require 'spec_helper'

describe 'POST v1/posts' do

  it 'saves id, caption, geo_lat, geo_long, and a user_id' do
    device_token = '123abc4556def'
    user = create(
      :user,
      device_token: device_token,
      name: "Misty Gish",
      bio: "Girls being girls being girls being girls",
      email: "misty_gish@cutiepatooties.com"
    )
    post 'v1/posts', {
      geo_long: 2.5,
      geo_lat: 2.5,
      caption: "POST post",
      user: {
        device_token: device_token,
        name: "Misty Gish",
        bio: "Girls being girls being girls being girls",
        email: "misty_gish@cutiepatooties.com"
      }
    }.to_json, { 'Content-Type' => 'application/json' }

    post = Post.last
    expect(response_json).to eq({ 'id' => post.id })
    expect(post.geo_lat).to eq 2.5
    expect(post.geo_long).to eq 2.5
    expect(post.caption).to eq "POST post"
    expect(post.user).to eq user
  end

  it 'returns an error message when invalid' do
    post 'v1/posts',
    {}.to_json, { 'Content-Type' => 'application/json' }
      expect(response_json).to eq({
        'message' => 'Validation Failed',
        'errors' => [
          "User can't be blank",
        ]
      })
    expect(response.code.to_i).to eq 422
  end
end