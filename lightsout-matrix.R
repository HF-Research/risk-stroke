# All functions in this script were dervied from Dean Attali and his work on the
# "lightouts" package

new_board <- function(entries, classic = TRUE) {
  allowed_sizes <- c(3:32)

  # If a vector was provided, turn it into a matrix
  if (is.vector(entries)) {
    n <- sqrt(length(entries))
    if (n %% 1 != 0) {
      stop("`entries` cannot be transformed into a square matrix. Make sure the vector length matches a square.",
           call. = FALSE)
    }
    entries <- matrix(entries, ncol = n, nrow = n, byrow = TRUE)
  }

  # Make sure the matrix is square
  if (nrow(entries) != ncol(entries)) {
    stop("The board must be a square matrix",
         call. = FALSE)
  }

  # Make sure the matrix is a valid size
  n <- nrow(entries)
  if (!n %in% allowed_sizes) {
    stop(paste0("Only the following board dimensions are allowed: [",
                paste(allowed_sizes, collapse = ","), "]"),
         call. = FALSE)
  }

  # Make sure all entries are 0 or 1
  if (sum(entries > 1 | entries < 0) > 0) {
    stop("Only values of 0 (light off) and 1 (light on) are allowed in the board",
         call. = FALSE)
  }

  # Make sure the matrix we store is a plain matrix with just the numbers,
  # in case the user passed in a matrix with more junk attached to it
  entries <- matrix(entries, ncol = n, nrow = n)

  # Generate the toggle matrix (used for solving the board)
  toggle_matrix <- generate_lightsout_matrix(n, classic)

  board <- list(
    entries = entries,
    size = n,
    classic = classic,
    toggle_matrix = toggle_matrix
  )

  structure(board, class = "lightsout")
}

empty_board <- function(size, classic = TRUE) {
  new_board(entries = rep(0, size*size), classic = classic)
}


generate_lightsout_matrix <- function(size, classic = TRUE) {
  mat <- matrix(0, ncol = size*size, nrow = size*size)

  for (i in seq(size)) {
    for (j in seq(size)) {
      row <- size * (i - 1) + j
      mat[row, row] <- 1
      if (classic) {
        if (i > 1)    mat[row, row - size] <- 1
        if (i < size) mat[row, row + size] <- 1
        if (j > 1)    mat[row, row - 1] <- 1
        if (j < size) mat[row, row + 1] <- 1
      } else {
        mat[row, size * (i - 1) + seq(size)] <- 1
        mat[row, size * seq(size - 1) + (j - 1) + 1] <- 1
      }
    }
  }

  mat
}


print.lightsout <- function(x, ...) {
  cat("Lights Out ", board_size(x), "x", board_size(x), " board", "\n", sep = "")
  cat("Game mode:", ifelse(board_classic(x), "classic", "entire row/column"), "\n\n\t")
  utils::write.table(board_entries(x), row.names = FALSE, col.names = FALSE, eol = "\n\t")
}

board_size <- function(board) {
  stopifnot(inherits(board, "lightsout"))
  board[['size']]
}

board_classic <- function(board) {
  stopifnot(inherits(board, "lightsout"))
  board[['classic']]
}

board_entries <- function(board) {
  stopifnot(inherits(board, "lightsout"))
  board[['entries']]
}
empty_board(32)
32*32
