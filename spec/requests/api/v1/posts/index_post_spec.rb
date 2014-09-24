require 'spec_helper'

describe 'GET v1/users/:id/posts' do
  it 'returns a users posts base on user :id' do
    user = create(
      :user,
      device_token: '69696969',
      name: "Nemo Fish",
      bio: "I touched the butt",
      email: "nemo@pixar.com"
    )
    post1 = create(
      :post,
      caption: "Caption1",
      user_id: user.id
    )
    post2 = create(
      :post,
      caption: "Caption2",
      user_id: user.id
    )

    get "v1/users/#{user.id}/posts"
    expect(response_json).to eq(
    [
      {
        'id' => post2.id,
        'caption' => post2.caption,
        'geo_lat' => post2.geo_lat,
        'geo_long' => post2.geo_long,
        'user_id' => post2.user_id,
        'folder_id' => post2.folder_id
      },
      {
        'id' => post1.id,
        'caption' => post1.caption,
        'geo_lat' => post1.geo_lat,
        'geo_long' => post1.geo_long,
        'user_id' => post1.user_id,
        'folder_id' => post1.folder_id
      }
    ])
  end
end

