-- =============================================
-- DML QUERIES — eurobulk logistics database
-- =============================================

-- View all drivers
SELECT * FROM drivers;

-- View all trucks
SELECT * FROM trucks;

-- View all trailers
SELECT * FROM trailers;

-- View all trips
SELECT * FROM trips;

-- View all trip events
SELECT * FROM trip_events;

-- View all driver assignments
SELECT * FROM truck_driver_assignments;

-- View all trailer assignments
SELECT * FROM truck_trailer_assignments;

-- =============================================
-- ANALYTICAL QUERIES
-- =============================================

-- List all trips with truck and trailer numbers
SELECT DISTINCT trip_id, truck_number, trailer_number
FROM eurobulk.vw_trip_analysis
ORDER BY trip_id;

-- Show which trailers were used on each trip
SELECT t.trip_id, t.trailer_id, tl.trailer_number, t.start_date, t.end_date
FROM trips t
JOIN trailers tl ON t.trailer_id = tl.trailer_id
ORDER BY t.trip_id;

-- Show all trailers and their associated trips (including unused trailers)
SELECT t.trailer_id, t.trailer_number, tr.trip_id
FROM trailers t
LEFT JOIN trips tr ON t.trailer_id = tr.trailer_id;

-- Full event log per trip with truck and trailer info
SELECT
    te.event_id,
    te.location,
    te.arrival_timestamp,
    tr.truck_number,
    tra.trailer_number,
    ta.trailer_id
FROM trip_events te
JOIN trips t 
    ON te.trip_id = t.trip_id
JOIN trucks tr 
    ON t.truck_id = tr.truck_id
JOIN truck_trailer_assignments ta 
    ON t.truck_id = ta.truck_id
   AND te.arrival_timestamp BETWEEN ta.start_timestamp 
                                AND ta.end_timestamp
JOIN trailers tra 
    ON ta.trailer_id = tra.trailer_id
ORDER BY te.arrival_timestamp;

-- Trip summary: which truck and trailer were used
SELECT 
	trip_id, 
	start_date,
	end_date, 
	truck_id, 
	trailer_id 
FROM trips
ORDER BY trip_id;

-- Events for specific trips
SELECT 
	event_id, 
	trip_id, 
	arrival_timestamp, 
	location, 
	action_type
FROM trip_events
WHERE trip_id IN (2, 4)
ORDER BY trip_id, arrival_timestamp;

-- Trip history for a specific truck
SELECT trip_id, start_date, end_date, truck_id, trailer_id, driver_id 
FROM eurobulk.trips 
WHERE truck_id = 1;

-- All events for a specific truck ordered by time
SELECT te.*, t.trailer_id 
FROM eurobulk.trip_events te
JOIN eurobulk.trips t ON te.trip_id = t.trip_id
WHERE t.truck_id = 2
ORDER BY te.arrival_timestamp;
