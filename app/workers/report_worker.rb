class ReportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(repo_id, hash)
    repo = Repository.find repo_id
    lock = File.join(repo.workspace_path, ".git", ".metrics_lock")

    0.upto(30) do
      unless File.exists?(lock)
        puts "create .metrics_lock"
        `touch #{lock}`

        repo.create_report hash

        puts "delete .metrics_lock"
        `rm #{lock}`
        break
      else
        puts "This repository locked. #{repo.workspace_path}"
        sleep 5
      end
    end
  ensure
    puts "delete .metrics_lock"
    `rm #{lock}`
  end
  
end


