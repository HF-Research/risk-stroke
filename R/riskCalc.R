#' Shiny app
#'
#' @return
#' @import data.table
#' @import shiny
#' @export
#'
#' @examples
riskCalc <- function(){

# browser()
  stroke.dt <- data.table::data.table(stroke1yr)


  # Re-order columns to the order patients will enter their variables information
  # into the shiny app
  new.var.order <-  c("age",
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
                      "year2000")

  setcolorder(stroke.dt,new.var.order)
  setkeyv(stroke.dt, new.var.order)

  input_id_vec <- c("user_age",
                    "sex",
                    "stroke",
                    "hf",
                    "diabetes",
                    "hyperT",
                    "vasc")

  button.width <- "320px"

  shinyApp(
    ui <- fluidPage(
      # Application title
      # shinythemes::themeSelector(),

      titlePanel(title_txt),
      theme = shinythemes::shinytheme(theme = "yeti"),

      # Give CSS styles to selected elements
      tags$head(

        tags$style(type = "text/css", "#results {max-width:620px;}"),
        tags$style(type = "text/css", "#input_col {max-width:380px;}"), #max width input
        tags$style(type = "text/css", ".container-fluid {margin:auto; max-width: 1000px}"),
        tags$style("#user_age {font-size:38px;height:50px; width: 110px;}"), # font size
        tags$style(paste0("#stroke_results_text {font-size:", out_stroke_text_size, "}")),
        tags$style(paste0("#out_intro {font-size:", out_intro_size, "}")),
        tags$style(paste0("#references {font-size:", references_size, "}")) # font size
      ),
      # Sidebar with a slider input for number of bins
      fluidRow(
        column(id = "input_col", 6,
               # toggleClass("column_id", "custom_class")
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
                   choices = c(
                     "Unknown" = depSub(c(no, yes)),
                     "Male" = depSub(no),
                     "Female" = depSub(yes)
                   ),
                   checkIcon = list(yes = icon("check")),
                   selected =  depSub(c(no, yes)),
                   justified = TRUE,
                   width = button.width
                 ),

                 shinyWidgets::radioGroupButtons(
                   inputId = "stroke",
                   label = in_stroke,
                   choiceNames = c(HTML("Unknown"), "No", "Yes"),
                   selected =  depSub(c(no, yes)),
                   choiceValues = c(depSub(c(no, yes)),
                                    depSub(no),
                                    depSub(yes)),
                   checkIcon = list(yes = icon("check")),
                   justified = TRUE,
                   width = button.width
                 ),
                 shinyWidgets::radioGroupButtons(
                   inputId = "hf",
                   label = in_hf,
                   choiceNames = c(HTML("Unknown"), "No", "Yes"),
                   selected =  depSub(c(no, yes)),
                   choiceValues = c(depSub(c(no, yes)),
                                    depSub(no),
                                    depSub(yes)),
                   checkIcon = list(yes = icon("check")),
                   justified = TRUE,
                   width = button.width
                 ),
                 shinyWidgets::radioGroupButtons(
                   inputId = "diabetes",
                   label = in_diab,
                   choiceNames = c(HTML("Unknown"), "No", "Yes"),
                   selected =  depSub(c(no, yes)),
                   choiceValues = c(depSub(c(no, yes)),
                                    depSub(no),
                                    depSub(yes)),
                   checkIcon = list(yes = icon("check")),
                   justified = TRUE,
                   width = button.width
                 ),
                 shinyWidgets::radioGroupButtons(
                   inputId = "hyperT",
                   label = in_hyperT,
                   choiceNames = c(HTML("Unknown"), "No", "Yes"),
                   selected =  depSub(c(no, yes)),
                   choiceValues = c(depSub(c(no, yes)),
                                    depSub(no),
                                    depSub(yes)),
                   checkIcon = list(yes = icon("check")),
                   justified = TRUE,
                   width = button.width
                 ),
                 shinyWidgets::radioGroupButtons(
                   inputId = "vasc",
                   label = in_vasc,
                   choiceNames = c(HTML("Unknown"), "No", "Yes"),
                   selected =  depSub(c(no, yes)),
                   choiceValues = c(depSub(c(no, yes)),
                                    depSub(no),
                                    depSub(yes)),
                   checkIcon = list(yes = icon("check")),
                   justified = TRUE,
                   width = button.width
                 ),
                 tags$script(jsButtonColor("stroke", "#B2EDB5", "no")),
                 tags$script(jsButtonColor("hf", "#B2EDB5", "no")),
                 tags$script(jsButtonColor("diabetes", "#B2EDB5", "no")),
                 tags$script(jsButtonColor("hyperT", "#B2EDB5", "no")),
                 tags$script(jsButtonColor("vasc", "#B2EDB5", "no")),

                 tags$script(jsButtonColor("stroke", "#EDB6B2", "yes")),
                 tags$script(jsButtonColor("hf", "#EDB6B2", "yes")),
                 tags$script(jsButtonColor("diabetes", "#EDB6B2", "yes")),
                 tags$script(jsButtonColor("hyperT", "#EDB6B2", "yes")),
                 tags$script(jsButtonColor("vasc", "#EDB6B2", "yes"))


               )),

        # Show a plot of the generated distribution
        column(id = "results",
               6,
               div(id = "out_intro", out_intro),
               br(),
               div(id = "stroke_results_text", out_stroke),
               tags$h2(strong(textOutput("strokeRisk"))),
               div(id = "out_stroke_details", out_stroke_details),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               br(),
               div(id = "references", references),
               hr(),
               br(),
               tags$h4(("Table below only for testing - will not be included in final version")
               ),
               br(),
               br(),
               br(),
               DT::dataTableOutput("table")
        )
      )),


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
        if (is.valid.age(age_as_number)) {
          # browser()
          input_parse <- list()
          for (i in input_id_vec[2:length(input_id_vec)]) {

            input_parse[[i]] <- parse(text = input[[i]])
            if (length(input_parse[[i]][[1]]) == 3) {
              input_parse[[i]][[1]][[2]] <- "no"
              input_parse[[i]][[1]][[3]] <- "yes"
            } else if (input_parse[[i]][[1]] == "no") {
              input_parse[[i]][[1]] <- "no"
            } else {
              input_parse[[i]][[1]] <- "yes"
            }
          }

          dat.sub <- stroke.dt[age == age_as_number &
                                 female %in% eval(input_parse[["sex"]]) &
                                 stroke %in% eval(input_parse[["stroke"]]) &
                                 heartfailure %in% eval(input_parse[["hf"]]) &
                                 diabetes %in% eval(input_parse[["diabetes"]]) &
                                 hypertension %in% eval(input_parse[["hyperT"]]) &
                                 vascular %in% eval(input_parse[["vasc"]]),
                               range(stroke1y)]

          test  <- stroke.dt[age == age_as_number &
                                          female %in% eval(input_parse[["sex"]]) &
                                          stroke %in% eval(input_parse[["stroke"]]) &
                                          heartfailure %in% eval(input_parse[["hf"]]) &
                                          diabetes %in% eval(input_parse[["diabetes"]]) &
                                          hypertension %in% eval(input_parse[["hyperT"]]) &
                                          vascular %in% eval(input_parse[["vasc"]]),
                                        c(1,2,3,10)]

          browser()
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
        else {
          paste0(enter_age)
        }

      })



      output$table <- DT::renderDataTable(
        DT::datatable(filter = "none",
                      rownames = FALSE,
                      options = list(sDom  = '<"top">rt<"bottom">ip'),
                      stroke.dt[age == input$user_age &
                                  female %in% evPar(input$sex) &
                                  stroke %in% evPar(input$stroke) &
                                  heartfailure %in% evPar(input$hf) &
                                  diabetes %in% evPar(input$diabetes) &
                                  hypertension %in% evPar(input$hyperT) &
                                  vascular %in% evPar(input$vasc),
                                c(1,2,3,10, 16)])
      )
    }
  )
}


