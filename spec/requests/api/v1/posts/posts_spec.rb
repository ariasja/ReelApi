require 'spec_helper'

describe 'GET v1/posts/:id' do
  it 'returns a post by :id' do
    
    post = create(:post)
    get "/v1/posts/#{post.id}"

    expect(response_json).to eq(
      {
        'id' => post.id,
        'caption' => post.caption,
        'geo_lat' => post.geo_lat,
        'geo_long' => post.geo_long,
        'user' => {
          'device_token' => post.user.device_token,
          'name' => post.user.name,
          'email' => post.user.email,
          'bio' => post.user.bio
        }
      }
    )
  end
end


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


describe 'PATCH /v1/posts/:id' do

  it 'updates the post attribute' do
    user = create(
      :user,
      device_token: '69696969',
      name: "Nemo Fish",
      bio: "I touched the butt",
      email: "nemo@pixar.com"
    )
    post = create(
      :post,
      caption: "Old caption"
    )

    new_caption = 'New name'

    patch "/v1/posts/#{post.id}", {
      caption: new_caption,
      geo_long: post.geo_long,
      geo_lat: post.geo_lat,
      user: post.user,
    }.to_json, { 'Content-Type' => 'application/json' }
    
    post.reload
    expect(post.caption).to eq new_caption
    expect(response_json).to eq({ 'id' => post.id })

  end

  it 'returns an error message when invalid' do
    post = create(:post)
    patch "/v1/posts/#{post.id}", {
      geo_lat: post.geo_lat,
      geo_lon: post.geo_long,
      user: nil,
      caption: post.caption
    }.to_json, { 'Content-Type' => 'application/json' }

    post.reload
    expect(post.user).to_not be nil

    expect(response_json).to eq({
    'message' => 'Validation Failed',
    'errors' => [
      "User can't be blank"
    ]
  })

  expect(response.code.to_i).to eq 422

  end
end


