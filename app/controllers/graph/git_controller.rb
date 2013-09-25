class Graph::GitController < ApplicationController
  def dates
    text = CSV.generate do |csv|
      csv << %w(date value)
      Git.new(Project.find(params[:project_id]).repository).dates.each { |line| csv << line }
    end
    
    render text: text
  end
end
