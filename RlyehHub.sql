CREATE DATABASE IF NOT EXISTS ficha_manager;
USE ficha_manager;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('player','master','admin') DEFAULT 'player',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE sheets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    class VARCHAR(50),
    race VARCHAR(50),
    level INT DEFAULT 1,
    image VARCHAR(255) DEFAULT NULL,
    bio TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_sheet_user FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE sheet_attributes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sheet_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    value INT DEFAULT 0,
    max_value INT DEFAULT NULL,
    CONSTRAINT fk_attr_sheet FOREIGN KEY (sheet_id)
    REFERENCES sheets(id) ON DELETE CASCADE
);

CREATE TABLE sheet_stats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sheet_id INT NOT NULL,
    hp INT DEFAULT 0,
    mp INT DEFAULT 0,
    attack INT DEFAULT 0,
    defense INT DEFAULT 0,
    speed INT DEFAULT 0,
    CONSTRAINT fk_stats_sheet FOREIGN KEY (sheet_id)
    REFERENCES sheets(id) ON DELETE CASCADE
);

CREATE TABLE skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    type ENUM('magic','physical','passive') NOT NULL,
    cost INT DEFAULT NULL
);

CREATE TABLE sheet_skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sheet_id INT NOT NULL,
    skill_id INT NOT NULL,
    level INT DEFAULT 1,
    CONSTRAINT fk_ss_sheet FOREIGN KEY (sheet_id)
    REFERENCES sheets(id) ON DELETE CASCADE,
    CONSTRAINT fk_ss_skill FOREIGN KEY (skill_id)
    REFERENCES skills(id) ON DELETE CASCADE
);

CREATE TABLE inventory_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    type VARCHAR(50)
);

CREATE TABLE sheet_inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sheet_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT DEFAULT 1,
    CONSTRAINT fk_inv_sheet FOREIGN KEY (sheet_id)
    REFERENCES sheets(id) ON DELETE CASCADE,
    CONSTRAINT fk_inv_item FOREIGN KEY (item_id)
    REFERENCES inventory_items(id) ON DELETE CASCADE
);

CREATE TABLE campaigns (
    id INT AUTO_INCREMENT PRIMARY KEY,
    master_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_campaign_master FOREIGN KEY (master_id)
    REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE campaign_players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_id INT NOT NULL,
    user_id INT NOT NULL,
    sheet_id INT NOT NULL,
    CONSTRAINT fk_cp_campaign FOREIGN KEY (campaign_id)
    REFERENCES campaigns(id) ON DELETE CASCADE,
    CONSTRAINT fk_cp_user FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_cp_sheet FOREIGN KEY (sheet_id)
    REFERENCES sheets(id) ON DELETE CASCADE
);
