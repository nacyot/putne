class Repository < ActiveRecord::Base
  belongs_to :project
  
  has_many :branches
  has_many :commits

  def create_workspace
    Dir.chdir Rails.root
    `mkdir -p tmp/workspace`
    Dir.chdir 'tmp/workspace'
    `git clone #{ repository_url }`
  end

  def remove_workspace
    Dir.chdir Rails.root
    `rm -rf tmp/workspace/#{ git_project_name }`
  end

  def recent_commit
    Git.new(self).head
  end

  def workspace_path
    File.join('.', 'tmp', 'workspace', git_project_name)
  end

  def git_project_name
    repository_url.split("/")[-1].split(".git")[0]
  end
end
