library(data.table)
load("data/stroke1yr.rda")
load("data/bleed1yr.rda")
stroke.dt <- data.table::data.table(stroke1yr)
bleed.dt <- data.table::data.table(bleed1yr)
# Re-order columns to the order patients will enter their variables information
# into the shiny app
new.var.order.stroke <-  c(
  "age",
  "female",
  "stroke",
  "heartfailure",
  "diabetes",
  "hypertension",
  "vascular",
  "chadsvasc",
  "stroke1y.lower",
  "stroke1y",
  "stroke1y.upper",
  "I63.lower",
  "I63",
  "I63.upper",
  "thromb1y.lower",
  "thromb1y",
  "thromb1y.upper",
  "year2000"
)

setcolorder(stroke.dt, new.var.order.stroke)
setkeyv(stroke.dt, new.var.order.stroke)

new.var.order.bleed <- c(
    "age",
    "hypertension",
    "ckd",
    "stroke",
    "bleeding",
    "drugs",
    "bleeding1y",
    "bleeding1y.lower",
    "bleeding1y.upper",
    "ICH1y",
    "ICH1y.lower",
    "ICH1y.upper",
    "GI1y",
    "GI1y.lower",
    "GI1y.upper",
    "year2000"
)

setcolorder(bleed.dt, new.var.order.bleed)
setkeyv(bleed.dt, new.var.order.bleed)

bleed.dt[, max(bleeding1y)]
stroke.dt[, max(stroke1y)]
