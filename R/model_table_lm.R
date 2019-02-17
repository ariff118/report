#' Create Tables for Linear Models
#
#' @param model Object of class \link{lm}.
#' @param parameters Parameters table \link{model_parameters}.
#' @param performance Performance table \link{model_performance}.
#' @param performance_in_table Add performance metrics on table.
#' @param ... Arguments passed to or from other methods (see \link{model_parameters} and \link{model_performance}).
#'
#' @keywords internal
model_table_lm <- function(model, parameters, performance, performance_in_table = TRUE, ...) {
  table_full <- parameters
  table <- table_full
  table <- table[, colnames(table) %in% c("Parameter", "beta", "CI_low", "CI_high", "p", "Std_beta", "Effect_Size")]

  if (performance_in_table) {
    table_full[nrow(table_full) + 1, ] <- NA
    table[nrow(table) + 1, ] <- NA
    # Full ----
    perf <- data.frame(
      "Parameter" = colnames(performance),
      "Fit" = as.numeric(performance[1, ]),
      stringsAsFactors = FALSE
    )
    table_full <- dplyr::full_join(table_full, perf, by = "Parameter")
    # Mini ----
    perf <- data.frame(
      "Parameter" = colnames(performance),
      "Fit" = as.numeric(performance[1, ]),
      stringsAsFactors = FALSE
    ) %>%
      dplyr::filter_("Parameter %in% c('R2', 'R2_adj')")
    table <- dplyr::full_join(table, perf, by = "Parameter")
  }

  class(table_full) <- c("report_table", class(table_full))
  class(table) <- c("report_table", class(table))

  out <- list(
    "table_full" = table_full,
    "table" = table
  )
  return(out)
}