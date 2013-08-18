class Git
  def initialize(project_name, repository_url = "")
    project_path = File.join('.', 'tmp', 'workspace', project_name)

    # unless Dir.exists? projet_path

    # end
    
    @repo = Grit::Repo.new project_path
  end

  def create_workspace
    Dir.chdir Rails.root
    `mkdir -p tmp/workspace`
    Dir.chdir 'tmp/workspace'
    `git clone #{ project.repository_url }`
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
