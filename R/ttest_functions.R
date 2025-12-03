#' Generate sample data for t-test visualization
#'
#' @param n1 Sample size for group 1
#' @param n2 Sample size for group 2
#' @param mean1 Mean for group 1
#' @param mean2 Mean for group 2
#' @param sd1 Standard deviation for group 1
#' @param sd2 Standard deviation for group 2
#' @param test_type Type of test ("two.sided", "less", "greater")
#' @param alpha Significance level
#'
#' @return A list containing the sample data and test statistics
#'
#' @export
generate_ttest_data <- function(n1 = 15, n2 = 15, mean1 = 0, mean2 = 0.5, sd1 = 1, sd2 = 1, test_type = "two.sided", alpha = 0.05) {
  # Generate sample data for both groups
  group1_data <- rnorm(n1, mean = mean1, sd = sd1)
  group2_data <- rnorm(n2, mean = mean2, sd = sd2)
  
  # Combine data into a data frame
  df <- data.frame(
    value = c(group1_data, group2_data),
    group = factor(rep(c("Group1", "Group2"), c(n1, n2)))
  )
  
  # Perform t-test
  test_result <- t.test(value ~ group, data = df, alternative = test_type)
  
  # Calculate summary statistics
  group_summary <- df %>% 
    group_by(group) %>%
    summarise(
      mean_val = mean(value),
      sd_val = sd(value),
      n = n(),
      .groups = 'drop'
    )
  
  # Calculate effect size (Cohen's d)
  pooled_sd <- sqrt(((n1-1)*sd1^2 + (n2-1)*sd2^2) / (n1+n2-2))
  cohens_d <- (mean2 - mean1) / pooled_sd
  
  # Collect results
  results <- list(
    data = df,
    group_summary = group_summary,
    test_result = test_result,
    cohens_d = cohens_d,
    p_value = test_result$p.value,
    reject_null = test_result$p.value < alpha
  )
  
  return(results)
}

#' Create t-test visualization
#'
#' @param ttest_data Output from generate_ttest_data()
#'
#' @return A ggplot object
#'
#' @export
create_ttest_plot <- function(ttest_data) {
  # Create the plot
  p <- ggplot(ttest_data$data, aes(x = group, y = value, color = group)) +
    geom_jitter(width = 0.1, size = 2, alpha = 0.7) +
    geom_errorbar(data = ttest_data$group_summary, 
                  aes(x = group, y = mean_val, 
                      ymin = mean_val - sd_val, ymax = mean_val + sd_val),
                  width = 0.1, size = 1) +
    geom_point(data = ttest_data$group_summary, 
               aes(x = group, y = mean_val), 
               shape = 18, size = 5, color = "black") +
    geom_segment(aes(x = 1, xend = 2, y = ttest_data$group_summary$mean_val[1], yend = ttest_data$group_summary$mean_val[2]),
                 color = "red", size = 1.5, linetype = "dashed") +
    labs(
      title = "Comparison of Two Groups",
      x = "Group",
      y = "Value",
      color = "Group",
      caption = paste("Mean diff =", round(diff(ttest_data$group_summary$mean_val), 3), 
                      ", P-value =", round(ttest_data$p_value, 4),
                      ", Cohen's d =", round(ttest_data$cohens_d, 3))
    ) +
    theme_minimal() +
    theme(legend.position = "bottom")
  
  return(p)
}