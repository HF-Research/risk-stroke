ui <- div(
tags$head(

  # TODO: Include JS script to add link to diff lang versions
  includeScript("www/checkBrowser.js")
),
  fluidPage(
    tags$a(
      img(
      src = "hf-logo.png",
      align = "left",
      style = "padding-top: 20px; padding-bottom: 40px; padding-left: 1rem;",
      height = "110px"
    ),
    href = "https://hjerteforeningen.dk/", target ="_blank"),

    div(style = "padding-left: 0px; padding-right: 0px;",
        titlePanel(
          title = "", windowTitle = tags$head(
            tags$link(rel = "icon", type = "image/png", href = "hf-icon.png"),
            tags$title("CARS")
          )
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
