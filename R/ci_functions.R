#' Generate sample data for confidence interval visualization
#'
#' @param true_mean True population mean
#' @param sd Population standard deviation
#' @param n Sample size
#' @param confidence_level Confidence level (e.g., 0.95 for 95%)
#' @param num_samples Number of samples to visualize
#'
#' @return A list containing multiple confidence intervals and their properties
#'
#' @export
generate_ci_data <- function(true_mean = 0, sd = 1, n = 30, confidence_level = 0.95, num_samples = 20) {
  # Calculate critical value for confidence interval
  alpha <- 1 - confidence_level
  t_critical <- qt(1 - alpha/2, df = n - 1)
  
  samples <- list()
  means <- numeric(num_samples)
  se <- numeric(num_samples)  # standard error
  lower_bounds <- numeric(num_samples)
  upper_bounds <- numeric(num_samples)
  contains_true <- logical(num_samples)
  
  for (i in 1:num_samples) {
    # Generate a sample
    sample_data <- rnorm(n, true_mean, sd)
    
    # Calculate sample statistics
    sample_mean <- mean(sample_data)
    sample_se <- sd / sqrt(n)  # Using known population SD
    
    # Calculate confidence interval
    margin_error <- t_critical * sample_se
    ci_lower <- sample_mean - margin_error
    ci_upper <- sample_mean + margin_error
    
    # Store results
    means[i] <- sample_mean
    se[i] <- sample_se
    lower_bounds[i] <- ci_lower
    upper_bounds[i] <- ci_upper
    contains_true[i] <- ci_lower <= true_mean & ci_upper >= true_mean
  }
  
  df <- data.frame(
    sample = 1:num_samples,
    mean = means,
    lower = lower_bounds,
    upper = upper_bounds,
    contains_true = contains_true
  )
  
  coverage_rate <- sum(contains_true) / num_samples
  
  results <- list(
    data = df,
    true_mean = true_mean,
    coverage_rate = coverage_rate,
    expected_coverage = confidence_level,
    confidence_level = confidence_level,
    sample_size = n
  )
  
  return(results)
}

#' Create confidence interval visualization
#'
#' @param ci_data Output from generate_ci_data()
#'
#' @return A ggplot object
#'
#' @export
create_ci_plot <- function(ci_data) {
  # Create the plot
  p <- ggplot(ci_data$data, aes(x = sample, y = mean, color = contains_true)) +
    geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.2, size = 1) +
    geom_point(size = 3) +
    geom_hline(yintercept = ci_data$true_mean, color = "red", size = 1.2, linetype = "dashed") +
    scale_color_manual(values = c("TRUE" = "blue", "FALSE" = "red"), 
                       name = "Contains\nTrue Mean") +
    labs(
      title = paste("Confidence Intervals (", ci_data$confidence_level*100, "% level)", sep=""),
      x = "Sample Number",
      y = "Sample Mean",
      caption = paste("True mean =", ci_data$true_mean, 
                      ", Coverage rate =", round(ci_data$coverage_rate, 3),
                      ", n =", ci_data$sample_size)
    ) +
    theme_minimal() +
    theme(legend.position = "bottom") +
    ylim(min(c(ci_data$data$lower, ci_data$true_mean)) - 0.2, 
         max(c(ci_data$data$upper, ci_data$true_mean)) + 0.2)
  
  return(p)
}