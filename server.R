library(shiny)

shinyServer(function(input, output) {


# REACTIVE FUNCTIONS ------------------------------------------------------
  txt2num <- reactive({
    as.numeric(input$user_age)
  })

  subsetStroke <- reactive({
    # Reactive function will save it's output. It will only run again if input
    # has changed, otherwise, repeated calls to it will access the cached values
    # only
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
    # Order of subset arguments must be same order as new.col.order variable set in
    # intro.

    if (!is.valid.age(txt2num())) {
      enter_age
    } else {
      ifelse(subsetStroke() < 0.1,
             paste0("<0.1%"),
             paste0(sprintf(
               "%.1f",
               round(subsetStroke(),
                     digits = 1)
             ),
             "%"))
    }
  })

  output$stroke_desc1 <- renderText({
    ifelse(is.valid.age(txt2num()), out_stroke, "")
  })

  output$stroke_desc2 <- renderText({
    # browser()

    if (is.valid.age(txt2num())) {
      number_strokes <-
        (round(subsetStroke(), digits = 1) * 0.01 * 1000)
      ifelse(
        number_strokes >= 1,
        paste0(out_stroke2, number_strokes, out_stroke3),
        out_strokeLessOne
      )
    } else {
      ""
    }
  })

# WRITE BLEEDING OUTPUT ---------------------------------------------------
  output$bleedRisk <- renderText({
    # browser()
    if (!is.valid.age(txt2num())) {
      enter_age
    } else {
      ifelse(subsetBleed() < 0.1,µ
             paste0("<0.1%"),
             paste0(sprintf(
               "%.1f",
               round(subsetBleed(),
                     digits = 1)
             ),
             "%"))
    }
  })

  output$bleed_desc1 <- renderText({
    ifelse(is.valid.age(txt2num()), out_bleeding1, "")
  })

  output$bleed_desc2 <- renderText({
    if (is.valid.age(txt2num())) {
      number_bleed <-
        (round(subsetBleed(), digits = 1) * 0.01 * 1000)
      ifelse(
        number_bleed >= 1,
        paste0(out_bleeding2, number_bleed, out_bleeding3),
        out_bleedingLessOne
      )
    } else {
      ""
    }
  })


})
