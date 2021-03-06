tabPanel(
  ui_stroke_title,
  useShinyjs(),


  fluidRow(
    # STROKE-INPUT-------------------------------------------------------------------
    column(
      id = "input_col",
      6,
      wellPanel(

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
          choiceNames = ui_sex_labels,
          choiceValues = c('no', "yes"),
          checkIcon = list(yes = icon("check")),
          selected =  "no",
          # width = button.width,
          justified = TRUE
        ),

        br(),
        div(id = "in_prevDiag", in_prevDiag),
        br(),

        yesNoButton(id = ("hf"), label = in_hf),
        yesNoButton(id = ("dm"), label = in_dm),
        yesNoButton(id = ("vasc"), label = in_vasc),
        yesNoButton(id = ("stroke"), label = in_stroke),
        yesNoButton(id = ("hyper_t"), label = in_hyperT)
      )
    ),


    # STROKE-OUTPUT ------------------------------------------------------------------

    column(
      id = "results",
      6,
      tabsetPanel(
        type = "pills",
        tabPanel(
          results_1,
          fluidRow(
            wellPanel(
              class = "results_well",
              # div(class = "results_header", results_stroke_header),
              div(class = "results_header", textOutput("stroke_desc1")),
              tags$h1(strong(textOutput("enter_age"))),
              d3Output("plot_risk_gauge", height = "100%"),

              br()

            )
          ),


          fluidRow(
            wellPanel(
              id = "plot_matrix",
              class = "results_well",
              div(class = "output_desc", textOutput("stroke_desc2")),
              br(),
              uiOutput("plot_stroke")

            )
          )
          ),

        tabPanel(results_2,
                 fluidRow(wellPanel(id = "results_gauge")),


                 fluidRow(wellPanel(id = "results_plot_stroke")))
      ),


      hr()



    )
  )
)
