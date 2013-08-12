json.array!(@projects) do |project|
  json.extract! project, :title, :description, :language, :repository_type, :repository_url
  json.url project_url(project, format: :json)
end
