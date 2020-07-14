ui <- div(
tags$head(
  includeScript("www/checkBrowser.js")
),
  fluidPage(
    img(
      src = "hf-logo.png",
      align = "left",
      style = "padding-top: 20px; padding-bottom: 40px; padding-left: 1rem;",
      height = "110px"
    ),
    div(style = "padding-left: 0px; padding-right: 0px;",
        titlePanel(
          title = "", windowTitle = "CARS"
        ))
  ),
  navbarPage(
    title = "CARS",
    collapsible = TRUE,
    theme = "cars-style.css",
    source(file.path("ui", "ui_stroke.R"), local = TRUE)$value,
    source(file.path("ui", "ui_about.R"), local = TRUE)$value

  )
)
