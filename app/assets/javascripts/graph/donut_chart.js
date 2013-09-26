// This code is based on d3 example(http://bl.ocks.org/mbostock/raw/3887193/).

this.d3_donut_chart = function(selector, data_file = "/d3js/donut.csv"){
    var target = d3.select(selector);
    var parentWidth = target[0][0].parentNode.clientWidth;

    var width = parentWidth - 20;
    var height = (parentWidth) - 20;
    var radius = Math.min(width, height) / 2;

    var color = d3.scale.ordinal()
        .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

    var arc = d3.svg.arc()
        .outerRadius(radius - 5)
        .innerRadius(radius - 70);

    var pie = d3.layout.pie()
        .sort(null)
        .value(function(d) { return d.Complexity; });

    var svg = target.append("svg")
        .attr("width", width)
        .attr("height", height)
        .append("g")
        .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

    d3.csv(data_file, function(error, data) {

        data.forEach(function(d) {
            d.Complexity = +d.Complexity;
        });

        var g = svg.selectAll(".arc")
            .data(pie(data))
            .enter().append("g")
            .attr("class", "arc");

        g.append("path")
            .attr("d", arc)
            .style("fill", function(d) { return color(d.data.Complexity); });

        g.append("text")
            .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
            .attr("dy", ".35em")
            .style("text-anchor", "middle")
            .text(function(d) { return d.data.Klass; });

    });
}
