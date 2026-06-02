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
-- INCIDENTS
INSERT INTO incidents (incident_type, location, severity_level, date_reported, status) VALUES
('Flood','Nairobi','High','2026-05-20 08:30:00','Active'),
('Fire','Mombasa','Critical','2026-05-21 10:00:00','Active'),
('Road Accident','Nakuru','Medium','2026-05-22 14:15:00','Resolved'),
('Landslide','Muranga','High','2026-05-23 07:45:00','Active'),
('Building Collapse','Kisumu','Critical','2026-05-24 12:00:00','Active'),
('Drought','Turkana','High','2026-05-25 09:00:00','Active'),
('Flood','Garissa','Medium','2026-05-26 16:30:00','Resolved'),
('Fire','Eldoret','High','2026-05-27 18:20:00','Active'),
('Road Accident','Machakos','Low','2026-05-28 11:15:00','Resolved'),
('Disease Outbreak','Kakamega','Critical','2026-05-29 06:00:00','Active');

-- RESCUE TEAMS
INSERT INTO rescue_teams (team_name, specialization, contact_number, availability_status) VALUES
('Red Cross Team A','Flood Rescue','0701000001','Available'),
('Fire Squad Alpha','Fire Response','0701000002','Deployed'),
('EMS Unit Nairobi','Medical Emergency','0701000003','Available'),
('Mountain Rescue','Landslide Response','0701000004','Available'),
('Urban Rescue Team','Building Collapse','0701000005','Deployed'),
('Water Rescue Unit','Flood Rescue','0701000006','Available'),
('Health Response Team','Disease Control','0701000007','Available'),
('Northern Rescue','Drought Relief','0701000008','Deployed'),
('Rapid Response Unit','Accident Response','0701000009','Available'),
('Disaster Team Kenya','Multi-Purpose','0701000010','Available');

-- HOSPITALS
INSERT INTO hospitals (hospital_name, location, capacity, contact_number) VALUES
('Kenyatta National Hospital','Nairobi',2000,'0711111111'),
('Moi Teaching Hospital','Eldoret',1500,'0711111112'),
('Coast General Hospital','Mombasa',1200,'0711111113'),
('Jaramogi Hospital','Kisumu',1000,'0711111114'),
('Nakuru County Hospital','Nakuru',900,'0711111115'),
('Machakos Hospital','Machakos',800,'0711111116'),
('Garissa County Hospital','Garissa',700,'0711111117'),
('Kakamega Hospital','Kakamega',850,'0711111118'),
('Muranga Hospital','Muranga',600,'0711111119'),
('Turkana Referral Hospital','Turkana',500,'0711111120');

-- View all data
SELECT * FROM incidents;
SELECT * FROM rescue_teams;
SELECT * FROM hospitals;
SELECT * FROM shelters;
SELECT * FROM volunteers;
SELECT * FROM supplies;
SELECT * FROM vehicles;
SELECT * FROM victims;
SELECT * FROM emergency_calls;
SELECT * FROM operations;

-- Active incidents
SELECT * FROM incidents
WHERE status='Active';

-- Available rescue teams
SELECT * FROM rescue_teams
WHERE availability_status='Available';

-- Available vehicles
SELECT * FROM vehicles
WHERE status='Available';

-- Count reports
SELECT COUNT(*) AS total_incidents FROM incidents;
SELECT COUNT(*) AS total_victims FROM victims;
SELECT COUNT(*) AS total_volunteers FROM volunteers;
SELECT COUNT(*) AS total_hospitals FROM hospitals;

-- Incidents by severity
SELECT severity_level, COUNT(*) AS total
FROM incidents
GROUP BY severity_level;

-- Victims and their incidents
SELECT
    v.full_name,
    v.age,
    i.incident_type,
    i.location
FROM victims v
JOIN incidents i
ON v.incident_id = i.incident_id;

-- Operations report
SELECT
    i.incident_type,
    r.team_name,
    o.operation_date
FROM operations o
JOIN incidents i ON o.incident_id=i.incident_id
JOIN rescue_teams r ON o.team_id=r.team_id;