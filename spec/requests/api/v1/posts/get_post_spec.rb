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
        'user_id' => post.user_id,
        'folder_id' => post.folder_id
      }
    )
  end
end