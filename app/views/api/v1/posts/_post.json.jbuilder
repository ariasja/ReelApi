json.cache! post do
  json.id post.id
  json.caption post.caption
  json.geo_lat post.geo_lat
  json.geo_long post.geo_long
  json.created_at post.created_at
  json.updated_at post.updated_at

  json.user do
    json.device_token post.user.device_token
    json.name post.user.name
    json.email post.user.email
    json.bio post.user.bio
  end
end