# ==============================================================================
# EXPLORATORY ANALYSIS
# ==============================================================================

source("code/01_data_import_clean.R")

cat("\n\n=== EXPLORATORY ANALYSIS ===\n\n")

# --- SUMMARY STATS BY DESTINATION ---
cat("Total Migration Stock by Destination (2024):\n")
print(
  tidy_data %>%
    filter(Annee == 2024) %>%
    group_by(Dest_Region) %>%
    summarise(Total = sum(Stock, na.rm = TRUE), .groups = "drop") %>%
    arrange(desc(Total))
)

# --- TOP ORIGIN COUNTRIES ---
cat("\n\nTop 10 Origin Countries for GCC Migration (2024):\n")
print(
  tidy_data %>%
    filter(Annee == 2024) %>%
    group_by(Origin_Region) %>%
    summarise(Total = sum(Stock, na.rm = TRUE), .groups = "drop") %>%
    arrange(desc(Total)) %>%
    head(10)
)

cat("\n✓ Exploratory analysis complete.\n")
