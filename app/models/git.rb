class Git
  def initialize(project)
    @project = project
    @repo = Grit::Repo.new @project.project_git_path
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
