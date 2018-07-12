# HELPER FUNCTIONS --------------------------------------------------------
is.valid.age <- function(x) {
  !is.na(x) &&
    x >= 20 &&
    x <= 99 &&
    x %% 1 == 0
}

outputHelper1 <- function(data, age, age_warning){
  # Outputs results if age is valid, if not - gives warning to enter age
  if (!is.valid.age(age)) {
    age_warning
  } else {
    ifelse(data < 0.1,
           paste0("<0.1%"),
           paste0(sprintf(
             "%.1f",
             round(data,
                   digits = 1)
           ),
           "%"))
  }
}

outputHelper2 <- function(data, age, out2, out3, outLessOne){
  # Write description of output if age is valid
  if (is.valid.age(age)) {
    threshold <-
      (round(data, digits = 1) * 0.01 * 1000)
    ifelse(
      threshold >= 1,
      paste0(out2, threshold, out3),
      outLessOne
    )
  } else {
    ""
  }

}
