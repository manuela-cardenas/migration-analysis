# ==============================================================================
# PROJET : ANALYSE MIGRATION 
# ==============================================================================

library(tidyverse)
library(readxl)
library(janitor)

# --- CRÉER LES DOSSIERS ---
if (!dir.exists("data/raw")) dir.create("data/raw", recursive = TRUE)
if (!dir.exists("data/processed")) dir.create("data/processed", recursive = TRUE)
if (!dir.exists("outputs/figures")) dir.create("outputs/figures", recursive = TRUE)
if (!dir.exists("outputs/tables")) dir.create("outputs/tables", recursive = TRUE)

cat("✓ Setup complete. Ready to load data.\n")
