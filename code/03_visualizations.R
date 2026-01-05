# ==============================================================================
# VISUALIZATIONS - 7 PUBLICATION-QUALITY FIGURES
# ==============================================================================

source("code/01_data_import_clean.R")

cat("\n\n=== GENERATING VISUALIZATIONS ===\n\n")

# --- 5. FONCTION GRAPHIQUE (Traduction Automatique & Style Empilé) ----------

creer_graphique_empile <- function(nom_pays_francais, titre_pays_francais) {
  
  # A. Filtrage et TRADUCTION
  data_pays <- tidy_data %>%
    filter(Dest_Region == nom_pays_francais) %>%
    filter(Origin_Region %in% c("Yemen", "Philippines", "Indonesia", "Somalia", 
                                "Egypt", "Bangladesh", "India", "Pakistan")) %>%
    filter(Sexe != "Both") %>%
    
    # On traduit les noms d'origine
    mutate(Origin_Region = case_when(
      Origin_Region == "Egypt" ~ "Égypte",
      Origin_Region == "Yemen" ~ "Yémen",
      Origin_Region == "India" ~ "Inde",
      Origin_Region == "Philippines" ~ "Philippines",
      Origin_Region == "Indonesia" ~ "Indonésie",
      Origin_Region == "Somalia" ~ "Somalie",
      Origin_Region == "Pakistan" ~ "Pakistan",
      Origin_Region == "Bangladesh" ~ "Bangladesh",
      TRUE ~ Origin_Region 
    ))
  
  # B. Création du graphique
  ggplot(data_pays, aes(x = Annee, y = Stock, fill = Sexe)) +
    
    # Style Empilé (Stacked)
    geom_area(position = "stack", alpha = 0.9, color = "white", linewidth = 0.1) + 
    
    # Faceting 
    facet_wrap(~Origin_Region, scales = "free_y", ncol = 4) +
    
    # Couleurs (Menthe & Lavande)
    scale_fill_manual(
      values = c("Female" = "#9B59B6", "Male" = "#2ECC71"),
      labels = c("Femmes (en haut)", "Hommes (en bas)")
    ) +
    
    # Axes
    scale_y_continuous(labels = scales::comma) +
    scale_x_continuous(breaks = c(1990, 2005, 2024)) +
    
    # Textes
    labs(
      title = titre_pays_francais,
      subtitle = "Évolution cumulée de la population migrante",
      y = "Population Totale",
      x = "",
      fill = "",
      caption = "Source : ONU DESA, Global Migration Database (2024). Téléchargé le 12/12/2025."
    ) +
    
    # Thème Poster
    theme_minimal(base_size = 14) +
    theme(
      legend.position = "top",
      legend.text = element_text(size = 12, face = "bold"),
      strip.text = element_text(face = "bold", size = 12, color = "grey20"), 
      plot.title = element_text(face = "bold", size = 18, color = "black"),
      plot.subtitle = element_text(size = 12, color = "grey40"),
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_line(color = "grey90", linetype = "dashed"),
      plot.caption = element_text(size = 10, color = "grey60", margin = margin(t = 15))
    )
}

# --- 6. GÉNÉRATION & SAUVEGARDE -----------------------------------------------

# On lance tout (Avec les nouveaux noms français !)
p1 <- creer_graphique_empile("Arabie Saoudite", "ARABIE SAOUDITE")
p2 <- creer_graphique_empile("Qatar", "QATAR")
p3 <- creer_graphique_empile("Émirats Arabes Unis", "ÉMIRATS ARABES UNIS")

ggsave("outputs/figures/01_Stacked_Area_Saudi.png", plot = p1, width = 12, height = 7, dpi = 300)
ggsave("outputs/figures/02_Stacked_Area_Qatar.png", plot = p2, width = 12, height = 7, dpi = 300)
ggsave("outputs/figures/03_Stacked_Area_UAE.png", plot = p3, width = 12, height = 7, dpi = 300)

cat("✓ Saved 3 stacked area charts\n\n")

# --- GRAPHIQUE BARRES (Méthode "World") ----------------

