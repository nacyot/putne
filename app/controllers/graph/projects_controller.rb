class Graph::ProjectsController < ApplicationController
  def sunburst_chart
    render :json => {name: "Putne", children: Report.first.flog_scores_group_by_path }
  end
end
