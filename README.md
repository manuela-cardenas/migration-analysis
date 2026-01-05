📄 PART 3: README.md

text
# Migration Analysis: Gender, Labor Substitution, and the "Care Drain"

**Author:** Manuela Cárdenas Martínez  
**Institution:** Panthéon-Sorbonne (M1 Development Economics)  
**Date:** January 2026  
**Language:** Code in French + Documentation in English

## Project Overview

This analysis examines migration flows to the Gulf Cooperation Council (GCC) states—Saudi Arabia, Qatar, and the United Arab Emirates—with a focus on **gender composition and labor market dynamics** from 1990–2024.

### Research Question

How have female migrant labor pools shifted across destination countries and origin regions? What does this reveal about labor market substitution and the "Care Drain" phenomenon?

### Key Finding

Indonesian domestic workers (traditionally dominant) have been increasingly replaced by Ethiopian workers, suggesting policy shifts, labor cost differentials, or supply-side constraints in Indonesia.

## Data Sources

- **UN DESA Global Migration Database:** Migration stock by destination, origin, and sex (1990–2024)
- **ILOSTAT:** Employment by sector, sex, and economic activity (UAE, 2004–2020)

## Repository Structure

├── code/ # 4 R scripts (modular pipeline) ├── data/ │ ├── raw/ # Raw data files (not committed to Git) │ └── processed/ # Cleaned data (auto-generated) ├── outputs/ │ ├── figures/ # 7 PNG visualizations │ └── tables/ # Summary tables (CSV) └── README.md # This file

text
## Quick Start

1. **Install packages:**
   ```r
   source("code/00_setup.R")
	2	Download data from UN DESA and ILOSTAT into data/raw/
	3	Run the pipeline:   r source("code/01_data_import_clean.R")
	4	source("code/02_exploratory_analysis.R")
	5	source("code/03_visualizations.R")
	6	    
	7	Outputs will appear in outputs/figures/ and outputs/tables/
Key Visualizations
	1	Stacked Area Charts (3) — Migration trends by origin country (Saudi Arabia, Qatar, UAE)
	2	Gender Composition — Female share of migrants over time
	3	Sector Growth Index — Employment growth by sector (Qatar, 2004–2020)
	4	Care Drain Hypothesis — Ethiopian vs Indonesian substitution patterns
	5	UAE Sector Employment — Distribution by gender and sector
Technical Stack
	•	Language: R (4.0+)
	•	Key Packages: tidyverse, ggplot2, dplyr, readxl, janitor
	•	Data Format: Excel (.xlsx) and CSV
Author's Notes
This analysis bridges quantitative rigor with institutional understanding. The "Care Drain" reveals how labor market substitution operates at the intersection of policy, economics, and gender.
The code is written in French to reflect the student's academic context (Sorbonne) while documentation is in English for international accessibility.
License
Educational use. Data sources retain their original licenses.