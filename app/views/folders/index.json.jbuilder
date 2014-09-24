json.array!(@folders) do |folder|
  json.extract! folder, :id, :title, :user_id
  json.url folder_url(folder, format: :json)
end
