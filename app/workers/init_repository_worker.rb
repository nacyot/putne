class InitRepositoryWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(repo_id)
    repo = Repository.find(repo_id)
    repo.init_repository
    repo.create_recent_report
  end
end


