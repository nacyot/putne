class Git
  attr_accessor :repo, :repo_stats
  
  def initialize(repository)
    @repository = repository
    Dir.chdir Rails.root
    @repo = Grit::Repo.new @repository.workspace_path
    @repo_stats = GitStats::GitData::Repo.new(path: @repository.workspace_path)
  end

  def dates
    tmp = commits("master", 500)
    tmp = map { |commit| commit.date.strftime("%Y-%m-%d") }
    tmp = tmp.group_by{|date| date}
    tmp.map{|key, value| [key, value.count] }
  end

  def dates_csv
    CSV.generate do |csv|
      csv << %w(date value)
      dates.each { |line| csv << line }
    end
  end
  
  def blob(sha, path)
    #@repo.tree(@repo.commit(sha), path)
    @repo.tree([path])
  end
  
  def commit_stats(num = 10000)
    @repo.commit_stats("master", 10000)
  end
  
  def commits(branch = "master", num = 10)
    @repo.commits(branch, num) 
  end

  def branches
    @repo.branches
  end

  def last_commit
    commits.first
  end
  
  def head
    @repo.head
  end

  def count
    commits.count
  end
end
