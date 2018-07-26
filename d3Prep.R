library(r2d3)
data2json <- function(data) {
  jsonlite::toJSON(data, dataframe = "values")
}
n <- 1
df <-
  data.frame(v1 = rep(1, 1),
             value = runif(n, min = 0, max = 25),
             v3 = runif(n) * 20)
# r2d3::r2d3(data=data2json(df), script="bar.js")
# r2d3(
#   data = c(0.3, 0.6, 0.8, 0.95, 0.40, 0.20),
#   dependencies = c("d3-gauge-helper.js", "gauge.css"),
#   d3_version = "3",
#   script = "bar.js"
# )
