json.array!(@reports) do |report|
  json.extract! report, :repository_id, :branch_id, :commit_id, :project_id
  json.url report_url(report, format: :json)
end
