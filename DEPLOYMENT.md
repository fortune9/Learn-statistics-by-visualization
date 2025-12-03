# GitHub Actions Deployment Setup

This document explains how to set up GitHub Actions workflows to deploy
the LearnStatsVis package documentation to GitHub Pages and the Shiny
app to shinyapps.io.

## Prerequisites

### For GitHub Pages Deployment

- Your GitHub repository must have GitHub Pages enabled
- The `pkgdown` workflow will automatically generate and deploy
  documentation

### For shinyapps.io Deployment

- Account on [shinyapps.io](https://www.shinyapps.io/)
- Application created in your shinyapps.io dashboard
- API token and secret from shinyapps.io

## Required GitHub Secrets

Go to your GitHub repository settings \> Secrets and variables \>
Actions to add these secrets:

### For shinyapps.io Deployment

- `SHINYAPPS_ACCOUNT_NAME`: Your shinyapps.io account name
- `SHINYAPPS_TOKEN`: Your shinyapps.io API token
- `SHINYAPPS_SECRET`: Your shinyapps.io API secret
- `SHINYAPPS_APP_NAME`: Name of your application in shinyapps.io

## GitHub Actions Workflows

### 1. pkgdown.yaml

Deploys package documentation to GitHub Pages automatically on every
push to main branch.

**Triggers:** - Push to main branch - Pull requests to main branch

**What it does:** - Sets up R environment - Installs required packages -
Generates documentation using pkgdown - Deploys to GitHub Pages

### 2. shinyapps.yaml

Deploys the Shiny app to shinyapps.io automatically on every push to
main branch and on releases.

**Triggers:** - Push to main branch - Release published

**What it does:** - Sets up R environment - Installs required packages
including rsconnect - Configures rsconnect with shinyapps.io
credentials - Creates a sample Shiny app that demonstrates package
functionality - Deploys to shinyapps.io

## Setup Instructions

### 1. Enable GitHub Pages

1.  Go to your GitHub repository
2.  Navigate to Settings \> Pages
3.  Under “Source”, select “GitHub Actions”
4.  Save the settings

### 2. Configure shinyapps.io

1.  Create an account at [shinyapps.io](https://www.shinyapps.io/)
2.  Log into the dashboard and create a new application
3.  Go to Account \> Tokens to generate an API token and secret
4.  Add the required secrets to your GitHub repository as described
    above

### 3. Verify Workflows

1.  Both workflows are located in `.github/workflows/`
2.  The workflows will automatically run when you push to the main
    branch
3.  Check the Actions tab in your repository to monitor workflow
    execution

## Package Structure for Deployment

The GitHub Actions workflows expect the following structure:

    LearnStatsVis/
    ├── .github/
    │   └── workflows/
    │       ├── pkgdown.yaml      # For documentation deployment
    │       └── shinyapps.yaml    # For Shiny app deployment
    ├── R/                       # R source files
    ├── man/                     # Documentation
    ├── DESCRIPTION             # Package metadata
    ├── NAMESPACE              # Exported functions
    ├── pkgdown/               # pkgdown configuration
    └── _pkgdown.yml           # pkgdown configuration file

## Creating pkgdown Configuration

To make the documentation look better, create a `_pkgdown.yml` file:

``` yml
title: LearnStatsVis
url: https://your-username.github.io/LearnStatsVis

template:
  bootstrap: 5
  bootswatch: flatly

home:
  title: Learn Statistics by Visualization
  description: Interactive visualizations for learning statistics concepts with biological examples

navbar:
  title: "LearnStatsVis"
  left:
    - text: "Home"
      href: index.html
    - text: "Functions"
      href: reference/index.html
    - text: "Articles"
      href: articles/index.html
    - text: "News"
      href: news/index.html
  right:
    - icon: fa-github
      href: https://github.com/your-username/LearnStatsVis
```

## Testing Locally

Before deployment, you can test the workflows locally using the `act`
tool:

1.  Install `act`: `brew install act` (for macOS) or check GitHub for
    other OS options
2.  Run: `act -j documentation` to test the pkgdown workflow
3.  Run: `act -j deploy` to test the shinyapps workflow

## Troubleshooting

### Common Issues

1.  **Documentation not deploying**: Make sure GitHub Pages is enabled
    in repository settings
2.  **Deployment to shinyapps.io failing**: Verify that all secrets are
    correctly set
3.  **Package dependencies not installing**: Check that all required
    packages are listed in DESCRIPTION file

### Checking Logs

Check the logs in the Actions tab of your GitHub repository to
troubleshoot any issues with the workflows.

## Security Notes

- Never commit API tokens or secrets directly to the codebase
- Use GitHub Secrets for all sensitive information
- Review access permissions for your repository carefully

## Updating Deployments

- Push changes to the main branch to trigger new deployments
- Documentation will update automatically after each push
- The Shiny app will redeploy after each push to main or when a new
  release is published
