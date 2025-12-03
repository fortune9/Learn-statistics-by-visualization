#' Generate sample data for power analysis visualization
#'
#' @param effect_size Effect size (Cohen's d)
#' @param n Sample size per group
#' @param alpha Significance level
#' @param power Statistical power
#'
#' @return A list containing power analysis data
#'
#' @export
generate_power_data <- function(effect_size = 0.5, n = 30, alpha = 0.05, power = 0.8) {
  # Calculate power using R's built-in power calculation
  power_result <- power.t.test(n = n, delta = effect_size, 
                               sig.level = alpha, type = "two.sample", power = power)
  
  # Calculate critical t-value for rejection region
  df <- 2 * n - 2  # degrees of freedom for two-sample t-test
  t_critical <- qt(1 - alpha/2, df)
  
  # Calculate non-centrality parameter
  ncp <- effect_size * sqrt(n/2)
  
  # Calculate actual power (area under alternative hypothesis curve in rejection region)
  actual_power <- (1 - pt(t_critical, df, ncp = ncp)) + pt(-t_critical, df, ncp = ncp)
  
  # Calculate beta (Type II error rate)
  beta <- 1 - actual_power
  
  results <- list(
    power = power_result$power,
    actual_power = actual_power,
    beta = beta,
    t_critical = t_critical,
    df = df,
    ncp = ncp,
    effect_size = effect_size,
    n = n,
    alpha = alpha
  )
  
  return(results)
}

#' Create power analysis visualization
#'
#' @param power_data Output from generate_power_data()
#'
#' @return A ggplot object
#'
#' @export
create_power_plot <- function(power_data) {
  # Create sequences for plotting
  x_min <- min(-4, -power_data$t_critical - 2)
  x_max <- max(4, power_data$t_critical + 2)
  x <- seq(x_min, x_max, length.out = 500)
  
  # Null hypothesis distribution (t-distribution with df degrees of freedom, centered at 0)
  y_null <- dt(x, df = power_data$df)
  
  # Alternative hypothesis distribution (non-central t-distribution)
  y_alt <- dt(x, df = power_data$df, ncp = power_data$ncp)
  
  # Find critical regions for null hypothesis
  x_critical_lower <- seq(x_min, -power_data$t_critical, length.out = 100)
  x_critical_upper <- seq(power_data$t_critical, x_max, length.out = 100)
  
  y_critical_lower <- dt(x_critical_lower, df = power_data$df)
  y_critical_upper <- dt(x_critical_upper, df = power_data$df)
  
  # Find power region for alternative hypothesis (area beyond critical values)
  x_power_lower <- seq(x_min, -power_data$t_critical, length.out = 100)
  x_power_upper <- seq(power_data$t_critical, x_max, length.out = 100)
  
  y_power_lower <- dt(x_power_lower, df = power_data$df, ncp = power_data$ncp)
  y_power_upper <- dt(x_power_upper, df = power_data$df, ncp = power_data$ncp)
  
  # Create data frames for plotting
  df_null <- data.frame(x = x, y = y_null, hypothesis = "H₀ (No difference)")
  df_alt <- data.frame(x = x, y = y_alt, hypothesis = "H₁ (True difference)")
  
  # Critical region (Type I error) under null hypothesis
  df_critical <- data.frame(
    x = c(x_critical_lower[1], x_critical_lower, rev(x_critical_lower)[1], 
          x_critical_upper[1], x_critical_upper, rev(x_critical_upper)[1]),
    y = c(0, y_critical_lower, 0,
          0, y_critical_upper, 0),
    region = "α (Type I error)"
  )
  
  # Power region under alternative hypothesis
  df_power <- data.frame(
    x = c(x_power_lower[1], x_power_lower, rev(x_power_lower)[1], 
          x_power_upper[1], x_power_upper, rev(x_power_upper)[1]),
    y = c(0, y_power_lower, 0,
          0, y_power_upper, 0),
    region = "Power (1-β)"
  )
  
  # Create the plot
  p <- ggplot() +
    # Add alternative hypothesis curve (shifted)
    geom_line(data = df_alt, aes(x = x, y = y, color = hypothesis), size = 1.2) +
    # Add null hypothesis curve (centered at 0)
    geom_line(data = df_null, aes(x = x, y = y, color = hypothesis), size = 1.2) +
    # Add critical region (shaded red for Type I error under H₀)
    geom_polygon(data = df_critical, aes(x = x, y = y), fill = "red", alpha = 0.3) +
    # Add power region (shaded blue for power under H₁)
    geom_polygon(data = df_power, aes(x = x, y = y), fill = "blue", alpha = 0.3) +
    # Add vertical lines for critical values
    geom_vline(xintercept = c(-power_data$t_critical, power_data$t_critical), 
               color = "black", linetype = "dashed", size = 0.8) +
    # Add vertical line at zero for reference
    geom_vline(xintercept = 0, color = "gray", size = 0.5) +
    labs(
      title = paste("Statistical Power Visualization (α =", power_data$alpha, ", Effect Size =", power_data$effect_size, ")"),
      x = "Test Statistic (t-value)",
      y = "Density",
      color = "Hypothesis",
      caption = paste("Power =", round(power_data$actual_power, 3), 
                      ", n per group =", power_data$n)
    ) +
    scale_color_manual(values = c("H₀ (No difference)" = "black", 
                                  "H₁ (True difference)" = "blue")) +
    theme_minimal() +
    theme(legend.position = "bottom")
  
  return(p)
}