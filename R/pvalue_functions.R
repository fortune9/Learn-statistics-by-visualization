#' Generate sample data for P-value visualization
#'
#' @param n Sample size
#' @param mean_true True mean under alternative hypothesis
#' @param mean_null Null hypothesis mean
#' @param sd Standard deviation
#' @param test_type Type of test ("two.sided", "less", "greater")
#' @param alpha Significance level
#'
#' @return A list containing the sample data and test statistics
#'
#' @export
generate_pvalue_data <- function(n = 30, mean_true = 0.5, mean_null = 0, sd = 1, test_type = "two.sided", alpha = 0.05) {
  # Generate sample data
  sample_data <- rnorm(n, mean = mean_true, sd = sd)
  
  # Perform t-test
  test_result <- t.test(sample_data, mu = mean_null, alternative = test_type)
  
  # Calculate standard error
  se <- sd(sample_data) / sqrt(n)
  
  # Calculate critical value
  df <- n - 1
  if (test_type == "two.sided") {
    crit_value <- qt(1 - alpha/2, df)
  } else if (test_type == "greater") {
    crit_value <- qt(1 - alpha, df)
  } else {  # "less"
    crit_value <- qt(alpha, df)
  }
  
  # Collect results
  results <- list(
    sample_data = sample_data,
    sample_mean = mean(sample_data),
    sample_se = se,
    test_result = test_result,
    critical_value = crit_value,
    p_value = test_result$p.value,
    reject_null = test_result$p.value < alpha
  )
  
  return(results)
}

#' Create P-value visualization
#'
#' @param pvalue_data Output from generate_pvalue_data()
#' @param mean_null The mean under the null hypothesis
#'
#' @return A ggplot object
#'
#' @export
create_pvalue_plot <- function(pvalue_data, mean_null = 0) {
  # Get required values
  sample_mean <- pvalue_data$sample_mean
  se <- pvalue_data$sample_se
  p_value <- pvalue_data$p_value
  df <- length(pvalue_data$sample_data) - 1
  test_type <- attr(pvalue_data$test_result$alternative, "names")
  
  # Create x values for the t-distribution
  se <- pvalue_data$sample_se
  t_stat <- (sample_mean - mean_null) / se
  df <- length(pvalue_data$sample_data) - 1
  
  # Set up the x-axis values for plotting
  x_min <- mean_null - 4 * se
  x_max <- mean_null + 4 * se
  x <- seq(x_min, x_max, length.out = 500)
  
  # Calculate y values (density) for the t-distribution
  y <- dt((x - mean_null) / se, df) / se
  
  # Create a data frame
  df_plot <- data.frame(x = x, y = y)
  
  # Create the plot
  p <- ggplot(df_plot, aes(x = x, y = y)) +
    geom_line(size = 1) +
    geom_vline(xintercept = sample_mean, color = "blue", size = 1, linetype = "dashed") +
    geom_vline(xintercept = mean_null, color = "black", size = 1) +
    labs(
      title = paste("Sampling Distribution Under H₀ (μ =", mean_null, ")"),
      x = "Sample Mean",
      y = "Density",
      caption = paste("Observed mean =", round(sample_mean, 3), 
                      ", P-value =", round(p_value, 4))
    ) +
    theme_minimal()
  
  # Add shaded area based on test type
  if (test_type == "two.sided") {
    # For two-sided test, shade both tails beyond |t_stat|
    lower_tail_x <- seq(x_min, mean_null - abs(t_stat) * se, length.out = 100)
    upper_tail_x <- seq(mean_null + abs(t_stat) * se, x_max, length.out = 100)
    
    lower_tail_y <- dt((lower_tail_x - mean_null) / se, df) / se
    upper_tail_y <- dt((upper_tail_x - mean_null) / se, df) / se
    
    lower_shade <- data.frame(x = c(lower_tail_x[1], lower_tail_x, rev(lower_tail_x)[1]), 
                              y = c(0, lower_tail_y, 0))
    upper_shade <- data.frame(x = c(upper_tail_x[1], upper_tail_x, rev(upper_tail_x)[1]), 
                              y = c(0, upper_tail_y, 0))
    
    # Add the shaded areas to the plot
    p <- p +
      geom_area(data = lower_shade, aes(x = x, y = y), fill = "red", alpha = 0.5) +
      geom_area(data = upper_shade, aes(x = x, y = y), fill = "red", alpha = 0.5)
  } else if (test_type == "greater") {
    # For right-tailed test, shade the right tail beyond the observed value
    if (sample_mean > mean_null) {
      greater_tail_x <- seq(sample_mean, x_max, length.out = 100)
      greater_tail_y <- dt((greater_tail_x - mean_null) / se, df) / se
      
      greater_shade <- data.frame(x = c(greater_tail_x[1], greater_tail_x, rev(greater_tail_x)[1]), 
                                  y = c(0, greater_tail_y, 0))
      
      p <- p + geom_area(data = greater_shade, aes(x = x, y = y), fill = "red", alpha = 0.5)
    }
  } else {  # "less"
    # For left-tailed test, shade the left tail beyond the observed value
    if (sample_mean < mean_null) {
      less_tail_x <- seq(x_min, sample_mean, length.out = 100)
      less_tail_y <- dt((less_tail_x - mean_null) / se, df) / se
      
      less_shade <- data.frame(x = c(less_tail_x[1], less_tail_x, rev(less_tail_x)[1]), 
                               y = c(0, less_tail_y, 0))
      
      p <- p + geom_area(data = less_shade, aes(x = x, y = y), fill = "red", alpha = 0.5)
    }
  }
  
  return(p)
}