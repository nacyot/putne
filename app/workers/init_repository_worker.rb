class InitRepositoryWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(repo_id)
    @repo = Repository.find(repo_id)

    puts "create .metrics_lock"

    @repo.create_workspace
    create_lock
    @repo.init_repository

    in_time = 5
    @repo.commits.each do |commit|
      if Report.find_by(commit_id: commit.id.to_s).nil?
        ReportWorker.perform_in in_time, @repo.id, commit.commit_hash
        in_time += 120
      end
    end

    puts "delete .metrics_lock"
    remove_lock

  end

  def create_lock
    `touch #{File.join(@repo.workspace_path, ".git", ".metrics_lock")}`
  end

  def remove_lock
    `rm #{File.join(@repo.workspace_path, ".git", ".metrics_lock")}`
  end
end


