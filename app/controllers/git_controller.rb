# -*- coding: utf-8 -*-
class GitController < ApplicationController
  load_and_authorize_resource class: Project
  layout "layouts/sidebar"
  
  def branches
    @title = "Branches"
    @project = Project.find params[:project_id]
    @report = @project.reports.sort { |report| report.commit.committed_at }[-1]
  end

  def commits
    @title = "Commits" 
    @project = Project.find params[:project_id]
    @report = @project.reports.sort { |report| report.commit.committed_at }[-1]
    @commits = @project.repository.commits.page(params[:page]).per(10)
  end

  def committers
    @title = "Committers" 
    @project = Project.find params[:project_id]
    @report = @project.reports.sort { |report| report.commit.committed_at }[-1]
    @commits = @project.repository.commits.page(params[:page]).per(10)
  end
end
