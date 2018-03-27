# Text file for Shiny UI.
#
# Make edits to the UI in this file
# Var names should not contain "." due to conflicts with JavaScript

# TITLE -------------------------------------------------------------------
title_txt <- "Draft stroke risk calculator"


# INPUT UI ------------------------------------------------------------------
in_age <- "Patient's age"
in_sex <- "Patient's sex"
in_stroke <- "Has patient ever had stroke"
in_hf <- "Has patient ever had heart failure"
in_hyperT <- "Has patient ever had hypertension"
in_diab <- "Has patient ever had diabetes"
in_vasc <- "Has patient ever had vascular disease"

# Must be in quotedt pixels (px), e.g.: "100px"
in_txt_size <- "14px"


# OUTPUT TEXT -------------------------------------------------------------
out_intro <- "Intro header"
out_intro_size <- "24px"

out_stroke <- "1-year stroke risk is estimated to be:"
out_stroke_text_size <- "32px"

out_stroke_details <- "This number gives the risk of stroke over 1-year for patients
{describe patients here]. This estimate is based on X number of patients who had similar covariates"
out_stroke_details_size <- "14px"

references <- "Journal references here"
references_size <- "12px"

# Text that appears when user has not entered an appropriate age (i.e. <20 ||
# >99 || not a whole number)
enter_age <- "Please enter a whole number between 20 - 99"