# A. PRÉPARATION
data_world_totals <- tidy_data %>%
  filter(Origin_Region == "World") %>%
  filter(Dest_Region %in% c("Arabie Saoudite", "Qatar", "Émirats Arabes Unis")) %>%
  filter(Sexe %in% c("Male", "Female")) %>%
  group_by(Dest_Region, Annee) %>%
  mutate(Total_Annee = sum(Stock)) %>%
  ungroup() %>%
  mutate(Pourcentage = Stock / Total_Annee) %>%
  mutate(Label = scales::percent(Pourcentage, accuracy = 0.1))

# B. GRAPHIQUE
p_world <- ggplot(data_world_totals, aes(x = as.factor(Annee), y = Stock, fill = Sexe)) +
  
  geom_col(position = "stack", width = 0.7) +
  
  geom_text(aes(label = Label), 
            position = position_stack(vjust = 0.5), 
            color = "white", size = 3, fontface = "bold") +
  
  facet_wrap(~Dest_Region, scales = "free_y", ncol = 3) +
  
  scale_fill_manual(
    values = c("Female" = "#9B59B6", "Male" = "#2ECC71"),
    labels = c("Femmes", "Hommes")
  ) +
  
  scale_y_continuous(labels = scales::comma) +
  
  labs(
    title = "Répartition par genre (Données Totales)",
    subtitle = "Basé sur l'ensemble de la population migrante (Origine : Monde)",
    y = "Population Totale",
    x = "",
    fill = "",
    caption = "Source : ONU DESA, Global Migration Database (2024)."
  ) +
  
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "top",
    strip.text = element_text(face = "bold", size = 12),
    plot.title = element_text(face = "bold", size = 16),
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.major.x = element_blank()
  )

ggsave("outputs/figures/04_Gender_Composition.png", plot = p_world, width = 14, height = 8, dpi = 300)
cat("✓ Saved gender composition bar chart\n\n")

# --- GRAPHIQUE INDICE BASE 100 ------------------------------------------

data_secteurs <- tribble(
  ~Annee, ~Secteur, ~Indice,
  2004, "Construction", 100,
  2004, "Commerce de gros et de détail", 100,
  2004, "Services domestiques", 100,
  2004, "Industrie manufacturière", 100,
  2010, "Construction", 430,
  2010, "Commerce de gros et de détail", 260,
  2010, "Services domestiques", 250,
  2010, "Industrie manufacturière", 250,
  2015, "Construction", 440,
  2015, "Commerce de gros et de détail", 435,
  2015, "Services domestiques", 270,
  2015, "Industrie manufacturière", 250,
  2020, "Construction", 570,
  2020, "Commerce de gros et de détail", 450,
  2020, "Services domestiques", 320,
  2020, "Industrie manufacturière", 260
)

p_secteurs <- ggplot(data_secteurs, aes(x = Annee, y = Indice, color = Secteur, group = Secteur)) +
  geom_line(linewidth = 2) +
  geom_point(size = 5) +
  geom_hline(yintercept = 100, linetype = "dashed", color = "grey50") +
  geom_text(
    data = data_secteurs %>% filter(Annee == 2020),
    aes(label = Secteur),
    hjust = 0, nudge_x = 0.5, fontface = "bold", size = 4.5
  ) +
  scale_color_manual(
    values = c(
      "Construction" = "#9B59B6", 
      "Commerce de gros et de détail" = "#2ECC71", 
      "Services domestiques" = "#3498DB", 
      "Industrie manufacturière" = "#F39C12" 
    )
  ) +
  scale_x_continuous(breaks = c(2004, 2010, 2015, 2020), limits = c(2004, 2026)) +
  labs(
    title = "Évolution de l'Indice du nombre d'employés par secteur",
    subtitle = "Qatar (Base 100 = 2004)",
    y = "Indice (Base 100)",
    x = "",
    caption = "Source : Calculs des auteurs, Recensements (2004, 2010, 2015, 2020), NPC Qatar."
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 18),
    plot.subtitle = element_text(size = 12, color = "grey40"),
    panel.grid.minor = element_blank(),
    plot.caption = element_text(size = 9, color = "grey60", face = "italic")
  )

