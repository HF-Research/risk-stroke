##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title yesNoButton
##' @param label
yesNoButton <- function(id, label) {

  shinyWidgets::radioGroupButtons(
    inputId = id,
    label = label,
    choiceNames = in_yesNo_choice,
    selected =  ("no"),
    choiceValues = c("no",
                     "yes"),
    checkIcon = list(yes = icon("check")),
    # width = button.width,
    justified = TRUE
  )

}
