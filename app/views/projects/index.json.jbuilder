json.array!(@projects) do |project|
  json.extract! project, :id, :name, :created_by
  json.url project_url(project, format: :json)
end
