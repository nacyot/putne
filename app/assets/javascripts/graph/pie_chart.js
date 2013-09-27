// This code based on d3 example(http://bl.ocks.org/mbostock/raw/3887235/).

this.d3_pie_chart = function(selector, data_file = "/d3js/pie.csv"){
    var target = d3.select(selector);
    var parentWidth = target[0][0].parentNode.clientWidth;

    var width = parentWidth;
    var height = (parentWidth * 0.7);
    var radius = (Math.min(width, height) / 2) - 25;

    var color = d3.scale.ordinal()
        .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

    var arc = d3.svg.arc()
        .outerRadius(radius - 10)
        .innerRadius(0);

    var donut = d3.svg.arc()
        .outerRadius(radius - 5)
        .innerRadius(radius + 20);

    var pie = d3.layout.pie()
        .sort(null)
        .value(function(d) { return d.Data; });

    var svg = target.append("svg")
        .attr("width", width)
        .attr("height", height)
        .append("g")
        .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

    d3.csv(data_file, function(error, data) {

        data.forEach(function(d) {
            d.Data = +d.Data;
        });

        var g = svg.selectAll(".arc")
            .data(pie(data))
            .enter().append("g")
            .attr("class", "arc");

        g.append("path")
            .attr("d", arc)
            .style("fill", function(d) { return color(d.data.Data); });

        g.append("text")
            .attr("transform", function(d) { return "translate(" + donut.centroid(d) + ")"; })
            .attr("dy", "0.3em")
            .style("text-anchor", "middle")
            .text(function(d) { return d.data.Category; });

    });
}
