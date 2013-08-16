class MetricsController < ApplicationController

  def files
    @project = Project.find(params[:project_id])
  end

  def classes
    @project = Project.find(params[:project_id])
  end

  def methods
    @project = Project.find(params[:project_id])
  end
  
  def churn
    @project = Project.find(params[:project_id])
    @report = Report.find(params[:report_id])
  end

  def complexity
    @project = Project.find(params[:project_id])
  end

  def duplicity
    @project = Project.find(params[:project_id])
  end

  def smells
    @project = Project.find(params[:project_id])
  end

  def timeline
    @project = Project.find(params[:project_id])
  end

end
