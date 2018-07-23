     // !preview r2d3 data=data2json(df)

var ySpace = Math.floor(height / data.length);
var xSpace = Math.floor(width / data.length);

var pad = 20;

var scaleX = d3.scaleLinear() //scaleLinear in d3v4!
  .domain([0, d3.max(data, function(d){return d[0];})])
  .range([pad, width - pad]);

var scaleY = d3.scaleLinear()
  .domain([0, d3.max(data, function(d){return d[1];})])
  .range([height - pad, pad]);

var scaleR = d3.scaleLinear()
  .domain([0, d3.max(data, function(d){return d[1];})])
  .range([1, 10]);

var axisX = d3.axisBottom(scaleX);


svg.selectAll('circle')
  .data(data)
  .enter().append('circle')
    .attr("cx", function(d, i){
      return scaleX(d[0]);

    })
    .attr("cy", function(d, i){
      return scaleY(d[1]);
    })
    .attr('r', function(d){
      return scaleR(d[1]);
    })
    .style('fill', "steelblue");

svg.append("g")
  .call(axisX)
  .attr("transform", "translate(0," + (height - pad) + ")");

