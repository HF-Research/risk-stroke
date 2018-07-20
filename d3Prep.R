data2json <- function(data) {
  jsonlite::toJSON(data, dataframe = "values")
}
n <- 100
df <- data.frame(v1 = runif(n)*200, v2 = runif(n)*200, v3 = runif(n)*20)
# r2d3::r2d3(data=data2json(df), script="bar.js")
