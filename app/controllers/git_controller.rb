class GitController < ApplicationController
  def branches
    @project = Project.find params[:project_id]
  end

  def commits
    @project = Project.find params[:project_id]
    repo = Grit::Repo.new("./tmp/workspace/resque/")
    @commits = repo.commits("master", 5)
  end
end
