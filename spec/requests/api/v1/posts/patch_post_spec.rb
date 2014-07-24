require 'spec_helper'

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