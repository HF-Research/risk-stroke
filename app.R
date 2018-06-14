library(shiny)
# library(DT)
library(shinyWidgets)
library(data.table)


source("functions.R")
source("UI_text.R")
source("1-data-prep.R")

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
        div(class = "titles", input_title),
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
          inputId = "vasc",
          label = in_vasc,
          choiceNames = c("No", "Yes"),
          selected =  ("no"),
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE
        ),

        ## BOTH variables:
        hr(),

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


        ## BLEEDING only variables
        hr(),

        shinyWidgets::radioGroupButtons(
          inputId = "bleeding",
          label = in_bleed,
          choiceNames = c("No", "Yes"),
          selected =  ("no"),
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE
        ),

        shinyWidgets::radioGroupButtons(
          inputId = "ckd",
          label = in_ckd,
          choiceNames = c("No", "Yes"),
          selected =  ("no"),
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE
        ),

        shinyWidgets::radioGroupButtons(
          inputId = "drugs",
          label = in_drug,
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
      fluidRow(
        wellPanel(
          id = "results_stroke_well",
          div(class = "titles", results_stroke_title),
          div(class = "output_desc", textOutput("stroke_desc1")),
          tags$h1(strong(textOutput("strokeRisk"))),
          br(),
          div(class = "output_desc", textOutput("stroke_desc2"))
        )
      ),

      fluidRow(
        wellPanel(
          id = "results_bleeding_well",
          div(class = "titles", results_bleeding_title),
          div(class = "output_desc", textOutput("bleed_desc1")),
          tags$h1(strong(textOutput("bleedRisk"))),
          br(),
          div(class = "output_desc", textOutput("bleed_desc2"))

        )
      ),

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

  subsetStroke <- reactive({
    age_as_number <- txt2num()
    stroke_sub <- stroke.dt[age == age_as_number &
                              female %in% input$sex &
                              stroke %in% input$stroke &
                              heartfailure %in% input$hf &
                              diabetes %in% input$diabetes &
                              hypertension %in% input$hyperT &
                              vascular %in% input$vasc,
                            stroke1y]
    out <- list(age_as_number = age_as_number,
                stroke_sub = stroke_sub)
  })

  subsetBleed <- reactive({
    age_as_number <- txt2num()
    # browser()
    bleed_sub <- bleed.dt[age == age_as_number &
                            hypertension %in% input$hyperT &
                            stroke %in% input$stroke &
                            ckd %in% input$ckd &
                            bleeding %in% input$bleeding &
                            drugs %in% input$drugs,
                          bleeding1y]
    list(age_as_number = age_as_number,
         bleed_sub = bleed_sub)
  })

  output$strokeRisk <- renderText({
    # Order of subset arguments must be same order as new.col.order variable set in
    # intro.
    # browser()
    stroke_sub <- subsetStroke()
    if (!is.valid.age(stroke_sub$age_as_number)) {
      enter_age
    } else {
      ifelse(stroke_sub$stroke_sub < 0.1,
             paste0("<0.1%"),
             paste0(sprintf(
               "%.1f",
               round(stroke_sub$stroke_sub,
                     digits = 1)
             ),
             "%"))
    }
  })

  output$stroke_desc1 <- renderText({
    # browser()
    age_as_number <- txt2num()
    if (is.valid.age(age_as_number)) {
      out_stroke
    } else {
      ""
    }
  })

  output$stroke_desc2 <- renderText({
    # browser()
    stroke_sub <- subsetStroke()
    if (is.valid.age(stroke_sub$age_as_number)) {
      number_strokes <-
        (round(stroke_sub$stroke_sub, digits = 1) * 0.01 * 1000)
      ifelse(
        number_strokes >= 1,
        paste0(out_stroke2, number_strokes, out_stroke3),
        out_strokeLessOne
      )
    } else {
      ""
    }
  })

  output$bleedRisk <- renderText({
    # browser()
    bleed_sub <- subsetBleed()
    if (!is.valid.age(bleed_sub$age_as_number)) {
      enter_age
    } else {
      ifelse(bleed_sub$bleed_sub < 0.1,
             paste0("<0.1%"),
             paste0(sprintf(
               "%.1f",
               round(bleed_sub$bleed_sub,
                     digits = 1)
             ),
             "%"))
    }
  })

  output$bleed_desc1 <- renderText({
    # browser()
    age_as_number <- txt2num()
    if (is.valid.age(age_as_number)) {
      out_bleeding1
    } else {
      ""
    }
  })

  output$bleed_desc2 <- renderText({
    # browser()
    bleed_sub <- subsetBleed()
    if (is.valid.age(bleed_sub$age_as_number)) {
      number_bleed <-
        (round(bleed_sub$bleed_sub, digits = 1) * 0.01 * 1000)
      ifelse(
        number_bleed >= 1,
        paste0(out_bleeding2, number_bleed, out_bleeding3),
        out_bleedingLessOne
      )
    } else {
      ""
    }
  })

}

shinyApp(ui = ui, server = server)
