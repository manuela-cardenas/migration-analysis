
---

## PART 5: data/raw/README_data.md

```markdown
# Data Sources

This folder should contain raw data files downloaded locally (not committed to GitHub).

## Files to Download

### 1. UN DESA Global Migration Database
- **URL:** https://www.un.org/development/desa/pd/content/international-migrant-stock
- **What to download:** Migration stock (total population) by destination, origin, sex (1990–2024)
- **Format:** Excel (.xlsx)
- **Save as:** `migration_data.xlsx`

### 2. ILOSTAT Employment Data (UAE)
- **URL:** https://ilostat.ilo.org/
- **Query:**
  - Country: United Arab Emirates
  - Indicator: Employment by sex, occupation, and economic activity (ISIC Rev. 4)
  - Years: 2004–2020
- **Format:** CSV
- **Save as:** `ARE_A-filtered-2025-12-12.csv`

## Instructions

1. Download both files from the sources above
2. Place them in this `data/raw/` folder
3. The R scripts will automatically load and process them

## Citation

UN Department of Economic and Social Affairs (2024). "International Migrant Stock."  
International Labour Organization (2024). "ILOSTAT Database."
