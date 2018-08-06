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
shinyUI(ui = tagList(tags$head(
  tags$link(rel = "stylesheet", type = "text/css", href = "cars-style.css")
),

navbarPage(
  title_txt,
  tabPanel("Læge visning",

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
                   choices = c("Mand" = "no",
                               "Kvinde" = "yes"),
                   checkIcon = list(yes = icon("check")),
                   selected =  "no",
                   # width = button.width,
                   justified = TRUE
                 ),

                 br(),
                 div(id = "in_prevDiag", in_prevDiag),

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

                 ## BOTH variables:
                 hr(),

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


                 ## BLEEDING only variables
                 hr(),

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
             ),


             # OUTPUT ------------------------------------------------------------------

             column(
               id = "results",
               6,
               tabsetPanel(
                 type = "tabs",
                 tabPanel(results_1,
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
                              class = "results_stroke_well",
                              div(class = "output_desc", textOutput("stroke_desc2")),
                              br(),
                              uiOutput("plot_stroke")

                            )
                          )),

                 tabPanel(results_2,
                          fluidRow(
                            wellPanel(id = "results_gauge"

                                      )
                          ),


                          fluidRow(
                            wellPanel(id = "results_plot_stroke")
                          ))
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
           )),
  tabPanel("Patient view")
)
))
