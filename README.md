
# Migration Analysis: Gender, Labor Substitution, and the "Care Drain"

**Author:** Manuela Cárdenas Martínez  
**Institution:** Panthéon-Sorbonne (M1 Development Economics)  
**Date:** January 2026  
**Language:** Code in French + Documentation in English

## Project Overview

This analysis examines migration flows to the Gulf Cooperation Council (GCC) states—Saudi Arabia, Qatar, and the United Arab Emirates—with a focus on **gender composition and labor market dynamics** from 1990–2024.

### Research Question

How have female migrant labor pools shifted across destination countries and origin regions? What does this reveal about labor market substitution and the "Care Drain" phenomenon?

### Key Findings

- Indonesian domestic workers (traditionally dominant) have been increasingly replaced by Ethiopian workers, suggesting policy shifts, labor cost differentials, or supply-side constraints in Indonesia.
- Female migration to Qatar and UAE has grown substantially, particularly concentrated in domestic work and care sectors, which remain severely undercounted in official statistics.
- Arab Gulf states show significant gender disparities in labor migration patterns, with women representing a far larger share than regional averages suggest.
- Domestic work remains severely undercounted in official migration statistics, 
  masking a largely female workforce

## Data Sources

- **UN DESA Global Migration Database:** Migration stock by destination, origin, and sex (1990–2024)
- **ILOSTAT:** Employment by sector, sex, and economic activity (UAE, 2004–2020)

## Repository Structure

├── code/ # 4 R scripts (modular pipeline) ├── data/ │ ├── raw/ # Raw data files (not committed to Git) │ └── processed/ # Cleaned data (auto-generated) ├── outputs/ │ ├── figures/ # 7 PNG visualizations │ └── tables/ # Summary tables (CSV) └── README.md # This file

## Quick Start

1. **Install packages and run the pipeline**

   ```r
   source("code/00_setup.R")          # install/load packages
   # Download data from UN DESA and ILOSTAT into data/raw/
   source("code/01_data_import_clean.R")
   source("code/02_exploratory_analysis.R")
   source("code/03_visualizations.R")

Outputs will appear in outputs/figures/ and outputs/tables/.

## Key Visualizations

Stacked area charts — migration trends by origin country (Saudi Arabia, Qatar, UAE)

Gender composition — female share of migrants over time

Sector growth index — employment growth by sector (Qatar, 2004–2020)

“Care drain” — Ethiopian vs Indonesian substitution patterns

UAE sector employment — distribution by gender and sector

## Technical Stack

Language: R (4.0+)

## Key packages: 

tidyverse, ggplot2, dplyr, readxl, janitor

## Data format: 

Excel (.xlsx) and CSV

## Author's Notes

This analysis aims to bridge quantitative rigor with institutional understanding. The “care drain” visualizations explore how labor market substitution operates at the intersection of policy, economics, and gender. The code is written in French due to the academic context, while documentation is in English for accessibility.

## License

Educational use. Data sources retain their original licenses.
