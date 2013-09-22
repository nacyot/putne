# -*- coding: utf-8 -*-
class GitController < ApplicationController
  load_and_authorize_resource class: Project
  layout "layouts/sidebar"
  
  def branches
    @title = "Branches"
    @project = Project.find params[:project_id]
    @report = Report.find params[:report_id]
  end

  def commits
    @title = "Commits" 
    @project = Project.find params[:project_id]
    @report = Report.find params[:report_id]
    @commits = @project.repository.commits.page(params[:page]).per(10)
  end

  def committers
  end
end
