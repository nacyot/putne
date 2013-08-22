class ReportSummaryTimeSeries
  attr_reader :values, :name, :color
  
  def initialize(reports, name, color)
    @name = name
    @color = color
    @values = []
    
    reports.each_with_index do |report, i|
      @values << {x: i + 1, y: yield(report)}
    end
  end
end
