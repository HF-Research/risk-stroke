library(shiny)
library(DT)
library(shinyWidgets)
library(data.table)

load("data/stroke1yr.rda")
source("functions.R")
source("UI_text.R")
# browser()
stroke.dt <- data.table::data.table(stroke1yr)


# Re-order columns to the order patients will enter their variables information
# into the shiny app
new.var.order <-  c(
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

setcolorder(stroke.dt, new.var.order)
setkeyv(stroke.dt, new.var.order)

input_id_vec <- c("user_age",
                  "sex",
                  "stroke",
                  "hf",
                  "diabetes",
                  "hyperT",
                  "vasc")

button.width <- "260px"

ui <- fluidPage(
  # Application title
  h1(title_txt),
  h4(subtitle_txt),
  br(),
  # theme = shinythemes::shinytheme(theme = "yeti"),


  tags$head(
    # Main styling is in CSS file:
    # tags$link(rel = "stylesheet", type = "text/css", href = "bootswatch-yeti.css"),
    # tags$link(rel = "stylesheet", type = "text/css", href = "materia.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "cars-style.css"),


    # Styling that's linked to UI_text file goes here:
    tags$style(
      paste0("#stroke_results_text {font-size:", out_stroke_text_size, "}")
    ),
    tags$style(paste0(
      "#out_intro {font-size:", out_intro_size, "}"
    )),
    tags$style(paste0(".ref {font-size:", ref_size, "}")),
    tags$style(paste0(
      "#references {font-size:", references_size, "}"
    )) # font size
    ),


  fluidRow(
    # Input column
    column(
      id = "input_col",
      6,
      wellPanel(
        textInput(
          inputId = "user_age",
          label = in_age,
          value = NULL,
          placeholder = "Age"
        ),
        shinyWidgets::radioGroupButtons(
          inputId = "sex",
          label = in_sex,
          choices = c("Male" = "no",
                      "Female" = "yes"),
          checkIcon = list(yes = icon("check")),
          selected =  "no",
          # width = button.width,
          justified = TRUE

        ),

        shinyWidgets::radioGroupButtons(
          inputId = "stroke",
          label = in_stroke,
          choiceNames = c("No", "Yes"),
          selected =  "no",
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE

        ),
        shinyWidgets::radioGroupButtons(
          inputId = "hf",
          label = in_hf,
          choiceNames = c("No", "Yes"),
          selected =  ("no"),
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE

        ),
        shinyWidgets::radioGroupButtons(
          inputId = "diabetes",
          label = in_diab,
          choiceNames = c("No", "Yes"),
          selected =  ("no"),
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE

        ),
        shinyWidgets::radioGroupButtons(
          inputId = "hyperT",
          label = in_hyperT,
          choiceNames = c("No", "Yes"),
          selected =  ("no"),
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE

        ),
        shinyWidgets::radioGroupButtons(
          inputId = "vasc",
          label = in_vasc,
          choiceNames = c("No", "Yes"),
          selected =  ("no"),
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE

        )
      )
    ),

    # Results column:
    column(
      id = "results",
      6,
      fluidRow(wellPanel(
        id = "results_well",
        div(id = "results_title", results_title),
        # div(id = "out_intro", out_intro),
        br(),
        div(id = "stroke_results_text", out_stroke),
        tags$h2(strong(textOutput("strokeRisk")))
      )),
      div(class = "out_stroke_details", out_stroke_details),
      br(),
      div(class = "out_stroke_details", out_stroke_details2),
      tags$ul(class = "out_stroke_details",
              tags$li(out_details_list1),
              tags$li(out_details_list2)
      ),
      br(),
      br(),
      hr(),
      div(id = "references", references),
      div(class = "ref", ref1),
      div(class = "ref", ref2),
      div(class = "ref", ref3),
      div(class = "ref", ref4)
    )
  )
  )


# SERVER ------------------------------------------------------------------
server <- function(input, output) {
  txt2num <- reactive({
    as.numeric(input$user_age)
  })

  output$strokeRisk <- renderText({
    # Order of subset arguments must be same order as new.col.order variable set in
    # intro.
    # browser()
    age_as_number <- txt2num()
    if (!is.valid.age(age_as_number)) {
      paste0(enter_age)

    } else {
      # browser()
      dat.sub <- stroke.dt[age == age_as_number &
                             female %in% input$sex &
                             stroke %in% input$stroke &
                             heartfailure %in% input$hf &
                             diabetes %in% input$diabetes &
                             hypertension %in% input$hyperT &
                             vascular %in% input$vasc,
                           range(stroke1y)]

      test  <- stroke.dt[age == age_as_number &
                           female %in% input$sex &
                           stroke %in% input$stroke &
                           heartfailure %in% input$hf &
                           diabetes %in% input$diabetes &
                           hypertension %in% input$hyperT &
                           vascular %in% input$vasc,
                         c(3, 7, 10)]

      one.value <- dat.sub[2] - dat.sub[1] < 0.001
      if (one.value) {
        paste0(dat.sub[1], "%")
      } else if (!one.value) {
        paste0("between ", dat.sub[1],
               "%", " and ",
               dat.sub[2],
               "%")
      }


    }

  })


}

shinyApp(ui = ui, server = server)
