class Git
  def initialize(repository)
    @repository = repository
    @repo = Grit::Repo.new @repository.workspace_path
  end

  def stats
    @repo.commit_stats("master", 2000)        
  end
  
  def commits(num = 10)
    @repo.commits("master", 20)
  end

  def head
    @repo.commits.first
  end

  def branches
    @repo.branches
  end
end
