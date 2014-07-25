require 'spec_helper'

describe 'GET /v1/posts/#{post_id}/likes' do
  it 'lists all the likes for a post with id=post_id'do
    user1 = create(:user, name: "User One")
    user2 = create(:user, name: "User Two")
    post = create(:post, caption: "Post with 2 Likes!")

    like1 = create(:like, post: post, user: user1)
    like2 = create(:like, post: post, user: user2)

    get "v1/posts/#{post.id}/likes"
    expect(response_json).to eq([
      {
        "id" => like1.id,
        "user" => {
                    "id" => like1.user.id,
                    "name" => like1.user.name,
                    "email" => like1.user.email,
                    "bio" => like1.user.bio
                  },
        "post" => {
                    "id" => like1.post.id,
                    "caption" => like1.post.caption,
                    "geo_lat" => like1.post.geo_lat,
                    "geo_long" => like1.post.geo_long
                  }
      },
      {
        "id" => like2.id,
        "user" => {
                    "id" => like2.user.id,
                    "name" => like2.user.name,
                    "email" => like2.user.email,
                    "bio" => like2.user.bio
                  },
        "post" => {
                    "id" => like2.post.id,
                    "caption" => like2.post.caption,
                    "geo_lat" => like2.post.geo_lat,
                    "geo_long" => like2.post.geo_long
                  }
      }
    ])


  end
end