json.array!(@projects) do |project|
  json.extract! project, :id, :name, :api_key
  json.url project_url(project, format: :json)
end
