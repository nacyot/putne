# -*- coding: utf-8 -*-
class GitController < ApplicationController
  load_and_authorize_resource class: Project
  
  def branches
    @project = Project.find params[:project_id]
    @report = Report.find params[:report_id]
  end

  def commits
    @project = Project.find params[:project_id]
    @report = Report.find params[:report_id]
    @commits = @project.repository.commits.page(params[:page]).per(10)
  end
end
