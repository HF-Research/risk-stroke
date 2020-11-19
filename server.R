shinyServer(function(input, output, session) {

  # session$onSessionEnded(stopApp)
  source(file.path("server", "server_stroke.R"),
         encoding = "UTF-8",
         local = TRUE)$value
  source(file.path("server", "server_about.R"), local = TRUE)$value


# IE WARNING --------------------------------------------------------------

  observeEvent(label = "IEwarning",  input$check, {
    if (input$check == "TRUE") {
      showModal(
        modalDialog(
          title = "CARS does not work with Internet Explorer",
          easyClose = TRUE,
          fade = TRUE,
          tags$p(
            "Please choose Firefox / /Brave / Safari / Chrome"
          )

        )
      )
    }
  })



})
