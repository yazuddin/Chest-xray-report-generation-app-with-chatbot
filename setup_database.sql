-- Create medical_report database
CREATE DATABASE IF NOT EXISTS medical_report;
USE medical_report;

-- Create users table for authentication
CREATE TABLE IF NOT EXISTS users (
  id VARCHAR(36) PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('medical_technician', 'doctor', 'patient') NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  phone VARCHAR(20),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create patients table (for patient-specific information)
CREATE TABLE IF NOT EXISTS patients (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) UNIQUE NOT NULL,
  patient_id VARCHAR(20) UNIQUE NOT NULL,
  date_of_birth DATE,
  gender ENUM('male', 'female', 'other'),
  address TEXT,
  emergency_contact VARCHAR(255),
  medical_history TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create medical_reports table (enhanced version)
CREATE TABLE IF NOT EXISTS medical_reports (
  id VARCHAR(36) PRIMARY KEY,
  patient_id VARCHAR(36) NOT NULL,
  technician_id VARCHAR(36) NOT NULL,
  doctor_id VARCHAR(36),
  image_path VARCHAR(500) NOT NULL,
  image_name VARCHAR(255) NOT NULL,
  report_data JSON,
  analysis_result TEXT,
  status ENUM('uploaded', 'analyzed', 'reviewed', 'completed') DEFAULT 'uploaded',
  payment_status ENUM('pending', 'paid', 'failed') DEFAULT 'pending',
  payment_amount DECIMAL(10, 2) DEFAULT 0.00,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
  FOREIGN KEY (technician_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (doctor_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Create payments table
CREATE TABLE IF NOT EXISTS payments (
  id VARCHAR(36) PRIMARY KEY,
  report_id VARCHAR(36) NOT NULL,
  patient_id VARCHAR(36) NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  payment_method VARCHAR(50),
  transaction_id VARCHAR(255),
  status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
  payment_date TIMESTAMP NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (report_id) REFERENCES medical_reports(id) ON DELETE CASCADE,
  FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
);

-- Create medical_analyses table
CREATE TABLE IF NOT EXISTS medical_analyses (
  id VARCHAR(36) PRIMARY KEY,
  question TEXT NOT NULL,
  report TEXT,
  timestamp DATETIME NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create chat_history table
CREATE TABLE IF NOT EXISTS chat_history (
  id VARCHAR(36) PRIMARY KEY,
  message TEXT NOT NULL,
  response TEXT,
  session_id VARCHAR(36),
  timestamp DATETIME NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create xray_reports table
CREATE TABLE IF NOT EXISTS xray_reports (
  id VARCHAR(36) PRIMARY KEY,
  filename VARCHAR(255) NOT NULL,
  patient_info JSON,
  analysis_result JSON,
  report_text TEXT,
  timestamp DATETIME NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample data

-- Sample medical technician
INSERT IGNORE INTO users (id, email, password, role, first_name, last_name, phone) VALUES 
('tech-001', 'technician@medical.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/VcSAg/9qm', 'medical_technician', 'John', 'Smith', '+1234567890');

-- Sample doctor
INSERT IGNORE INTO users (id, email, password, role, first_name, last_name, phone) VALUES 
('doc-001', 'doctor@medical.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/VcSAg/9qm', 'doctor', 'Dr. Sarah', 'Johnson', '+1234567891');

-- Sample patient
INSERT IGNORE INTO users (id, email, password, role, first_name, last_name, phone) VALUES 
('patient-001', 'patient@test.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/VcSAg/9qm', 'patient', 'Alice', 'Brown', '+1234567892');

-- Sample patient profile
INSERT IGNORE INTO patients (id, user_id, patient_id, date_of_birth, gender, address, emergency_contact) VALUES 
('pat-profile-001', 'patient-001', 'P123456789', '1990-05-15', 'female', '123 Main St, City, State', 'Emergency Contact: +1234567893');

SELECT 'Database setup completed successfully!' as message;