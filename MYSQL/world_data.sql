-- Public reference data seed.
-- Source: World Bank Country API (ISO codes, names, regions, income/lending classifications, capitals).
-- API documentation: https://datahelpdesk.worldbank.org/knowledgebase/articles/898590-country-api-queries
-- Values here are reference metadata, not user/account data.

CREATE TABLE IF NOT EXISTS world_countries (
  country_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  iso2 CHAR(2) NOT NULL UNIQUE,
  iso3 CHAR(3) NOT NULL UNIQUE,
  country_name VARCHAR(160) NOT NULL,
  region_name VARCHAR(160) NULL,
  income_level VARCHAR(160) NULL,
  lending_type VARCHAR(160) NULL,
  capital_city VARCHAR(160) NULL,
  latitude DECIMAL(10,6) NULL,
  longitude DECIMAL(10,6) NULL,
  source_name VARCHAR(64) NOT NULL DEFAULT 'World Bank',
  source_version VARCHAR(32) NOT NULL DEFAULT 'API v2',
  loaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO world_countries
  (iso2, iso3, country_name, region_name, income_level, lending_type, capital_city, latitude, longitude)
VALUES
('CA','CAN','Canada','North America','High income','Not classified','Ottawa',45.4215,-75.6972),
('US','USA','United States','North America','High income','Not classified','Washington D.C.',38.8951,-77.0364),
('MX','MEX','Mexico','Latin America & Caribbean','Upper middle income','IBRD','Mexico City',19.4326,-99.1332),
('BR','BRA','Brazil','Latin America & Caribbean','Upper middle income','IBRD','Brasilia',-15.7939,-47.8828),
('GB','GBR','United Kingdom','Europe & Central Asia','High income','Not classified','London',51.5074,-0.1278),
('FR','FRA','France','Europe & Central Asia','High income','Not classified','Paris',48.8566,2.3522),
('DE','DEU','Germany','Europe & Central Asia','High income','Not classified','Berlin',52.5200,13.4050),
('IN','IND','India','South Asia','Lower middle income','IBRD','New Delhi',28.6139,77.2090),
('CN','CHN','China','East Asia & Pacific','Upper middle income','IBRD','Beijing',39.9042,116.4074),
('JP','JPN','Japan','East Asia & Pacific','High income','Not classified','Tokyo',35.6762,139.6503),
('AU','AUS','Australia','East Asia & Pacific','High income','Not classified','Canberra',-35.2809,149.1300),
('ZA','ZAF','South Africa','Sub-Saharan Africa','Upper middle income','IBRD','Pretoria',-25.7479,28.2293),
('NG','NGA','Nigeria','Sub-Saharan Africa','Lower middle income','IDA','Abuja',9.0765,7.3986),
('EG','EGY','Egypt','Middle East, North Africa, Afghanistan & Pakistan','Lower middle income','IBRD','Cairo',30.0444,31.2357),
('SA','SAU','Saudi Arabia','Middle East, North Africa, Afghanistan & Pakistan','High income','Not classified','Riyadh',24.7136,46.6753)
ON DUPLICATE KEY UPDATE
  country_name=VALUES(country_name), region_name=VALUES(region_name), income_level=VALUES(income_level),
  lending_type=VALUES(lending_type), capital_city=VALUES(capital_city), latitude=VALUES(latitude), longitude=VALUES(longitude);

CREATE TABLE IF NOT EXISTS world_indicators (
  indicator_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  iso3 CHAR(3) NOT NULL,
  indicator_code VARCHAR(32) NOT NULL,
  indicator_name VARCHAR(255) NOT NULL,
  year SMALLINT NOT NULL,
  value_decimal DECIMAL(30,6) NULL,
  source_name VARCHAR(64) NOT NULL DEFAULT 'World Bank',
  UNIQUE KEY uq_world_indicator (iso3, indicator_code, year),
  CONSTRAINT fk_world_indicator_country FOREIGN KEY (iso3) REFERENCES world_countries(iso3)
);

-- Indicator codes documented by the World Bank Indicators API.
INSERT INTO world_indicators (iso3, indicator_code, indicator_name, year, value_decimal) VALUES
('CAN','SP.POP.TOTL','Population, total',2024,40000000),
('USA','SP.POP.TOTL','Population, total',2024,340000000),
('MEX','SP.POP.TOTL','Population, total',2024,130000000),
('BRA','SP.POP.TOTL','Population, total',2024,212000000),
('GBR','SP.POP.TOTL','Population, total',2024,69000000),
('FRA','SP.POP.TOTL','Population, total',2024,68000000),
('DEU','SP.POP.TOTL','Population, total',2024,84000000),
('IND','SP.POP.TOTL','Population, total',2024,1450000000),
('CHN','SP.POP.TOTL','Population, total',2024,1419000000),
('JPN','SP.POP.TOTL','Population, total',2024,124000000),
('AUS','SP.POP.TOTL','Population, total',2024,27000000),
('ZAF','SP.POP.TOTL','Population, total',2024,63000000),
('NGA','SP.POP.TOTL','Population, total',2024,230000000),
('EGY','SP.POP.TOTL','Population, total',2024,116000000),
('SAU','SP.POP.TOTL','Population, total',2024,35000000)
ON DUPLICATE KEY UPDATE value_decimal=VALUES(value_decimal), indicator_name=VALUES(indicator_name);

-- The population figures above are deliberately rounded seed values for development/testing.
-- Production analytics should import exact observations from the World Bank API rather than treating these rounded values as authoritative.
