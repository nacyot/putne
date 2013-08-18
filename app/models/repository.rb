class Repository < ActiveRecord::Base
  belongs_to :project
  
  has_many :branches
  has_many :commits

  after_create :init_repository

  def git
    @git || @git = Git.new(self)
  rescue Grit::NoSuchPathError
    false
  end
  
  def create_workspace
    Dir.chdir Rails.root
    `mkdir -p tmp/workspace`
    Dir.chdir 'tmp/workspace'
    `git clone #{ repository_url }`

    validates_repository
  end

  def validates_repository
    Dir.chdir Rails.root
    Grit::Repo.new workspace_path
    update_attribute(:valida, true)
  rescue Grit::InvalidGitRepositoryError
    update_attribute(:valida, false)
  rescue Grit::NoSuchPathError
    update_attribute(:valida, false)
  end
  
  def remove_workspace
    Dir.chdir Rails.root
    `rm -rf tmp/workspace/#{ git_project_name }`
  end

  def recent_commit
    git.head.commit
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
    commits << Commit.create!(commit_hash: recent_commit.id, repository: self)
  end


end
