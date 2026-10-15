-- Extended real-world reference data model.
-- Exact observations should be generated with TOOLS/worldbank_import.py.
-- The World Bank API supplies country metadata and time-series indicators.

CREATE TABLE IF NOT EXISTS world_indicator_catalog (
  indicator_code VARCHAR(32) PRIMARY KEY,
  indicator_name VARCHAR(255) NOT NULL,
  unit VARCHAR(100) NULL,
  source_name VARCHAR(150) NOT NULL,
  source_url VARCHAR(500) NOT NULL,
  enabled BOOLEAN NOT NULL DEFAULT TRUE
);

INSERT INTO world_indicator_catalog
(indicator_code, indicator_name, unit, source_name, source_url)
VALUES
('SP.POP.TOTL','Population, total','people','World Bank WDI','https://api.worldbank.org/v2/country/all/indicator/SP.POP.TOTL'),
('NY.GDP.MKTP.CD','GDP (current US$)','current US$','World Bank WDI','https://api.worldbank.org/v2/country/all/indicator/NY.GDP.MKTP.CD'),
('NY.GDP.PCAP.CD','GDP per capita (current US$)','current US$ per person','World Bank WDI','https://api.worldbank.org/v2/country/all/indicator/NY.GDP.PCAP.CD'),
('SP.DYN.LE00.IN','Life expectancy at birth, total (years)','years','World Bank WDI','https://api.worldbank.org/v2/country/all/indicator/SP.DYN.LE00.IN'),
('SL.UEM.TOTL.ZS','Unemployment, total (% of total labor force)','percent','World Bank WDI','https://api.worldbank.org/v2/country/all/indicator/SL.UEM.TOTL.ZS')
ON DUPLICATE KEY UPDATE indicator_name=VALUES(indicator_name), unit=VALUES(unit), source_url=VALUES(source_url);

CREATE TABLE IF NOT EXISTS world_data_import_runs (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  started_at DATETIME NOT NULL,
  completed_at DATETIME NULL,
  source_name VARCHAR(150) NOT NULL,
  start_year SMALLINT NOT NULL,
  end_year SMALLINT NOT NULL,
  country_rows INT NOT NULL DEFAULT 0,
  observation_rows INT NOT NULL DEFAULT 0,
  status VARCHAR(20) NOT NULL,
  error_message TEXT NULL
);

CREATE INDEX IF NOT EXISTS idx_world_indicators_indicator_year
  ON world_indicators(indicator_code, year);
CREATE INDEX IF NOT EXISTS idx_world_indicators_year
  ON world_indicators(year);

CREATE OR REPLACE VIEW world_country_latest AS
SELECT
  c.iso2,
  c.iso3,
  c.country_name,
  c.region_name,
  c.income_level,
  c.lending_type,
  c.capital_city,
  c.latitude,
  c.longitude,
  p.year AS population_year,
  p.value_decimal AS population,
  g.year AS gdp_year,
  g.value_decimal AS gdp_current_usd,
  pc.year AS gdp_per_capita_year,
  pc.value_decimal AS gdp_per_capita_usd,
  le.year AS life_expectancy_year,
  le.value_decimal AS life_expectancy_years,
  ue.year AS unemployment_year,
  ue.value_decimal AS unemployment_percent
FROM world_countries c
LEFT JOIN world_indicators p ON p.iso3=c.iso3 AND p.indicator_code='SP.POP.TOTL' AND p.year=(SELECT MAX(x.year) FROM world_indicators x WHERE x.iso3=c.iso3 AND x.indicator_code='SP.POP.TOTL')
LEFT JOIN world_indicators g ON g.iso3=c.iso3 AND g.indicator_code='NY.GDP.MKTP.CD' AND g.year=(SELECT MAX(x.year) FROM world_indicators x WHERE x.iso3=c.iso3 AND x.indicator_code='NY.GDP.MKTP.CD')
LEFT JOIN world_indicators pc ON pc.iso3=c.iso3 AND pc.indicator_code='NY.GDP.PCAP.CD' AND pc.year=(SELECT MAX(x.year) FROM world_indicators x WHERE x.iso3=c.iso3 AND x.indicator_code='NY.GDP.PCAP.CD')
LEFT JOIN world_indicators le ON le.iso3=c.iso3 AND le.indicator_code='SP.DYN.LE00.IN' AND le.year=(SELECT MAX(x.year) FROM world_indicators x WHERE x.iso3=c.iso3 AND x.indicator_code='SP.DYN.LE00.IN')
LEFT JOIN world_indicators ue ON ue.iso3=c.iso3 AND ue.indicator_code='SL.UEM.TOTL.ZS' AND ue.year=(SELECT MAX(x.year) FROM world_indicators x WHERE x.iso3=c.iso3 AND x.indicator_code='SL.UEM.TOTL.ZS');
