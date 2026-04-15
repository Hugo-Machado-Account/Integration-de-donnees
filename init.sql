CREATE TABLE IF NOT EXISTS dim_artistes (
    id      SERIAL PRIMARY KEY,
    nom     VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS dim_chansons (
    id      SERIAL PRIMARY KEY,
    titre   VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_genres (
    id      SERIAL PRIMARY KEY,
    genre   VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS dim_temps (
    id       SERIAL PRIMARY KEY,
    annee    INT NOT NULL,
    decennie VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS fact_popularite (
    id          SERIAL PRIMARY KEY,
    artiste_id  INT REFERENCES dim_artistes(id),
    chanson_id  INT REFERENCES dim_chansons(id),
    genre_id    INT REFERENCES dim_genres(id),
    temps_id    INT REFERENCES dim_temps(id),
    popularite  INT,
    duree_ms    INT,
    tempo       FLOAT,
    explicite   BOOLEAN
);

-- Index pour accélérer les requêtes analytiques
CREATE INDEX IF NOT EXISTS idx_fact_genre    ON fact_popularite(genre_id);
CREATE INDEX IF NOT EXISTS idx_fact_temps    ON fact_popularite(temps_id);
CREATE INDEX IF NOT EXISTS idx_fact_artiste  ON fact_popularite(artiste_id);
CREATE INDEX IF NOT EXISTS idx_fact_pop      ON fact_popularite(popularite);