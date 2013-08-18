class Repository < ActiveRecord::Base
  belongs_to :project
  
  has_many :branches
  has_many :commits

  after_create :init_repository

  def git
    @git || @git = Git.new(self)
  end
  
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
    git.head
  end

  def workspace_path
    File.join('.', 'tmp', 'workspace', git_project_name)
  end

  def git_project_name
    repository_url.split("/")[-1].split(".git")[0]
  end
  
  def init_repository
    create_workspace
    branches << Branch.create!(name: "master", repository: self)
    commites << Commit.create!(commit_hash: recent_commit.id, repository: self)
  end
end
