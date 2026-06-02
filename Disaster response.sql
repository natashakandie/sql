CREATE DATABASE disaster_response_system;

USE disaster_response_system;

CREATE TABLE incidents(
    incident_id INT AUTO_INCREMENT PRIMARY KEY,
    incident_type VARCHAR(100),
    location VARCHAR(255),
    severity_level ENUM('Low','Medium','High','Critical'),
    date_reported DATETIME,
    status ENUM('Active','Resolved') DEFAULT 'Active'
);

CREATE TABLE rescue_teams(
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(255),
    specialization VARCHAR(100),
    contact_number VARCHAR(20),
    availability_status ENUM('Available','Deployed')
);

CREATE TABLE hospitals(
    hospital_id INT AUTO_INCREMENT PRIMARY KEY,
    hospital_name VARCHAR(255),
    location VARCHAR(255),
    capacity INT,
    contact_number VARCHAR(20)
);

CREATE TABLE shelters(
    shelter_id INT AUTO_INCREMENT PRIMARY KEY,
    shelter_name VARCHAR(255),
    location VARCHAR(255),
    capacity INT,
    current_occupancy INT
);

CREATE TABLE volunteers(
    volunteer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255),
    phone VARCHAR(20),
    skill VARCHAR(100),
    availability_status ENUM('Available','Assigned')
);

CREATE TABLE supplies(
    supply_id INT AUTO_INCREMENT PRIMARY KEY,
    supply_name VARCHAR(255),
    quantity INT,
    unit VARCHAR(50)
);

CREATE TABLE vehicles(
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    registration_number VARCHAR(50),
    vehicle_type VARCHAR(100),
    status ENUM('Available','In Use','Maintenance')
);

CREATE TABLE victims(
    victim_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255),
    age INT,
    gender VARCHAR(10),
    incident_id INT,
    shelter_id INT,
    FOREIGN KEY (incident_id) REFERENCES incidents(incident_id),
    FOREIGN KEY (shelter_id) REFERENCES shelters(shelter_id)
);

CREATE TABLE emergency_calls(
    call_id INT AUTO_INCREMENT PRIMARY KEY,
    caller_name VARCHAR(255),
    phone VARCHAR(20),
    incident_id INT,
    call_time DATETIME,
    FOREIGN KEY (incident_id) REFERENCES incidents(incident_id)
);

CREATE TABLE operations(
    operation_id INT AUTO_INCREMENT PRIMARY KEY,
    incident_id INT,
    team_id INT,
    vehicle_id INT,
    operation_date DATETIME,
    FOREIGN KEY (incident_id) REFERENCES incidents(incident_id),
    FOREIGN KEY (team_id) REFERENCES rescue_teams(team_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

SHOW TABLES;

DESCRIBE incidents;
DESCRIBE rescue_teams;
DESCRIBE hospitals;
DESCRIBE shelters;
DESCRIBE volunteers;
DESCRIBE supplies;
DESCRIBE vehicles;
DESCRIBE victims;
DESCRIBE emergency_calls;
DESCRIBE operations;