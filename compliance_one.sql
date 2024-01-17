-- CREATE TABLE user 
-- (
--     id INT AUTO_INCREMENT,
--     PRIMARY KEY(id),
--     username VARCHAR(63),
--     password VARCHAR(255),
--     clearance TINYINT UNSIGNED,
--     session_id UUID
-- )

-- CREATE TABLE product_group 
-- (
--     id INT AUTO_INCREMENT,
--     PRIMARY KEY(id),
--     name VARCHAR(63)
-- )

-- CREATE TABLE product 
-- (
--     id INT AUTO_INCREMENT,
--     PRIMARY KEY(id),
--     group_id INT NOT NULL,
--     CONSTRAINT FOREIGN KEY (group_id) REFERENCES product_group (id),
--     commodity VARCHAR(63),
--     risk_score TINYINT UNSIGNED
-- )

-- CREATE TABLE contact 
-- (
--     id INT AUTO_INCREMENT,
--     PRIMARY KEY(id),
--     family_name VARCHAR(63),
--     forenames VARCHAR(63),
--     email VARCHAR(127),
--     calling_code VARCHAR(5),
--     phone VARCHAR(13)
-- )

-- run sql scripts dowloaded from 
-- https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/sql/countries.sql

-- ALTER TABLE countries
-- DROP COLUMN iso2,
-- DROP COLUMN capital,
-- DROP COLUMN currency,
-- DROP COLUMN currency_name,
-- DROP COLUMN currency_symbol,
-- DROP COLUMN tld,
-- DROP COLUMN native,
-- DROP COLUMN region,
-- DROP COLUMN subregion,
-- DROP COLUMN nationality,
-- DROP COLUMN timezones,
-- DROP COLUMN translations,
-- DROP COLUMN emojiU,
-- DROP COLUMN created_at,
-- DROP COLUMN deleted_at,
-- DROP COLUMN flag,
-- DROP CONSTRAINT country_continent_final,
-- DROP CONSTRAINT country_subregion_final,
-- DROP COLUMN region_id,
-- DROP COLUMN subregion_id,
-- ADD COLUMN ranking TINYINT UNSIGNED,
-- ADD COLUMN fatf TINYINT UNSIGNED,
-- ADD COLUMN transparency TINYINT UNSIGNED,
-- ADD COLUMN world_bank TINYINT UNSIGNED,
-- ADD COLUMN sovereignty_id MEDIUMINT UNSIGNED,
-- ADD CONSTRAINT FOREIGN KEY (sovereignty_id) REFERENCES countries (id)

-- SELECT name, latitude, longitude, updated_at FROM country
