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
    tags$link(rel = "stylesheet", type = "text/css", href = "cars-style.css")
  ),

  fluidRow(
    # Input column
    column(
      id = "input_col",
      6,
      wellPanel(
        div(id = "input_title", input_title),
        br(),
        numericInput(
          inputId = "user_age",
          label = in_age,
          min = 20,
          max = 99,
          value = "Age"
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
        div(class = "output_desc", textOutput("output_description1")),
        tags$h1(strong(textOutput("strokeRisk"))),
        br(),
        div(class = "output_desc", textOutput("output_description2"))

      )),
      div(class = "out_stroke_details", out_stroke_details),
      br(),
      div(class = "out_stroke_details", out_stroke_details2),
      tags$ul(
        class = "out_stroke_details",
        tags$li(out_details_list1),
        tags$li(out_details_list2)
      ),
      br(),
      br(),
      hr(),
      div(class = "ref", references),
      tags$ol(
        class = "ref",
        tags$li(ref1),
        tags$li(ref2),
        tags$li(ref3),
        tags$li(ref4)
      )
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
      enter_age

    } else {
      dat.sub <- stroke.dt[age == age_as_number &
                             female %in% input$sex &
                             stroke %in% input$stroke &
                             heartfailure %in% input$hf &
                             diabetes %in% input$diabetes &
                             hypertension %in% input$hyperT &
                             vascular %in% input$vasc,
                           stroke1y]
      ifelse(dat.sub < 0.1,
             paste0("<0.1%"),
             paste0(sprintf(
               "%.1f",
               round(dat.sub[1],
                     digits = 1)),
             "%"))
    }

  })
  output$output_description1 <- renderText({
    # browser()
    age_as_number <- txt2num()
    if (is.valid.age(age_as_number)) {
      out_stroke
    } else {
      ""
    }

  })
  output$output_description2 <- renderText({
    # browser()
    age_as_number <- txt2num()
    if (is.valid.age(age_as_number)) {
      dat.sub <- stroke.dt[age == age_as_number &
                             female %in% input$sex &
                             stroke %in% input$stroke &
                             heartfailure %in% input$hf &
                             diabetes %in% input$diabetes &
                             hypertension %in% input$hyperT &
                             vascular %in% input$vasc,
                           stroke1y]
      number_strokes <- (round(dat.sub, digits = 1)*0.01*1000)
      ifelse(number_strokes >= 1,
             paste0(out_stroke2, number_strokes, out_stroke3),
             out_strokeLessOne
             )

    } else {
      ""
    }

  })


}

shinyApp(ui = ui, server = server)
