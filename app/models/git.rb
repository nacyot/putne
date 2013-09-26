class Git
  attr_accessor :repo, :repo_stats
  
  def initialize(repository)
    @repository = repository
    Dir.chdir Rails.root
    @repo = Grit::Repo.new @repository.workspace_path
    @repo_stats = GitStats::GitData::Repo.new(path: @repository.workspace_path)
  end

  def dates
    commits("master", nil).map { |commit| commit.date.strftime("%Y-%m-%d") }
      .group_by{|date| date}.map{|key, value| [key, value.count] }
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
  
  def commit_stats(num)
    @repo_stats || @repo_stats = @repo.commit_stats("master", 10000)
  end
  
  def commits(num = 10000)
    if @commits.nil?
      @commits = @repo.commits("master", num)
    elsif @commits.count != num
      @commits = @repo.commits("master", num)
    else
      @commits
    end
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
