// This code based on d3 example(http://bl.ocks.org/mbostock/1005873).

this.d3_icecle_chart = function(selector, data_file = "/d3js/flare.json"){
    var target = d3.select(selector);
    var width = target[0][0].parentNode.clientWidth - 40 ;
    var height = width /2;
    var color = d3.scale.category20c();

    var color = d3.scale.category20();

    var svg = target.append("svg")
        .attr("width", width)
        .attr("height", height);

    var partition = d3.layout.partition()
        .size([width, height])
        .value(function(d) { return d.size; });

    d3.json(data_file, function(error, root) {
        var nodes = partition.nodes(root);

        svg.selectAll(".node")
            .data(nodes)
            .enter().append("rect")
            .attr("class", "node")
            .attr("x", function(d) { return d.x; })
            .attr("y", function(d) { return d.y; })
            .attr("width", function(d) { return d.dx; })
            .attr("height", function(d) { return d.dy; })
            .style("fill", function(d) { return color((d.children ? d : d.parent).name); });

        svg.selectAll(".label")
            .data(nodes.filter(function(d) { return d.dx > 6; }))
            .enter().append("text")
            .attr("class", "label")
            .attr("dy", ".35em")
            .attr("transform", function(d) { return "translate(" + (d.x + d.dx / 2) + "," + (d.y + d.dy / 2) + ")rotate(90)"; })
            .text(function(d) { return d.name; });
    });
}
