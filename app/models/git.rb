class Git
  attr_accessor :repo
  
  def initialize(repository)
    @repository = repository
    Dir.chdir Rails.root
    @repo = Grit::Repo.new @repository.workspace_path
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
