class ReportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(repo_id, hash)
    repo = Repository.find repo_id
    repo.create_report hash
  end
end


