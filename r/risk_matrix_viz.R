##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##'
##' @title
##' @param subset_stroke
##' @param n_pop
##' @param n_rows
##' @param n_cols
risk_matrix_viz <- function(subset_stroke, n_pop = 100, n_rows = 10, n_cols =
                            10) {

  n_sick_stroke <- round(subset_stroke, digits = 0)
  n_population <- 100
  board_fill <- c(rep(0, n_population - n_sick_stroke),
                  rep(1, n_sick_stroke))
  n_rows <-
    n_cols <- 10
  board <- matrix(board_fill,
                  nrow = n_rows,
                  ncol = n_cols,
                  byrow = TRUE)

  # Assign appropriate div IDs to each cell in the board:

  div(id = "board-inner",
      lapply(seq(n_rows), function(row) {
        tagList(div(class = "board-row",
                    lapply(seq(n_cols), function(col) {
                      # browser()
                      value <- board[row, col]
                      # value <- board_entries(values$board)[row, col]
                      visClass <- ifelse(value == 0, "off", "on")
                      id <- sprintf("cell-%s-%s", row, col)
                      div(id = id,
                          class = paste("board-cell", visClass))
                    })),
                # This empty div seems to provide a way to "break" the rows. Without this
                # div element, the rows all move to one long line
                div())
      }))


}
