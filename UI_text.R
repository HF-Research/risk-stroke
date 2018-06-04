# Text file for Shiny UI.
#
# Make edits to the UI in this file
# Var names should not contain "." due to conflicts with JavaScript

# TITLE -------------------------------------------------------------------
title_txt <- "CARS"
subtitle_txt <- "Calculator of Absolute Stroke Risk"


# INPUT UI ------------------------------------------------------------------
in_age <- "Age of patient, choose between 20-99 years"
in_sex <- "Patient's sex"

in_stroke <- "Previous stroke/TCI/thromboembolism"
in_hf <- "Heart failure"
in_hyperT <- "Hypertension"
in_diab <- "Diabetes mellitus"
in_vasc <- "Vascular disease (Prior myocardial infarction, peripheral artery disease)"


help_stroke <- "Previous stroke / Transient Ischemic attack / thromboembolism"
help_hf <- "Congestive heart failure/ Left ventricular dysfunction"
help_hyperT <- "Treatment with antihypertensive drugs or resting sBP >= 140mmHg and/or
dBP>=90mmHg"
help_diab <- "Treatment with oral hypoglycemic drugs or Glycated hemoglobin
(HbA1C) ≥ 48 mmol/mol (≥ 6.5 DCCT %)"
help_vasc <- "Prior myocardial infarction, peripheral artery disease"
# Must be in quotedt pixels (px), e.g.: "100px"
in_txt_size <- "14px"


# OUTPUT TEXT -------------------------------------------------------------

results_title <- "RESULTS"
out_stroke <- "The average 1-year risk of stroke and thromboembolism:"

out_stroke_details <- "
CARS calculates the absolute 1-year risk of stroke and thromboembolism for patients
with atrial fibrillation and not receiving anticoagulation.
The calculator is based on a large cohort of Danish patients admitted first time to the hospital
for their atrial fibrillation (1)."


out_stroke_details2 <- "
The calculator uses the same risk factors as the CHA2DS2-VASc score (2) recommended in the latest European/American guidelines
to guide the need for anticoagulation for patients with atrial fibrillation (3-4).
The main differences are the following:"
out_details_list1 <- "Age is included as a continuous variable"
out_details_list2 <- "The overall risk calculation takes into account not a sum of risk factors, but their individual contribution."
#This estimate is based on X number of patients who had similar covariates
out_stroke_details2_size <- "14px"

references <- "References:"
references_size <- "12px"

ref1 <- "1. Lee J-Y.C, Ozenne B, Gislason G, Olesen JB, Torp-Pedersen C, Gerds TA.
The individual risk of stroke in patients with atrial fibrillation by the CHADSVASC score."
ref_size <- "12px"

ref2 <-" 2. 	Kirchhof P, Benussi S, Kotecha D, Ahlsson A, Atar D, Casadei B, m.fl.
2016 ESC Guidelines for the management of atrial fibrillation developed in collaboration with EACTS.
Eur Heart J. 7. October 2016;37(38):2893–962."


ref3 <-" 3. 	January CT, Wann LS, Alpert JS, Calkins H, Cigarroa JE, Cleveland JC, m.fl.
2014 AHA/ACC/HRS Guideline for the Management of Patients With Atrial Fibrillation:
Executive Summary: A Report of the American College of Cardiology/
American Heart Association Task Force on Practice Guidelines and the Heart Rhythm Society.
J Am Coll Cardiol. 2. December 2014;64(21):2246–80."


ref4 <-"4. 	Lip GYH, Nieuwlaat R, Pisters R, Lane DA, Crijns HJGM.
Refining clinical risk stratification for predicting stroke and thromboembolism in atrial fibrillation
using a novel risk factor-based approach: the euro heart survey on atrial fibrillation.
Chest. February 2010;137(2):263-72."



# Text that appears when user has not entered an appropriate age (i.e. <20 ||
# >99 || not a whole number)
enter_age <- "Please enter a whole number (years of age) between 20 - 99"
