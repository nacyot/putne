class Git
  attr_accessor :repo, :stat
  
  def initialize(repository)
    @repository = repository
    Dir.chdir Rails.root
    @repo = Grit::Repo.new @repository.workspace_path
    @stat = GitStats::GitData::Repo.new(path: @repository.workspace_path)
  end

  def dates
    @repo.commits("master", nil).map { |commit| commit.date.strftime("%Y-%m-%d") }
      .group_by{|date| date}.map{|key, value| [key, value.count] }
  end
  
  def blob(sha, path)
    #@repo.tree(@repo.commit(sha), path)
    @repo.tree([path])
  end
  
  def stats
    @repo.commit_stats("master", 2000)        
  end
  
  def commits(num = 10)
    @repo.commits("master", num)
  end

  def branches
    @repo.branches
  end

  def last_commit
    @repo.commits.first
  end
  
  def head
    @repo.head
  end
end
