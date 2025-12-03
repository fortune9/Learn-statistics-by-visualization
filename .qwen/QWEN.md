# Learn statistics by visualization

This project aims to teach statistics concepts through visualizations.
Each concept is explained with accompanying charts and graphs to
enhance understanding. For example, for people to understand the P
value, we may show a distribution curve highlighting the area that
represents the P value given a certain test statistic, and for
multiple testing, we may let users to specify the number of tests
and significance level, and then visualize the family-wise error rate
as the number of tests increases as well as the distribution of all
P values from all tests.

Visualization is important for people to learn statistics when they
are not interested in mathematical derivations.

## Features

- Interactive visualizations for key statistics concepts
- User-friendly interface for exploring different scenarios
- Explanations and examples accompanying each visualization
- Ability to customize parameters and see real-time updates in
  visualizations
- Export visualizations for presentations or reports

## Technologies Used

- Use R for statistical computations and visualizations
- ggplot2 for creating high-quality charts and graphs
- dplyr for data manipulation
- create all kind of functions to create sample data, perform statistical
  tests, and generate visualizations
- Make this repo as an R package for easy installation and usage
- Create a separate Shiny app to call the functions from this package for building interactive web applications
    + users can choose which statistics concept to explore
    + users can customize parameters for each concept
    + users can see real-time updates in visualizations based on
      their inputs
    + HTML/CSS for front-end design
    + JavaScript for enhancing interactivity
    + put this app under the `shiny/` folder
- use github actions to automate testing and deployment
  + make a pkgdown website and deploy it to github pages
  + deploy the shiny app to shinyapps.io

## Statistics Concepts Covered

- ANOVA
    + show how sample size, effect size, and variance affect the ANOVA
        results
    + explain the assumptions of ANOVA and show how violations affect
      results
- Chi-square tests
    + show the distribution of the test statistic under the null
      hypothesis
    + explain when to use chi-square tests
- t-tests
  + show how sample size, effect size, and variance affect the t-test
    results
  + compare t-test and paired t-test
- Wilcoxon Ranksum test
  + Compare to t-test
  + Explain when to use
- Confidence intervals
    + show how sample size and variance affect the width of confidence
        intervals
    + explain the interpretation of confidence intervals
- Regression analysis
    + visualize the regression line and residuals
    + explain assumptions of regression analysis
    + show how outliers affect regression results
- Effect size
    + explain different measures of effect size (Cohen's d, Pearson's r,
      etc.)
    + visualize the relationship between effect size and statistical
      Power
- Power analysis
    + show how sample size, effect size, significance level, and power
      are related
    + provide tools for calculating required sample size for desired
      power under different tests
- Normal distribution
    + visualize properties of the normal distribution
    + explain the empirical rule (68-95-99.7 rule)
- P values and hypothesis testing
    + visualize the concept of null and alternative hypotheses
    + show how P values are calculated and interpreted
    + demonstrate Type I and Type II errors
- Multiple testing and family-wise error rate
    + visualize the increase in family-wise error rate with more tests
    + explain correction methods (Bonferroni, Holm, FDR)
- Central limit theorem
    + visualize the sampling distribution of the sample mean
    + explain the implications of the central limit theorem
- Bayesian statistics
    + visualize prior, likelihood, and posterior distributions
    + explain Bayes' theorem with examples
- Probability distributions
    + visualize common distributions (binomial, Poisson, exponential,
      etc.)
    + explain properties and applications of each distribution
- Sampling methods
    + visualize different sampling techniques (random, stratified,
      cluster, etc.)
    + explain advantages and disadvantages of each method
- Correlation vs causation
    + explain the difference between correlation and causation
    + visualize examples illustrating the difference
- Sampling bias
    + explain different types of sampling bias
    + visualize the impact of sampling bias on results

## Maintainance

- Update the following files when changes are made:
    - README.md
    - CHANGELOG.md
    - other package files as needed

- Manifest for the package:
    - developer name: Zhenguo Zhang
    - github username: fortune9
    - email: zhangz.sci@gmail.com
