json.array!(@activities) do |activity|
  json.extract! activity, :id, :title, :body, :source, :project_id, :url, :icon_url, :status, :author
  json.url activity_url(activity.encrypted_identifier, format: :json)
end
