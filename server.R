library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

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


})
