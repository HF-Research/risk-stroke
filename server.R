library(shiny)

shinyServer(function(input, output) {


  # REACTIVE FUNCTIONS ------------------------------------------------------
  txt2num <- reactive({
    as.numeric(input$user_age)
  })

  subsetStroke <- reactive({
    # Reactive function will cache it's output. It will only run again if input
    # has changed, otherwise, repeated calls to it will only access the cached
    # values, not re-calculate.
    stroke.dt[age == txt2num() &
                female %in% input$sex &
                stroke %in% input$stroke &
                heartfailure %in% input$hf &
                diabetes %in% input$diabetes &
                hypertension %in% input$hyperT &
                vascular %in% input$vasc,
              stroke1y]
  })

  subsetBleed <- reactive({
    bleed.dt[age == txt2num() &
               hypertension %in% input$hyperT &
               stroke %in% input$stroke &
               ckd %in% input$ckd &
               bleeding %in% input$bleeding &
               drugs %in% input$drugs,
             bleeding1y]
  })



  # WRITE STROKE OUTPUT -----------------------------------------------------
  output$strokeRisk <- renderText({
    outputHelper1(subsetStroke(), txt2num(), enter_age)
  })

  output$stroke_desc1 <- renderText({
    ifelse(is.valid.age(txt2num()), out_stroke, "")
  })

  output$stroke_desc2 <- renderText({
    outputHelper2(data = subsetStroke(),
                  age = txt2num(),
                  out2 = out_stroke2,
                  out3 = out_stroke3,
                  outLessOne = out_strokeLessOne)

  })

  # WRITE BLEEDING OUTPUT ---------------------------------------------------
  output$bleedRisk <- renderText({
    outputHelper1(subsetBleed(), txt2num(), enter_age)
  })

  output$bleed_desc1 <- renderText({
    ifelse(is.valid.age(txt2num()), out_bleeding1, "")
  })

  output$bleed_desc2 <- renderText({
    outputHelper2(data = subsetBleed(),
                  age = txt2num(),
                  out2 = out_bleeding2,
                  out3 = out_bleeding3,
                  outLessOne = out_bleedingLessOne)

  })



  # VISUALIZE NUMBER OF SICK - STROKE ---------------------------------------
  output$plot_stroke <- renderUI({
    # Get the values for the board:
    # browser()
    if(is.valid.age(txt2num())) {
      n_sick_stroke <- round(subsetStroke(), digits = 0)
      n_population <- 100
      board_fill <- c(rep(0, n_population - n_sick_stroke),
                      rep(1, n_sick_stroke))
      n_rows <- 10
      n_cols <- 10
      board <- matrix(board_fill,
                      nrow = n_rows,
                      ncol = n_cols, byrow = TRUE)

      # Assign appropriate div IDs to each cell in the board:
      isolate({

        div(
          id = "board-inner",
          lapply(seq(n_rows), function(row) {
            tagList(
              div(
                class = "board-row",
                lapply(seq(n_cols), function(col) {
                  # browser()
                  value <- board[row, col]
                  # value <- board_entries(values$board)[row, col]
                  visClass <- ifelse(value == 0, "off", "on")
                  id <- sprintf("cell-%s-%s", row, col)
                  div(
                    id = id,
                    class = paste("board-cell", visClass)
                  )
                })
              ),
              # This empty div seems to provide a way to "break" the rows. Without this
              # div element, the rows all move to one long line
              div()
            )
          })
        )
      })
    }
  })


})
