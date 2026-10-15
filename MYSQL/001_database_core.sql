CREATE DATABASE IF NOT EXISTS business_os CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE business_os;

CREATE TABLE IF NOT EXISTS system_settings (
  setting_key VARCHAR(128) PRIMARY KEY,
  setting_value TEXT NOT NULL,
  is_secret BOOLEAN NOT NULL DEFAULT FALSE,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS audit_log (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  event_type VARCHAR(64) NOT NULL,
  actor_user_id BIGINT UNSIGNED NULL,
  event_data JSON NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_audit_created (created_at),
  INDEX idx_audit_actor (actor_user_id)
);

INSERT INTO system_settings(setting_key,setting_value,is_secret) VALUES
('system.mode','360',FALSE),
('system.theme','GREEN_ON_BLACK',FALSE),
('database.charset','utf8mb4',FALSE),
('database.pool_size','8',FALSE)
ON DUPLICATE KEY UPDATE setting_value=VALUES(setting_value);
