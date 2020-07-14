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
              diabetes %in% input$dm &
              hypertension %in% input$hyper_t &
              vascular %in% input$vasc,
            stroke1y]
})

# VALID AGE OUTPUT --------------------------------------------------------
enterAge <- reactive({
  if (!is.valid.age(txt2num()))
    enter_age
})

output$enter_age <- renderText(enterAge())

# SHOW/HIDE LOGIC ---------------------------------------------------------

observe({
  shinyjs::toggle(
    id = "plot_matrix",
    condition = is.valid.age(txt2num()),
    anim = TRUE,
    time = 0.2
  )
})


# WRITE STROKE OUTPUT -----------------------------------------------------
output$strokeRisk <- renderText({
  outputHelper1(subsetStroke(), txt2num(), enter_age)
})

output$stroke_desc1 <- renderText({
  ifelse(is.valid.age(txt2num()), results_stroke_header, "")
})

output$stroke_desc2 <- renderText({
  outputHelper2(
    data = subsetStroke(),
    age = txt2num(),
    out2 = out_stroke2,
    out3 = out_stroke3,
    outLessOne = out_strokeLessOne
  )

})



# GAUGE PLOT --------------------------------------------------------------

output$plot_risk_gauge <- renderD3({
  if (is.valid.age(txt2num())) {
    r2d3(subsetStroke(), script = "gauge.js")

  }
})

# VISUALIZE NUMBER OF SICK - STROKE ---------------------------------------
output$plot_stroke <- renderUI({
  # Get the values for the board:

  if (is.valid.age(txt2num())) {
    risk_matrix_viz(
      subset_stroke = subsetStroke(),
      n_pop = 100,
      n_rows = 10,
      n_cols = 10
    )

  }
})


