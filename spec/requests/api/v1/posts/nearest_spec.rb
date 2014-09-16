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
        'user_id' => near_post.user_id,
        'folder_id' => near_post.folder_id
      }, 
      {
        'id' => farther_post.id,
        'geo_lat' => farther_post.geo_lat,
        'geo_long' => farther_post.geo_long,
        'caption' => farther_post.caption,
        'user_id' => farther_post.user_id,
        'folder_id' => farther_post.folder_id
      }
    ])
  end
end