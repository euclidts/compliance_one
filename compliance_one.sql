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
--     calling_code VARCHAR(6),
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

-- CREATE TABLE address
-- (
--     id INT AUTO_INCREMENT,
--     PRIMARY KEY(id),
--     country_id MEDIUMINT UNSIGNED,
--     CONSTRAINT FOREIGN KEY (country_id) REFERENCES country (id),
--     address_lines VARCHAR(255),
--     locality VARCHAR(63),
--     region VARCHAR(63),
--     postcode VARCHAR(31)
-- )

-- CREATE TABLE individual
-- (
--     id INT AUTO_INCREMENT,
--     PRIMARY KEY(id),
--     contact_id INT UNIQUE,
--     CONSTRAINT FOREIGN KEY (contact_id) REFERENCES contact (id),
--     local_name VARCHAR(63),
--     local_forenames VARCHAR(63),
--     date_of_birth DATE,
--     passport VARCHAR(63),
--     expeiry_date DATE,
--     issuing MEDIUMINT UNSIGNED,
--     CONSTRAINT FOREIGN KEY (issuing) REFERENCES country (id),
--     pep BOOLEAN NOT NULL DEFAULT false,
--     pep_country MEDIUMINT UNSIGNED,
--     CONSTRAINT FOREIGN KEY (pep_country) REFERENCES country (id),
--     pep_notes VARCHAR(255),
--     notes VARCHAR(255),
--     address_id INT,
--     CONSTRAINT FOREIGN KEY (address_id) REFERENCES address (id)
-- )

-- CREATE TABLE ctp_group 
-- (
--     id INT AUTO_INCREMENT,
--     PRIMARY KEY(id),
--     name VARCHAR(63)
-- )

-- CREATE TABLE ctp_type 
-- (
--     id INT AUTO_INCREMENT,
--     PRIMARY KEY(id),
--     group_id INT NOT NULL,
--     CONSTRAINT FOREIGN KEY (group_id) REFERENCES ctp_group (id),
--     name VARCHAR(63),
--     notes VARCHAR(255),
--     risk_score TINYINT UNSIGNED
-- )

CREATE TABLE company
(
    id INT AUTO_INCREMENT,
    PRIMARY KEY(id),
    uuid VARCHAR(63),
    name VARCHAR(63),
    local_name VARCHAR(63),
    is_branch BOOLEAN NOT NULL DEFAULT false,
    address_id INT,
    CONSTRAINT FOREIGN KEY (address_id) REFERENCES address (id),
    branch_address_id INT,
    CONSTRAINT FOREIGN KEY (branch_address_id) REFERENCES address (id),
    website VARCHAR(127),
    contact_id INT,
    CONSTRAINT FOREIGN KEY (contact_id) REFERENCES contact (id),
    is_public BOOLEAN NOT NULL DEFAULT false,
    comercial_registery VARCHAR(127),
    branch_registery VARCHAR(127),
    listing_country_id MEDIUMINT UNSIGNED,
    CONSTRAINT FOREIGN KEY (listing_country_id) REFERENCES country (id),
    lei VARCHAR(127),
    pep BOOLEAN NOT NULL DEFAULT false,
    soe BOOLEAN NOT NULL DEFAULT false,
    regulated BOOLEAN NOT NULL DEFAULT false,
    ancellery BOOLEAN NOT NULL DEFAULT false,
    acer VARCHAR(127)
)