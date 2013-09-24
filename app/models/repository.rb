class Repository < ActiveRecord::Base
  belongs_to :project
  
  has_many :branches, dependent: :destroy
  has_many :commits, dependent: :destroy

  validates_uniqueness_of :repository_url

  def git
    #@git || (`git pull`; @git = Git.new(self))
    @git || @git = Git.new(self)
  rescue Grit::NoSuchPathError
    false
  end

  def remove_workspace
    Dir.chdir Rails.root
    `rm -rf tmp/workspace/#{ git_project_name }`
  end

  def recent_commit
    git.head.commit
  end

  def register_recent_commits
    git.commits.each do |commit|
      Commit.find_or_create_by!(repository: self,
                                commit_hash: commit.id,
                                committed_at: commit.committed_date,
                                author_name: commit.author.name,
                                author_email: commit.author.email
                                )
    end
  end
  
  def workspace_path
    Rails.root.join('.', 'tmp', 'workspace', git_project_name)
  end

  def git_project_name
    repository_url.split("/")[-1].split(".git")[0]
  end
  
  def init_repository
    create_workspace
    register_recent_commits
    branches << Branch.create!(name: "master", repository: self)
  end

  def create_recent_report
    create_report recent_commit.id
  end

  def create_all_reports
    commits.each do |commit|
      create_report commit.commit_hash
    end
  end
  
  def create_report(commit_hash)
    commit_hash = recent_commit.sha if commit_hash.nil?
    commit = Commit.find_or_create_by!(repository_id: self.id, commit_hash: commit_hash)
    branch = Branch.find_or_create_by!(repository_id: self.id, name: "master")
    report = Report.create!(project: project, repository: self, branch: branch, commit: commit)
    project.reports << report
    reset_repository commit_hash
    report.register_report #!!!!
    report.input_stats
    cancle_reset_repository

    validates_repository
  end
  
  def reset_repository(hash)
    Dir.chdir Rails.root
    Dir.chdir workspace_path
    `git reset --hard #{ hash }`
  end

  def cancle_reset_repository
    Dir.chdir Rails.root
    Dir.chdir workspace_path
    `git reflog`
    `git reset --hard HEAD@{1}`
  end
  
  def create_workspace
    Dir.chdir Rails.root
    `mkdir -p tmp/workspace`
    Dir.chdir 'tmp/workspace'
    `git clone #{ repository_url }`
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
  
end

