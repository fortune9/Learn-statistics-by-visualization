# shiny/app.R
# Main Shiny application for Learn Statistics by Visualization

library(shiny)
library(ggplot2)
library(dplyr)
library(LearnStatsVis)

# Define UI
ui <- fluidPage(
  # Application title
  titlePanel("Interactive Statistics Learning Platform - Biology Focus"),
  
  # Sidebar with controls
  sidebarLayout(
    sidebarPanel(
      h3("Select Statistical Concept"),
      selectInput("concept", 
                  "Choose a statistical concept:",
                  choices = c(
                    "P-values and Hypothesis Testing" = "pvalue",
                    "T-tests" = "ttest", 
                    "ANOVA" = "anova",
                    "Confidence Intervals" = "ci",
                    "Statistical Power" = "power",
                    "Chi-square Tests" = "chisq",
                    "Wilcoxon Ranksum Test" = "wilcox",
                    "Regression Analysis" = "regression"
                  )),
      
      conditionalPanel(
        condition = "input.concept == 'pvalue'",
        h4("P-value Parameters"),
        numericInput("pvalue_n", "Sample Size:", value = 30, min = 5, max = 100),
        numericInput("pvalue_mean_true", "True Mean:", value = 0.5, step = 0.1),
        numericInput("pvalue_mean_null", "Null Hypothesis Mean:", value = 0, step = 0.1),
        numericInput("pvalue_sd", "Standard Deviation:", value = 1, min = 0.1, max = 3, step = 0.1),
        selectInput("pvalue_test_type", "Test Type:", 
                    choices = c("Two-sided" = "two.sided", "Less" = "less", "Greater" = "greater")),
        numericInput("pvalue_alpha", "Significance Level (α):", value = 0.05, min = 0.001, max = 0.2, step = 0.001)
      ),
      
      conditionalPanel(
        condition = "input.concept == 'ttest'",
        h4("T-test Parameters"),
        numericInput("ttest_n1", "Sample Size Group 1:", value = 15, min = 3, max = 50),
        numericInput("ttest_n2", "Sample Size Group 2:", value = 15, min = 3, max = 50),
        numericInput("ttest_mean1", "Mean Group 1:", value = 0, step = 0.1),
        numericInput("ttest_mean2", "Mean Group 2:", value = 0.5, step = 0.1),
        numericInput("ttest_sd1", "SD Group 1:", value = 1, min = 0.1, max = 3, step = 0.1),
        numericInput("ttest_sd2", "SD Group 2:", value = 1, min = 0.1, max = 3, step = 0.1)
      ),
      
      conditionalPanel(
        condition = "input.concept == 'anova'",
        h4("ANOVA Parameters"),
        numericInput("anova_n1", "Sample Size Group 1:", value = 10, min = 3, max = 50),
        numericInput("anova_n2", "Sample Size Group 2:", value = 10, min = 3, max = 50),
        numericInput("anova_n3", "Sample Size Group 3:", value = 10, min = 3, max = 50),
        numericInput("anova_mean1", "Mean Group 1:", value = 0, step = 0.1),
        numericInput("anova_mean2", "Mean Group 2:", value = 0.5, step = 0.1),
        numericInput("anova_mean3", "Mean Group 3:", value = 1, step = 0.1),
        numericInput("anova_sd1", "SD Group 1:", value = 1, min = 0.1, max = 3, step = 0.1),
        numericInput("anova_sd2", "SD Group 2:", value = 1, min = 0.1, max = 3, step = 0.1),
        numericInput("anova_sd3", "SD Group 3:", value = 1, min = 0.1, max = 3, step = 0.1)
      ),
      
      conditionalPanel(
        condition = "input.concept == 'ci'",
        h4("Confidence Interval Parameters"),
        numericInput("ci_true_mean", "True Population Mean:", value = 0, step = 0.1),
        numericInput("ci_sd", "Population SD:", value = 1, min = 0.1, max = 3, step = 0.1),
        numericInput("ci_n", "Sample Size:", value = 30, min = 5, max = 100),
        sliderInput("ci_confidence", "Confidence Level:", value = 0.95, min = 0.8, max = 0.99, step = 0.01),
        numericInput("ci_num_samples", "Number of Samples:", value = 20, min = 5, max = 50)
      ),
      
      conditionalPanel(
        condition = "input.concept == 'power'",
        h4("Power Analysis Parameters"),
        numericInput("power_effect_size", "Effect Size (Cohen's d):", value = 0.5, min = 0.1, max = 2, step = 0.01),
        numericInput("power_n", "Sample Size per Group:", value = 30, min = 5, max = 100),
        numericInput("power_alpha", "Significance Level (α):", value = 0.05, min = 0.001, max = 0.2, step = 0.001)
      ),
      
      conditionalPanel(
        condition = "input.concept == 'chisq'",
        h4("Chi-square Test Parameters"),
        numericInput("chisq_obs1", "Observed Freq 1:", value = 10, min = 1, step = 1),
        numericInput("chisq_obs2", "Observed Freq 2:", value = 15, min = 1, step = 1),
        numericInput("chisq_obs3", "Observed Freq 3:", value = 20, min = 1, step = 1),
        numericInput("chisq_obs4", "Observed Freq 4:", value = 25, min = 1, step = 1)
      ),
      
      conditionalPanel(
        condition = "input.concept == 'wilcox'",
        h4("Wilcoxon Test Parameters"),
        numericInput("wilcox_n1", "Sample Size Group 1:", value = 15, min = 3, max = 50),
        numericInput("wilcox_n2", "Sample Size Group 2:", value = 15, min = 3, max = 50),
        numericInput("wilcox_loc1", "Location Group 1:", value = 0, step = 0.1),
        numericInput("wilcox_loc2", "Location Group 2:", value = 0.2, step = 0.1)
      ),
      
      conditionalPanel(
        condition = "input.concept == 'regression'",
        h4("Regression Analysis Parameters"),
        numericInput("reg_n", "Sample Size:", value = 50, min = 10, max = 200),
        numericInput("reg_slope", "True Slope:", value = 0.5, step = 0.1),
        numericInput("reg_intercept", "True Intercept:", value = 2, step = 0.1),
        numericInput("reg_error_sd", "Error SD:", value = 1, min = 0.1, max = 3, step = 0.1)
      ),
      
      br(),
      
      h4("Interpretation"),
      verbatimTextOutput("interpretation")
    ),
    
    # Main panel for outputs
    mainPanel(
      h3(textOutput("plot_title")),
      plotOutput("main_plot", height = "500px"),
      conditionalPanel(
        condition = "input.concept == 'regression'",
        plotOutput("residuals_plot", height = "400px")
      ),
      br(),
      h4("Statistical Summary"),
      verbatimTextOutput("stats_summary"),
      br(),
      h4("Biological Interpretation"),
      htmlOutput("biological_interpretation")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Reactive data based on concept selection
  calc_data <- reactive({
    req(input$concept)
    
    switch(input$concept,
      "pvalue" = {
        generate_pvalue_data(
          n = input$pvalue_n,
          mean_true = input$pvalue_mean_true,
          mean_null = input$pvalue_mean_null,
          sd = input$pvalue_sd,
          test_type = input$pvalue_test_type,
          alpha = input$pvalue_alpha
        )
      },
      "ttest" = {
        generate_ttest_data(
          n1 = input$ttest_n1,
          n2 = input$ttest_n2,
          mean1 = input$ttest_mean1,
          mean2 = input$ttest_mean2,
          sd1 = input$ttest_sd1,
          sd2 = input$ttest_sd2
        )
      },
      "anova" = {
        generate_anova_data(
          n1 = input$anova_n1,
          n2 = input$anova_n2,
          n3 = input$anova_n3,
          mean1 = input$anova_mean1,
          mean2 = input$anova_mean2,
          mean3 = input$anova_mean3,
          sd1 = input$anova_sd1,
          sd2 = input$anova_sd2,
          sd3 = input$anova_sd3
        )
      },
      "ci" = {
        generate_ci_data(
          true_mean = input$ci_true_mean,
          sd = input$ci_sd,
          n = input$ci_n,
          confidence_level = input$ci_confidence,
          num_samples = input$ci_num_samples
        )
      },
      "power" = {
        generate_power_data(
          effect_size = input$power_effect_size,
          n = input$power_n,
          alpha = input$power_alpha
        )
      },
      "chisq" = {
        observed <- c(input$chisq_obs1, input$chisq_obs2, input$chisq_obs3, input$chisq_obs4)
        generate_chisq_data(observed = observed)
      },
      "wilcox" = {
        generate_wilcox_data(
          n1 = input$wilcox_n1,
          n2 = input$wilcox_n2,
          location1 = input$wilcox_loc1,
          location2 = input$wilcox_loc2
        )
      },
      "regression" = {
        generate_regression_data(
          n = input$reg_n,
          slope = input$reg_slope,
          intercept = input$reg_intercept,
          error_sd = input$reg_error_sd
        )
      }
    )
  })
  
  # Generate the appropriate plot based on concept
  output$main_plot <- renderPlot({
    req(calc_data())
    
    switch(input$concept,
      "pvalue" = create_pvalue_plot(calc_data(), input$pvalue_mean_null),
      "ttest" = create_ttest_plot(calc_data()),
      "anova" = create_anova_plot(calc_data()),
      "ci" = create_ci_plot(calc_data()),
      "power" = create_power_plot(calc_data()),
      "chisq" = create_chisq_plot(calc_data()),
      "wilcox" = create_wilcox_plot(calc_data()),
      "regression" = create_regression_plot(calc_data())
    )
  })
  
  # Generate residuals plot for regression
  output$residuals_plot <- renderPlot({
    req(calc_data(), input$concept == "regression")
    create_residuals_plot(calc_data())
  })
  
  # Update plot title based on concept
  output$plot_title <- renderText({
    switch(input$concept,
      "pvalue" = "P-value and Hypothesis Testing Visualization",
      "ttest" = "T-test Visualization",
      "anova" = "ANOVA Visualization",
      "ci" = "Confidence Intervals Visualization",
      "power" = "Statistical Power Analysis",
      "chisq" = "Chi-square Test Visualization",
      "wilcox" = "Wilcoxon Ranksum Test Visualization",
      "regression" = "Regression Analysis Visualization"
    )
  })
  
  # Show statistical summary
  output$stats_summary <- renderText({
    req(calc_data())
    
    data <- calc_data()
    
    switch(input$concept,
      "pvalue" = {
        paste(
          "P-value and Hypothesis Testing Summary:\n",
          "Sample mean:", round(data$sample_mean, 4), "\n",
          "Standard error:", round(data$sample_se, 4), "\n",
          "Test statistic:", round(data$test_result$statistic, 4), "\n",
          "P-value:", round(data$p_value, 4), "\n",
          "Significance level (α):", input$pvalue_alpha, "\n",
          "Decision:", 
          ifelse(data$reject_null, 
                 paste("REJECT H₀ (p <", input$pvalue_alpha, ")"), 
                 paste("FAIL TO REJECT H₀ (p ≥", input$pvalue_alpha, ")"))
        )
      },
      "ttest" = {
        paste(
          "T-test Summary:\n",
          "Group 1 mean:", round(data$group_summary$mean_val[1], 4), 
          ", SD:", round(data$group_summary$sd_val[1], 4), "\n",
          "Group 2 mean:", round(data$group_summary$mean_val[2], 4), 
          ", SD:", round(data$group_summary$sd_val[2], 4), "\n",
          "Mean difference:", round(diff(data$group_summary$mean_val), 4), "\n",
          "T-statistic:", round(data$test_result$statistic, 4), "\n",
          "P-value:", round(data$p_value, 4), "\n",
          "Cohen's d:", round(data$cohens_d, 4), "\n",
          "Decision:", 
          ifelse(data$reject_null, 
                 paste("REJECT H₀ (p <", 0.05, ")"), 
                 paste("FAIL TO REJECT H₀ (p ≥", 0.05, ")"))
        )
      },
      "anova" = {
        paste(
          "ANOVA Summary:\n",
          "F-statistic:", round(data$anova_result$`F value`[1], 4), "\n",
          "P-value:", round(data$p_value, 4), "\n",
          "Eta-squared:", round(data$eta_squared, 4), "\n",
          "Decision:", 
          ifelse(data$reject_null, 
                 paste("REJECT H₀ (p <", 0.05, ")"), 
                 paste("FAIL TO REJECT H₀ (p ≥", 0.05, ")"))
        )
      },
      "ci" = {
        paste(
          "Confidence Interval Summary:\n",
          "True mean:", data$true_mean, "\n",
          "Confidence level:", data$confidence_level*100, "%\n",
          "Sample size (n):", data$sample_size, "\n",
          "Observed coverage rate:", round(data$coverage_rate, 4), "\n",
          "Expected coverage rate:", data$expected_coverage
        )
      },
      "power" = {
        paste(
          "Power Analysis Summary:\n",
          "Effect size (Cohen's d):", round(data$effect_size, 4), "\n",
          "Sample size per group:", data$n, "\n",
          "Significance level (α):", round(data$alpha, 4), "\n",
          "Calculated power:", round(data$actual_power, 4), "\n",
          "Beta (Type II error rate):", round(data$beta, 4)
        )
      },
      "chisq" = {
        paste(
          "Chi-square Test Summary:\n",
          "Chi-square statistic:", round(data$chisq_result$statistic, 4), "\n",
          "P-value:", round(data$p_value, 4), "\n",
          "Degrees of freedom:", data$chisq_result$parameter, "\n",
          "Decision:", 
          ifelse(data$reject_null, 
                 paste("REJECT H₀ (p <", 0.05, ")"), 
                 paste("FAIL TO REJECT H₀ (p ≥", 0.05, ")"))
        )
      },
      "wilcox" = {
        paste(
          "Wilcoxon Ranksum Test Summary:\n",
          "Test statistic (W):", round(data$test_result$statistic, 4), "\n",
          "P-value:", round(data$p_value, 4), "\n",
          "Decision:", 
          ifelse(data$reject_null, 
                 paste("REJECT H₀ (p <", 0.05, ")"), 
                 paste("FAIL TO REJECT H₀ (p ≥", 0.05, ")"))
        )
      },
      "regression" = {
        paste(
          "Regression Analysis Summary:\n",
          "Intercept:", round(data$summary$coefficients[1, 1], 4), 
          " (P-value:", round(data$summary$coefficients[1, 4], 4), ")\n",
          "Slope:", round(data$summary$coefficients[2, 1], 4), 
          " (P-value:", round(data$summary$coefficients[2, 4], 4), ")\n",
          "R-squared:", round(data$r_squared, 4), "\n",
          "F-statistic:", round(data$summary$fstatistic[1], 4), "\n",
          "P-value:", round(data$p_value, 4), "\n",
          "Decision:", 
          ifelse(data$reject_null, 
                 paste("REJECT H₀ (p <", 0.05, ")"), 
                 paste("FAIL TO REJECT H₀ (p ≥", 0.05, ")"))
        )
      }
    )
  })
  
  # Show biological interpretation
  output$biological_interpretation <- renderText({
    req(calc_data())
    
    switch(input$concept,
      "pvalue" = {
        data <- calc_data()
        paste(
          "<p><strong>Biological Interpretation:</strong> ",
          ifelse(data$reject_null,
                 paste("The observed difference (e.g., in gene expression) is statistically significant (p =", 
                       round(data$p_value, 4), "). This provides evidence that there is indeed a biological difference."),
                 paste("The observed difference is not statistically significant (p =", 
                       round(data$p_value, 4), "). We do not have sufficient evidence to conclude there is a biological difference.")),
          "</p>"
        )
      },
      "ttest" = {
        data <- calc_data()
        paste(
          "<p><strong>Biological Interpretation:</strong> ",
          ifelse(data$reject_null,
                 paste("The difference in means between the two groups (e.g., control vs treatment) is statistically significant (p =", 
                       round(data$p_value, 4), "). This suggests the treatment has a biological effect."),
                 paste("The difference in means is not statistically significant (p =", 
                       round(data$p_value, 4), "). We do not have sufficient evidence to conclude the treatment has an effect.")),
          " Effect size (Cohen's d = ", round(data$cohens_d, 3), ") indicates the magnitude of the biological difference.</p>"
        )
      },
      "anova" = {
        data <- calc_data()
        paste(
          "<p><strong>Biological Interpretation:</strong> ",
          ifelse(data$reject_null,
                 paste("There is a statistically significant difference among the groups (p =", 
                       round(data$p_value, 4), "). This suggests that at least one treatment condition has a different biological effect."),
                 paste("There is no statistically significant difference among the groups (p =", 
                       round(data$p_value, 4), "). We do not have sufficient evidence to conclude the treatments have different effects.")),
          " Effect size (Eta-squared = ", round(data$eta_squared, 3), ") indicates the proportion of variance explained by the treatment conditions.</p>"
        )
      },
      "ci" = {
        paste(
          "<p><strong>Biological Interpretation:</strong> The confidence interval provides a range of plausible values for the unknown population parameter (e.g., true mean gene expression level). ",
          "With ", calc_data()$confidence_level*100, "% confidence, the interval contains the true value. ",
          "This helps quantify the precision of our estimate in biological terms.</p>"
        )
      },
      "power" = {
        data <- calc_data()
        paste(
          "<p><strong>Biological Interpretation:</strong> Power (", round(data$actual_power, 3), ") is the probability of detecting a true biological effect of the specified size. ",
          "With this sample size and effect size, we have ", round(data$actual_power*100, 1), "% power to detect the difference. ",
          "Consider increasing sample size if power is too low (&lt;0.8).</p>"
        )
      },
      "chisq" = {
        data <- calc_data()
        paste(
          "<p><strong>Biological Interpretation:</strong> ",
          ifelse(data$reject_null,
                 paste("The observed frequencies differ significantly from expected (p =", 
                       round(data$p_value, 4), "). This suggests the biological categories are not distributed as expected."),
                 paste("The observed frequencies are not significantly different from expected (p =", 
                       round(data$p_value, 4), "). The biological categories appear to follow the expected distribution.")),
          "</p>"
        )
      },
      "wilcox" = {
        data <- calc_data()
        paste(
          "<p><strong>Biological Interpretation:</strong> The Wilcoxon ranksum test is a non-parametric alternative to the t-test. ",
          ifelse(data$reject_null,
                 paste("There is a significant difference between the groups (p =", 
                       round(data$p_value, 4), "). The distributions differ in location."),
                 paste("There is no significant difference between the groups (p =", 
                       round(data$p_value, 4), "). The distributions do not differ significantly in location.")),
          "</p>"
        )
      },
      "regression" = {
        data <- calc_data()
        paste(
          "<p><strong>Biological Interpretation:</strong> The regression analysis examines the relationship between two biological variables. ",
          ifelse(data$reject_null,
                 paste("The relationship is statistically significant (p =", 
                       round(data$p_value, 4), "). The predictor variable has a significant effect on the response variable, explaining ", 
                       round(data$r_squared*100, 1), "% of the variance."),
                 paste("The relationship is not statistically significant (p =", 
                       round(data$p_value, 4), "). The predictor variable does not significantly explain the response variable.")),
          "</p>"
        )
      }
    )
  })
  
  # Show interpretation
  output$interpretation <- renderText({
    req(calc_data())
    
    switch(input$concept,
      "pvalue" = paste("Testing if sample mean differs from null hypothesis value (e.g., no treatment effect)"),
      "ttest" = paste("Comparing means of two groups (e.g., treatment vs control)"),
      "anova" = paste("Comparing means of multiple groups (e.g., different treatment conditions)"),
      "ci" = paste("Estimating population parameter with uncertainty bounds"),
      "power" = paste("Determining probability of detecting true effect"),
      "chisq" = paste("Testing if observed frequencies match expected distribution"),
      "wilcox" = paste("Non-parametric test comparing two groups"),
      "regression" = paste("Examining relationship between predictor and response variables")
    )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)