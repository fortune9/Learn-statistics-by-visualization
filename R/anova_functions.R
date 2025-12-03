#' Generate sample data for ANOVA visualization
#'
#' @param n1 Sample size for group 1
#' @param n2 Sample size for group 2
#' @param n3 Sample size for group 3
#' @param mean1 Mean for group 1
#' @param mean2 Mean for group 2
#' @param mean3 Mean for group 3
#' @param sd1 Standard deviation for group 1
#' @param sd2 Standard deviation for group 2
#' @param sd3 Standard deviation for group 3
#' @param alpha Significance level
#'
#' @return A list containing the sample data and test statistics
#'
#' @export
generate_anova_data <- function(n1 = 10, n2 = 10, n3 = 10, mean1 = 0, mean2 = 0.5, mean3 = 1, 
                                sd1 = 1, sd2 = 1, sd3 = 1, alpha = 0.05) {
  # Generate sample data for all groups
  group1_data <- rnorm(n1, mean = mean1, sd = sd1)
  group2_data <- rnorm(n2, mean = mean2, sd = sd2)
  group3_data <- rnorm(n3, mean = mean3, sd = sd3)
  
  # Combine data into a data frame
  df <- data.frame(
    value = c(group1_data, group2_data, group3_data),
    group = factor(rep(c("Group1", "Group2", "Group3"), c(n1, n2, n3)))
  )
  
  # Perform ANOVA
  aov_result <- aov(value ~ group, data = df)
  anova_result <- anova(aov_result)
  
  # Calculate summary statistics
  group_summary <- df %>% 
    group_by(group) %>%
    summarise(
      mean_val = mean(value),
      sd_val = sd(value),
      n = n(),
      .groups = 'drop'
    )
  
  # Calculate effect size (eta-squared)
  ss_between <- sum(group_summary$n * (group_summary$mean_val - mean(df$value))^2)
  ss_total <- sum((df$value - mean(df$value))^2)
  eta_squared <- ss_between / ss_total
  
  # Collect results
  results <- list(
    data = df,
    group_summary = group_summary,
    anova_result = anova_result,
    aov_result = aov_result,
    eta_squared = eta_squared,
    p_value = anova_result$`Pr(>F)`[1],
    reject_null = anova_result$`Pr(>F)`[1] < alpha
  )
  
  return(results)
}

#' Create ANOVA visualization
#'
#' @param anova_data Output from generate_anova_data()
#'
#' @return A ggplot object
#'
#' @export
create_anova_plot <- function(anova_data) {
  # Create the plot
  p <- ggplot(anova_data$data, aes(x = group, y = value, color = group)) +
    geom_jitter(width = 0.1, size = 2, alpha = 0.7) +
    geom_point(data = anova_data$group_summary, 
               aes(x = group, y = mean_val), 
               shape = 18, size = 5, color = "black") +
    labs(
      title = "Comparison of Multiple Groups (ANOVA)",
      x = "Group",
      y = "Value",
      color = "Group",
      caption = paste("F =", round(anova_data$anova_result$`F value`[1], 3), 
                      ", P-value =", round(anova_data$p_value, 4),
                      ", Eta-sq =", round(anova_data$eta_squared, 3))
    ) +
    theme_minimal() +
    theme(legend.position = "bottom")
  
  return(p)
}