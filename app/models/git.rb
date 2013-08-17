class Git
  def initialize(project_name)
    project_path = File.join('.', 'tmp', 'workspace', project_name)
    @repo = Grit::Repo.new project_path
  end

  def stats
    @repo.commit_stats("master", 2000)        
  end
  
  def commits(num = 10)
    @repo.commits("master", 20)
  end
end
