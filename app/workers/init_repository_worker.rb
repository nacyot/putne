class InitRepositoryWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(repo_id)
    repo = Repository.find(repo_id)

    puts "create .metrics_lock"
    `touch #{File.join(repo.workspace_path, ".git", ".metrics_lock")}`

    repo.init_repository
    repo.create_recent_report

    puts "delete .metrics_lock"
    `rm #{File.join(repo.workspace_path, ".git", ".metrics_lock")}`
  end
end


