class ReportWorker
  include Sidekiq::Worker

  def perform(repo)
    repo.init_repository
    repo.create_recent_report
  end
end


