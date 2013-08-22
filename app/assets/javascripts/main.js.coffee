# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# @myData = () ->
#         series1 = []
#         for i in [1..100]
#                 series1.push
#                         x : i, 
#                         y : 100 / i
#         return [
#                 key: "Series #1",
#                 values: series1,
#                 color: "#0000ff"
#                 ]

# $ ->
#         nv.addGraph ->
#                 chart = nv.models.lineChart()
#                 chart.xAxis.axisLabel("XXX-axis Label")
#                 chart.yAxis.axisLabel("XX-axis Label").tickFormat(d3.format("d"))

#                 d3.select("svg#dashboard-graph").datum(myData()).transition().duration(500).call(chart)
#                 nv.utils.windowResize -> chart.update()
#                 return chart;
