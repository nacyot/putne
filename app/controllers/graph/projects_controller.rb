class Graph::ProjectsController < ApplicationController
  def sunburst_chart
    project = Project.find(params[:project_id]).decorate
    render :json => {name: project.title, children: project.flog_scores_for_two_level_sunburst }
  end

  def class_donut_chart
    project = Project.find(params[:project_id]).decorate
    text = CSV.generate do |csv|
      csv << %w(Klass Complexity)
      text = project.flog_scores_for_klass_donut.each { |complexity| csv << [complexity[:name], complexity[:size]] }
    end
    
    render text: text, content_type: 'text/html'
  end
end
