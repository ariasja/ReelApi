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
        'created_at' => post.created_at,
        'updated_at' => post.updated_at, 
        'user' => {
          'device_token' => post.user.device_token
        }
      }
    )
  end
end

