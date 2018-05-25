# Helper functions
jsButtonSelectionColor <- function(active = TRUE, color){
  # Colors active or non-active buttons in shinyWidgets library
  if (active) {
    paste0("$('.btn.radiobtn.btn-default.active').css({'background-color':'",
         color,
         "'});")
  }
  else {
    paste0("$('.btn.radiobtn.btn-default').css({'background-color':'",
           color,
           "'});")
    }
}

jsButtonColor <- function(var, color, value) {
  # Makes simple js code to color buttons in shinyWidgets library. From:
  # https://github.com/dreamRs/shinyWidgets/issues/41
  # var, color and yes/no need to be in quotes
  paste0(
    "$(\"input:radio[name='",
    var,
    "'][value='",
    paste0(value),
    "']\").parent().css({'background-color': '",
    color,
    "',
    'border-color': '#FAFAFA'});"
  )
}


jsButtonColor2 <- function(color, value) {
  # Makes simple js code to color buttons in shinyWidgets library. From:
  # https://github.com/dreamRs/shinyWidgets/issues/41
  # var, color and yes/no need to be in quotes
  paste0(
    "$(\"input:radio[value='",
    paste0(value),
    "']\").parent().css('background-color', '",
    color,
    "');"
  )
}

depSub <- function(a) {
  # shortcut helper n
  deparse(substitute(a))
}

evPar <- function(x) {
  # short helper fun
  eval(parse(text = x))
}


is.valid.age <- function(x) {
  !is.na(x) &&
    x >= 20 &&
    x <= 99 &&
    x %% 1 == 0
}
