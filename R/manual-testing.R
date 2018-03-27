# Manual testing
library(data.table)
x <- as.data.table(stroke1yr)
x[age==60 & female =="no" & stroke == "yes" & heartfailure == "no"
  & hypertension == "yes" & diabetes == "yes" & vascular == "yes", stroke1y]
