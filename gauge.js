 // !preview r2d3 data=data2json(df)

//
// r2d3: https://rstudio.github.io/r2d3
//

var pie = d3.layout.pie();
var outerRadius = width / 2;
var innerRadius = 20;
var arc = d3.svg.arc()
  .innerRadius(innerRadius)
  .outerRadius(outerRadius);


svg.selectAll('g.arc')
  .data(pie(data))
  .enter().append('g')
    .attr('class', "arc")
    .attr('fill', 'steelblue');
