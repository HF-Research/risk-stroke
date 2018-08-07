library(shiny)
library(shinyWidgets)
library(shinyjs)
library(data.table)
library(ggplot2)
library(r2d3)
library(shinyBS)
source("functions.R")
source("UI-DK.R", encoding = "UTF-8")
source("1-data-prep.R")

button.width <- "260px"
# Define UI for application that draws a histogram
shinyUI(ui = tagList(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "cars-style.css")
  ),
  useShinyjs(),
  #

  navbarPage(
    title_txt,

    # STROKE ------------------------------------------------------------------

    tabPanel("Apopleski",

             fluidRow(
               # STROKE-INPUT-------------------------------------------------------------------
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
                     choices = c("Mand" = "no",
                                 "Kvinde" = "yes"),
                     checkIcon = list(yes = icon("check")),
                     selected =  "no",
                     # width = button.width,
                     justified = TRUE
                   ),

                   br(),
                   div(id = "in_prevDiag", in_prevDiag),
                   br(),

                   shinyWidgets::radioGroupButtons(
                     inputId = "hf",
                     label = in_hf,
                     choiceNames = in_yesNo_choice,
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

                     choiceNames = in_yesNo_choice,
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
                     choiceNames = in_yesNo_choice,
                     selected =  ("no"),
                     choiceValues = c("no",
                                      "yes"),
                     checkIcon = list(yes = icon("check")),
                     # width = button.width,
                     justified = TRUE
                   ),


                   shinyWidgets::radioGroupButtons(
                     inputId = "stroke",
                     label = in_stroke,
                     choiceNames = in_yesNo_choice,
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
                     choiceNames = in_yesNo_choice,
                     selected =  ("no"),
                     choiceValues = c("no",
                                      "yes"),
                     checkIcon = list(yes = icon("check")),
                     # width = button.width,
                     justified = TRUE
                   )
                 )
               ),


               # STROKE-OUTPUT ------------------------------------------------------------------

               column(
                 id = "results",
                 6,
                 tabsetPanel(
                   type = "tabs",
                   tabPanel(
                     results_1,
                     fluidRow(
                       wellPanel(
                         class = "results_stroke_well",
                         # div(class = "results_header", results_stroke_header),
                         div(class = "results_header", textOutput("stroke_desc1")),
                         tags$h1(strong(textOutput("enter_age"))),
                         d3Output("plot_riskbar", height = "100%"),

                         br()

                       )
                     ),


                     fluidRow(
                       wellPanel(
                         id = "plot_matrix",
                         class = "results_stroke_well",
                         div(class = "output_desc", textOutput("stroke_desc2")),
                         br(),
                         uiOutput("plot_stroke")

                       )
                     ),
                     fluidRow(
                       wellPanel(
                         class = "explanitory_well",
                         div(class = "results_header", explanitory_header),
                         br(),
                         div(class = "explanitory_text", explanitory_text_1),
                         br(),
                         div(class = "explanitory_text", explanitory_text_2),
                         br(),
                         tags$ul(
                           class = "explanitory_text",
                           tags$li(explanitory_text_3),
                           tags$li(explanitory_text_4)
                         )



                       )
                     )
                   ),

                   tabPanel(results_2,
                            fluidRow(wellPanel(id = "results_gauge")),


                            fluidRow(wellPanel(id = "results_plot_stroke")))
                 ),


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
             )),
    tabPanel("Blødning",

             # BLEEDING ----------------------------------------------------------------
             fluidRow(column(
               id = "input_col",
               6,
               wellPanel(
                 # BLEEDING-INPUT ----------------------------------------------------------


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
                   choices = c("Mand" = "no",
                               "Kvinde" = "yes"),
                   checkIcon = list(yes = icon("check")),
                   selected =  "no",
                   # width = button.width,
                   justified = TRUE
                 ),

                 br(),
                 div(id = "in_prevDiag", in_prevDiag),
                 br(),


                 shinyWidgets::radioGroupButtons(
                   inputId = "stroke",
                   label = in_stroke,
                   choiceNames = in_yesNo_choice,
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
                   choiceNames = in_yesNo_choice,
                   selected =  ("no"),
                   choiceValues = c("no",
                                    "yes"),
                   checkIcon = list(yes = icon("check")),
                   # width = button.width,
                   justified = TRUE
                 ),

                 shinyWidgets::radioGroupButtons(
                   inputId = "bleeding",
                   label = in_bleed,
                   choiceNames = in_yesNo_choice,
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
                   choiceNames = in_yesNo_choice,
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
                   choiceNames = in_yesNo_choice,
                   selected =  ("no"),
                   choiceValues = c("no",
                                    "yes"),
                   checkIcon = list(yes = icon("check")),
                   # width = button.width,
                   justified = TRUE
                 )
               )
             )))
  )
))
