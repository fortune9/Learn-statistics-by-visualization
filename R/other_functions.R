#' Generate sample data for chi-square test visualization
#'
#' @param observed Observed frequencies
#' @param expected Expected frequencies (optional, if not provided will be calculated)
#' @param alpha Significance level
#'
#' @return A list containing chi-square test results and visualization data
#'
#' @export
generate_chisq_data <- function(observed = c(10, 15, 20, 25), expected = NULL, alpha = 0.05) {
  n <- sum(observed)
  
  if (is.null(expected)) {
    # Equal expected frequencies
    expected <- rep(n / length(observed), length(observed))
  }
  
  # Perform chi-square test
  chisq_result <- chisq.test(observed, p = expected/n)
  
  # Create data frame for visualization
  df <- data.frame(
    category = 1:length(observed),
    observed = observed,
    expected = expected
  )
  
  results <- list(
    data = df,
    chisq_result = chisq_result,
    p_value = chisq_result$p.value,
    reject_null = chisq_result$p.value < alpha
  )
  
  return(results)
}

#' Create chi-square test visualization
#'
#' @param chisq_data Output from generate_chisq_data()
#'
#' @return A ggplot object
#'
#' @export
create_chisq_plot <- function(chisq_data) {
  # Reshape data for plotting
  library(tidyr)
  library(dplyr)
  
  df_long <- chisq_data$data %>%
    pivot_longer(cols = c(observed, expected), names_to = "type", values_to = "value")
  
  # Create the plot
  p <- ggplot(df_long, aes(x = factor(category), y = value, fill = type)) +
    geom_col(position = "dodge", alpha = 0.7) +
    geom_text(aes(label = value, y = value + max(chisq_data$data$observed) * 0.02), 
              position = position_dodge(width = 0.9), vjust = 0) +
    labs(
      title = paste("Chi-square Test Visualization", 
                    ifelse(chisq_data$reject_null, "(Significant)", "(Not Significant)")),
      x = "Category",
      y = "Frequency",
      fill = "Type",
      caption = paste("Chi-square =", round(chisq_data$chisq_result$statistic, 3),
                      ", P-value =", round(chisq_data$p_value, 4))
    ) +
    theme_minimal() +
    theme(legend.position = "bottom")
  
  return(p)
}

#' Generate sample data for Wilcoxon Ranksum test visualization
#'
#' @param n1 Sample size for group 1
#' @param n2 Sample size for group 2
#' @param location1 Location parameter for group 1
#' @param location2 Location parameter for group 2
#' @param alpha Significance level
#'
#' @return A list containing Wilcoxon test results and visualization data
#'
#' @export
generate_wilcox_data <- function(n1 = 15, n2 = 15, location1 = 0, location2 = 0.2, alpha = 0.05) {
  # Generate sample data for both groups
  group1_data <- rnorm(n1, mean = location1, sd = 1)
  group2_data <- rnorm(n2, mean = location2, sd = 1)
  
  # Combine data into a data frame
  df <- data.frame(
    value = c(group1_data, group2_data),
    group = factor(rep(c("Group1", "Group2"), c(n1, n2)))
  )
  
  # Perform Wilcoxon ranksum test
  test_result <- wilcox.test(value ~ group, data = df)
  
  # Calculate summary statistics
  group_summary <- df %>% 
    group_by(group) %>%
    summarise(
      median_val = median(value),
      mean_val = mean(value),
      n = n(),
      .groups = 'drop'
    )
  
  results <- list(
    data = df,
    group_summary = group_summary,
    test_result = test_result,
    p_value = test_result$p.value,
    reject_null = test_result$p.value < alpha
  )
  
  return(results)
}

#' Create Wilcoxon Ranksum test visualization
#'
#' @param wilcox_data Output from generate_wilcox_data()
#'
#' @return A ggplot object
#'
#' @export
create_wilcox_plot <- function(wilcox_data) {
  # Create the plot
  p <- ggplot(wilcox_data$data, aes(x = group, y = value, color = group)) +
    geom_boxplot(alpha = 0.7) +
    geom_jitter(width = 0.1, size = 1, alpha = 0.5) +
    geom_point(data = wilcox_data$group_summary, 
               aes(x = group, y = median_val), 
               shape = 18, size = 5, color = "black") +
    labs(
      title = paste("Wilcoxon Ranksum Test", 
                    ifelse(wilcox_data$reject_null, "(Significant)", "(Not Significant)")),
      x = "Group",
      y = "Value",
      color = "Group",
      caption = paste("W =", round(wilcox_data$test_result$statistic, 3),
                      ", P-value =", round(wilcox_data$p_value, 4))
    ) +
    theme_minimal() +
    theme(legend.position = "bottom")
  
  return(p)
}

#' Generate sample data for regression analysis visualization
#'
#' @param n Sample size
#' @param slope Slope of the regression line
#' @param intercept Intercept of the regression line
#' @param error_sd Standard deviation of the error term
#' @param alpha Significance level
#'
#' @return A list containing regression results and visualization data
#'
#' @export
generate_regression_data <- function(n = 50, slope = 0.5, intercept = 2, error_sd = 1, alpha = 0.05) {
  # Generate predictor values
  x <- runif(n, min = 0, max = 10)
  
  # Generate response values with some noise
  y <- intercept + slope * x + rnorm(n, mean = 0, sd = error_sd)
  
  # Create data frame
  df <- data.frame(x = x, y = y)
  
  # Fit linear model
  model <- lm(y ~ x, data = df)
  summary_model <- summary(model)
  
  # Extract residuals
  df$residuals <- residuals(model)
  df$fitted <- fitted(model)
  
  results <- list(
    data = df,
    model = model,
    summary = summary_model,
    p_value = summary_model$coefficients[2, 4],  # P-value for slope
    r_squared = summary_model$r.squared,
    reject_null = summary_model$coefficients[2, 4] < alpha,
    slope = slope,
    intercept = intercept
  )
  
  return(results)
}

#' Create regression analysis visualization
#'
#' @param reg_data Output from generate_regression_data()
#'
#' @return A ggplot object
#'
#' @export
create_regression_plot <- function(reg_data) {
  # Create the main regression plot
  p <- ggplot(reg_data$data, aes(x = x, y = y)) +
    geom_point(alpha = 0.7) +
    geom_smooth(method = "lm", se = TRUE, color = "red", fill = "pink") +
    labs(
      title = paste("Linear Regression Analysis", 
                    ifelse(reg_data$reject_null, "(Significant)", "(Not Significant)")),
      x = "X (Predictor)",
      y = "Y (Response)",
      caption = paste("Slope =", round(reg_data$summary$coefficients[2, 1], 3),
                      ", P-value =", round(reg_data$p_value, 4),
                      ", R² =", round(reg_data$r_squared, 3))
    ) +
    theme_minimal()
  
  return(p)
}

#' Create residuals plot for regression analysis
#'
#' @param reg_data Output from generate_regression_data()
#'
#' @return A ggplot object
#'
#' @export
create_residuals_plot <- function(reg_data) {
  # Create residuals vs fitted plot
  p <- ggplot(reg_data$data, aes(x = fitted, y = residuals)) +
    geom_point(alpha = 0.7) +
    geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
    geom_smooth(se = FALSE) +
    labs(
      title = "Residuals vs Fitted Values",
      x = "Fitted Values",
      y = "Residuals"
    ) +
    theme_minimal()
  
  return(p)
}