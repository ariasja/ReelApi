json.cache! like do
  json.id like.id
  
  json.user do
    json.id like.user.id
    json.name like.user.name
    json.email like.user.email
    json.bio like.user.bio
  end  

  json.post do
    json.id like.post.id
    json.caption like.post.caption
    json.geo_lat like.post.geo_lat
    json.geo_long like.post.geo_long
  end

end