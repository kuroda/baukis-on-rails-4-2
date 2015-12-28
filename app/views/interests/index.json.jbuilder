json.array!(@interests) do |interest|
  json.extract! interest, :id, :title
  json.url interest_url(interest, format: :json)
end
