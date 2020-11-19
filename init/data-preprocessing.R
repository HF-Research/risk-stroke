
# STROKE RISK DATA --------------------------------------------------------
stroke.dt <- fread("data/stroke-1year-risk-predictions.txt")
# Re-order columns to the order patients will enter their variables information
# into the shiny app
new_var_order_stroke <-  c(
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
  "stroke1y.upper"
)
stroke.dt <- stroke.dt[, ..new_var_order_stroke]
setcolorder(stroke.dt, new.var.order.stroke)
setkeyv(stroke.dt, new.var.order.stroke)

saveRDS(stroke.dt, file = "data/stroke.dt")


# COLOR RAMP --------------------------------------------------------------
colorRamp <- reactive({
  # Create first color ramp. We will extract a color from near the green side of
  # this first color ramp. Then we make a second color ramp where we spline
  # through the green-ish color we just extract. This will have the effect of
  # pulling the green color up off the bottom after dong the log-transform.
  n <- 1000
  col_pal_1 <- colorRampPalette(colors = c("#2CDE0D", "red"))
  col_ramp_1 <- col_pal_1(n)

  # Make the second color ramp where we spline through the extracted color from
  # the first color ramp.
  col_pal <-
    colorRampPalette(colors = c("#2CDE0D", col_ramp_1[65], "red"))
  col_pal(n)

})
