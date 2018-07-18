library(shiny)
library(shinyWidgets)
library(data.table)
library(ggplot2)

source("functions.R")
source("UI_text.R")
source("1-data-prep.R")
#
# input_id_vec <- c("user_age",
#                   "sex",
#                   "stroke",
#                   "hf",
#                   "diabetes",
#                   "hyperT",
#                   "vasc")
button.width <- "260px"
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  h1(title_txt),
  h4(subtitle_txt),
  br(),
  # theme = shinythemes::shinytheme(theme = "yeti"),


  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "cars-style.css")
  ),

  fluidRow(
    # INPUT -------------------------------------------------------------------
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


    # OUTPUT ------------------------------------------------------------------

    column(
      id = "results",
      6,
      tabsetPanel(
        type = "tabs",
        tabPanel("text",
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
                 )),

        tabPanel("plot",
                 fluidRow(
                   wellPanel(id = "results_plot_stroke",
                             uiOutput("plot_stroke"))
                 ),


                 fluidRow(
                   wellPanel(id = "results_plot_riskbar",
                             plotOutput("plot_riskbar"))
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
))
