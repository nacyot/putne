class ProjectDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def flog_scores_for_two_level_sunburst
    flogs = latest_report.flog_scores.group_by { |score| File.dirname(score[:path]) }
    flogs.map {|key, content| {name: key, children: content} }
  end
end
