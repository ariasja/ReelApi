describe 'GET /v1/posts/nearests?geo_lat=&geo_long=&radius=' do
  it 'returns the posts closest to the geo_lat and geo_long' do
    near_post = create(:post, geo_lat: 37.760322, geo_long: -122.429667)
    farther_post = create(:post, geo_lat: 37.760321, geo_long: -122.429667)
    create(:post, geo_lat: 37.687737, geo_long: -122.470608)
    geo_lat = 37.771098
    geo_long = -122.430782
    radius = 5
    get "/v1/posts/nearests?geo_lat=#{geo_lat}&geo_long=#{geo_long}&radius=#{radius}"
    expect(response_json).to eq([
      {
        'id' => near_post.id,
        'geo_lat' => near_post.geo_lat,
        'geo_long' => near_post.geo_long,
        'caption' => near_post.caption,
        'user' => { 'device_token' => near_post.user.device_token,
                    'name' => near_post.user.name,
                    'email' => near_post.user.email,
                    'bio' => near_post.user.bio 
                  },
      }, 
      {
        'id' => farther_post.id,
        'geo_lat' => farther_post.geo_lat,
        'geo_long' => farther_post.geo_long,
        'caption' => farther_post.caption,
        'user' => { 'device_token' => farther_post.user.device_token,
                    'name' => farther_post.user.name,
                    'email' => farther_post.user.email,
                    'bio' => farther_post.user.bio 
                  },
      }
    ])
  end
end