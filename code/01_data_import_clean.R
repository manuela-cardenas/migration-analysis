# ==============================================================================
# PROJET : ANALYSE MIGRATION 
# ==============================================================================

source("code/00_setup.R")

# --- DÉFI  DE LA STRUCTURE (pcq le fichier deraw data est fou) --------
# années 
annees <- c(1990, 1995, 2000, 2005, 2010, 2015, 2020, 2024)

# colonnes 
meta_cols <- c("SortOrder", "Dest_Region", "Notes", "Dest_Code", "Type", "Origin_Region", "Origin_Code")

# nombs colonnes a main pour eviter la folie du doc excel lol 
noms_colonnes <- c(
  meta_cols,
  paste0("Both_", annees),   # Crée Both_1990...
  paste0("Male_", annees),   # Crée Male_1990...
  paste0("Female_", annees)  # Crée Female_1990...
)

# --- IMPORTATION DES DONNÉES -----------------------------------------------
# faut sauter les 11 premieres lignes de 'metadonnees' (en gros les donnees internes du fichier xls)
# verifier si c'est bien 1 a 11, c est bon pour le coup
raw_data <- read_excel("data/raw/migration_data.xlsx", sheet = 1, skip = 11, col_names = noms_colonnes)

# --- TIDY DATA -------------------------------------------------
# on passe des colonnes qui est chiannttt a un format en lignes
tidy_data <- raw_data %>%
  filter(!is.na(Dest_Region)) %>% # chao lignes vides
  
  pivot_longer(
    cols = starts_with(c("Both_", "Male_", "Female_")),
    names_to = c("Sexe", "Annee"),
    names_sep = "_",
    values_to = "Stock"
  ) %>%
  
  # en gros cols c'est colonnes
  # names to c est les hautes
  # values to puisque ca sera notre Y
  
  # on passe de texte a nombres !! 
  mutate(
    Annee = as.numeric(Annee),
    Stock = as.numeric(Stock)
  ) %>%
  
  # --- CORRECTION 1 : TRADUCTION DES PAYS DE DESTINATION ICI ---
  # On traduit tout de suite pour que les facettes soient en français
  mutate(Dest_Region = case_when(
    Dest_Region == "Saudi Arabia" ~ "Arabie Saoudite",
    Dest_Region == "United Arab Emirates" ~ "Émirats Arabes Unis",
    Dest_Region == "Qatar" ~ "Qatar",
    TRUE ~ Dest_Region # Garde les autres (comme World) tels quels
  ))

# --- SAVE TIDY DATA ---
write_csv(tidy_data, "data/processed/tidy_migration_flows.csv")
cat("✓ Migration data cleaned and saved.\n")

# ==============================================================================
# ILOSTAT DATA
# ==============================================================================

uae_ilostat <- read_csv("data/raw/ARE_A-filtered-2025-12-12.csv") |>
  clean_names()

uae_sectors <- uae_ilostat |>
  filter(str_detect(indicator_label,
                    "Employment by sex, occupation and economic activity")) |>
  filter(!is.na(obs_value)) |>
  filter(is.na(obs_status_label) | obs_status_label != "Unreliable") %>%
  mutate(
    isic2 = str_extract(classif2_label, "^[0-9]{2}") |> as.numeric(),
    big_sector = case_when(
      isic2 %in% 1:3   ~ "Agriculture & fishing",
      isic2 %in% 5:33  ~ "Industry",
      isic2 %in% 35:39 ~ "Utilities",
      isic2 %in% 41:43 ~ "Construction",
      TRUE             ~ "Services"
    )
  ) |>
  group_by(time, sex_label, big_sector) |>
  summarise(emp = sum(obs_value, na.rm = TRUE), .groups = "drop") |>
  group_by(time) |>
  mutate(share = emp / sum(emp))

write_csv(uae_sectors, "data/processed/uae_sector_employment.csv")
cat("✓ ILOSTAT data cleaned and saved.\n")
