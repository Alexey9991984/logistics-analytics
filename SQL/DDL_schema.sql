--- create schema
CREATE SCHEMA logistic;

--- create table
CREATE TABLE drivers (
	 driver_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	 full_name VARCHAR (45) NULL 
);

--- create table
CREATE TABLE trucks (
	 truck_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	 truck_number VARCHAR (20) NOT NULL UNIQUE
);

--- create table
CREATE TABLE trailers (
	trailer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    trailer_number VARCHAR (20) NOT NULL UNIQUE,
    trailer_type VARCHAR(50)
    );

--- create table
CREATE TABLE trips (
    trip_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    driver_id INT NOT NULL,
    truck_id  INT NOT NULL,
    trailer_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date   DATE,
	FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    FOREIGN KEY (truck_id)   REFERENCES trucks(truck_id),
    FOREIGN KEY (trailer_id) REFERENCES trailers(trailer_id)
);

--- create table
CREATE TABLE trip_events (
    event_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    trip_id INT NOT NULL,
    arrival_timestamp TIMESTAMP NOT NULL,
    departure_timestamp TIMESTAMP,
    location VARCHAR(100) NOT NULL,
    odometer INT NOT NULL,
    action_type VARCHAR(30) NOT NULL,
    notes TEXT,
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id)
);

--- create table
CREATE TABLE truck_driver_assignments (
    assignment_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    truck_id INT NOT NULL,
    driver_id INT NOT NULL,
    start_timestamp TIMESTAMP NOT NULL,
    end_timestamp TIMESTAMP,
    FOREIGN KEY (truck_id) REFERENCES trucks(truck_id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

--- create table
CREATE TABLE truck_trailer_assignments (
    assignment_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	truck_id INT NOT NULL,
    trailer_id INT NOT NULL,
	start_timestamp TIMESTAMP NOT NULL,
    end_timestamp TIMESTAMP,
    FOREIGN KEY (truck_id) REFERENCES trucks(truck_id),
    FOREIGN KEY (trailer_id) REFERENCES trailers(trailer_id)
);
