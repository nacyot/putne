// This code based on d3 example(http://bl.ocks.org/mbostock/1005873).

this.d3_icecle_chart = function(selector, data_file = "/d3js/readme.json"){
    var target = d3.select(selector);
    var parentWidth = target[0][0].parentNode.clientWidth;

    var w = parentWidth - margin.left - margin.right;
    var h = (parentWidth * 0.47) - margin.top - margin.bottom;

    var x = d3.scale.linear().range([0, w]);
    var y = d3.scale.linear().range([0, h]);
    var color = d3.scale.category20c();

    var vis = target.append("svg:svg")
        .attr("width", w)
        .attr("height", h);

    var partition = d3.layout.partition()
        .children(function(d) { return isNaN(d.value) ? d3.entries(d.value) : null; })
        .value(function(d) { return d.value; });

    d3.json(data_file, function(json) {
        var rect = vis.selectAll("rect")
            .data(partition(d3.entries(json)[0]))
            .enter().append("svg:rect")
            .attr("x", function(d) { return x(d.x); })
            .attr("y", function(d) { return y(d.y); })
            .attr("width", function(d) { return x(d.dx); })
            .attr("height", function(d) { return y(d.dy); })
            .attr("fill", function(d) { return color((d.children ? d : d.parent).data.key); })
            .on("click", click);

        function click(d) {
            x.domain([d.x, d.x + d.dx]);
            y.domain([d.y, 1]).range([d.y ? 20 : 0, h]);

            rect.transition()
                .duration(750)
                .attr("x", function(d) { return x(d.x); })
                .attr("y", function(d) { return y(d.y); })
                .attr("width", function(d) { return x(d.x + d.dx) - x(d.x); })
                .attr("height", function(d) { return y(d.y + d.dy) - y(d.y); });
        }
    });

}
