class Graph::ProjectsController < ApplicationController
  def sunburst_chart
    project = Project.find(params[:project_id]).decorate
    render :json => {name: project.title, children: project.flog_scores_for_two_level_sunburst }
  end

  def class_donut
  end
end
