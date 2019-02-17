#' @keywords internal
model_text_initial_lm <- function(parameters, ci = 0.95, ...) {
  intercept <- parameters[parameters$Parameter == "(Intercept)", ]

  text <- paste0(
    "The model's intercept is at ",
    format_value(intercept$beta),
    "."
  )
  text_full <- paste0(
    "The model's intercept is at ",
    format_value(intercept$beta),
    "(t(",
    format_value_unless_integers(intercept$DoF_residual),
    ") = ",
    format_value(intercept$t),
    ", ",
    format_ci(intercept$CI_low, intercept$CI_high, ci),
    ", p ",
    format_p(intercept$p),
    ")."
  )

  out <- list(
    "text" = text,
    "text_full" = text_full
  )
  return(out)
}












#' @keywords internal
model_text_initial_bayesian <- function(parameters, ci = 0.90, ...) {
  intercept <- parameters[parameters$Parameter == "(Intercept)", ]

  if ("Median" %in% names(intercept)) {
    text <- paste0(
      "The model's intercept's median is ",
      format_value(intercept$Median),
      "."
    )
    text_full <- paste0(
      "The model's intercept's median is ",
      format_value(intercept$Median),
      " (MAD = ",
      format_value(intercept$MAD),
      ", ",
      format_ci(intercept$CI_low, intercept$CI_high, ci)
    )
  } else if ("Mean" %in% names(intercept)) {
    text <- paste0(
      "The model's intercept's mean is ",
      format_value(intercept$Mean),
      "."
    )
    text_full <- paste0(
      "The model's intercept's mean is ",
      format_value(intercept$Mean),
      " (MAD = ",
      format_value(intercept$SD),
      ", ",
      format_ci(intercept$CI_low, intercept$CI_high, ci)
    )
  } else if ("MAP" %in% names(intercept)) {
    text <- paste0(
      "The model's intercept's MAP is ",
      format_value(intercept$MAP),
      "."
    )
    text_full <- paste0(
      "The model's intercept's MAP is ",
      format_value(intercept$MAP),
      " (",
      format_ci(intercept$CI_low, intercept$CI_high, ci)
    )
  } else {
    text <- ""
    text_full <- "The intercept has no estimate ("
  }


  if ("pd" %in% names(intercept)) {
    text_full <- paste0(
      text_full,
      ", ",
      format_pd(intercept$pd)
    )
  }

  if ("ROPE_Percentage" %in% names(intercept)) {
    text_full <- paste0(
      text_full,
      ", ",
      format_rope(intercept$ROPE_Percentage)
    )
  }

  text_full <- paste0(text_full, ").")

  out <- list(
    "text" = text,
    "text_full" = text_full
  )
  return(out)
}