ggsave("outputs/figures/05_Sector_Growth_Index.png", plot = p_secteurs, width = 12, height = 7, dpi = 300)
cat("✓ Saved sector growth index\n\n")

# --- THE "CARE DRAIN" HYPOTHESIS -------

data_care_complete <- tidy_data %>%
  filter(Dest_Region %in% c("Arabie Saoudite", "Qatar", "Émirats Arabes Unis")) %>%
  filter(Sexe == "Female") %>%
  filter(Origin_Region %in% c("Philippines", "Indonesia", "Ethiopia", "Kenya", "Pakistan", "Bangladesh")) %>%
  
  mutate(Pays_Origine = case_when(
    Origin_Region == "Philippines" ~ "Philippines",
    Origin_Region == "Indonesia" ~ "Indonésie",
    Origin_Region == "Ethiopia" ~ "Éthiopie",
    Origin_Region == "Kenya" ~ "Kenya",
    Origin_Region == "Pakistan" ~ "Pakistan",
    Origin_Region == "Bangladesh" ~ "Bangladesh"
  )) %>%
  
  mutate(Type_Filiere = case_when(
    Pays_Origine %in% c("Philippines", "Indonésie", "Éthiopie", "Kenya") ~ "Care (Gros)",
    TRUE ~ "Témoin (Fin)"
  ))

p_care_contrast <- ggplot(data_care_complete, aes(x = Annee, y = Stock, color = Pays_Origine, group = Pays_Origine)) +
  
  geom_line(aes(linewidth = Type_Filiere)) +
  geom_point(size = 2.5) +
  
  facet_wrap(~Dest_Region, scales = "free_y", ncol = 3) +
  
  scale_color_manual(values = c(
    "Philippines" = "#FF1493", 
    "Indonésie"   = "#9B59B6", 
    "Éthiopie"    = "#4A235A", 
    "Kenya"       = "#D2B4DE", 
    "Bangladesh"  = "#BDC3C7", 
    "Pakistan"    = "#95A5A6"
  )) +
  
  scale_linewidth_manual(values = c(
    "Care (Gros)" = 2,
    "Témoin (Fin)" = 0.8
  )) +
  
  scale_y_continuous(labels = scales::label_number(scale_cut = scales::cut_short_scale())) +
  scale_x_continuous(breaks = c(1990, 2010, 2024)) +
  
  labs(
    title = "Recomposition du marché du 'Care'",
    subtitle = "L'essor de la migration éthiopienne (Prune foncé) succède au retrait indonésien (Lavande)",
    y = "Nombre de Femmes",
    x = "",
    color = "",
    caption = "Source : ONU DESA, Global Migration Database (2024)."
  ) +
  
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "top",
    legend.text = element_text(face = "bold", size = 10),
    strip.text = element_text(face = "bold", size = 13),
    plot.title = element_text(face = "bold", size = 16),
    panel.grid.minor = element_blank()
  ) +
  guides(linewidth = "none")

ggsave("outputs/figures/06_Care_Drain_Violet_Contrast.png", plot = p_care_contrast, width = 14, height = 8, dpi = 300)
cat("✓ Saved care drain visualization\n\n")

# --- UAE SECTORS ---

p_uae_sectors <- ggplot(
  uae_sectors %>% filter(!is.na(time)),
  aes(x = big_sector, y = share, fill = sex_label)
) +
  
  geom_col(position = "fill") +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "UAE – Employment by broad sector and sex",
    x = "", y = "Share of total employment",
    fill = "Sex",
    caption = "Source: ILOSTAT, UAE LFS – Employment by sex, occupation and economic activity (ISIC Rev.4)."
  ) +
  theme_minimal()

ggsave("outputs/figures/07_UAE_sectors_total.png", plot = p_uae_sectors, width = 10, height = 6, dpi = 300)
cat("✓ Saved UAE sector employment\n\n")

cat("✓ ALL VISUALIZATIONS COMPLETE.\n")
