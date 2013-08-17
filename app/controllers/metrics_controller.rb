class MetricsController < ApplicationController
  def files
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def file
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
    
    file_name = TargetFile.find(params[:file_id]).path
    @file = (Git.new(@project.title).head.tree / file_name).data
  end
  
  def classes
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def methods
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end
  
  def churn
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def complexity
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def duplicity
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def smells
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def timeline
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

end
