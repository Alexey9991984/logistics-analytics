-- =============================================
-- TRIP: MAY 25 – JUNE 12, 2026
-- Driver 1, Truck 4 (LKW 5QR1), Trailer 5 (CO4402)
-- =============================================

INSERT INTO trips (
	driver_id,
	truck_id,
	trailer_id,
	start_date,
	end_date
	)
VALUES (
	1,
	4,
	5,
	'2026-05-25',
	'2026-06-12'
);

--- driver assignment for the duration of the trip
INSERT INTO truck_driver_assignments (
    truck_id,
    driver_id,
    start_timestamp,
    end_timestamp
)
VALUES (
    4,
    1,
    '2026-05-25 16:00',
    '2026-06-12 22:00'
);

--- trailer assignment for the duration of the trip
INSERT INTO truck_trailer_assignments (
    truck_id,
    trailer_id,
    start_timestamp,
    end_timestamp
)
VALUES (
    4,
    5,
    '2026-05-25 16:00',
    '2026-06-12 22:00'
);

-- START
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
    departure_timestamp,
    location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-05-25 10:00:00',
	'2026-05-25 16:00:00',
	'Grenzstadt Depot',
	 196199,
	'start'
);



-- UNLOAD
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
    departure_timestamp,
    location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-05-26 07:00:00',
	'2026-05-26 08:40:00',
	'Kystby Confectionery',
	 196506,
	'unload'
);

-- WASH
INSERT INTO trip_events (
	trip_id, 
	arrival_timestamp, 
	departure_timestamp, 
	location, 
	odometer, 
	action_type)
VALUES (
	6,
	'2026-05-26 10:50',
	'2026-05-26 13:00',
	'Markvej TankClean',
	196611,'wash');

-- LOAD
INSERT INTO trip_events (
	trip_id, 
	arrival_timestamp, 
	departure_timestamp, 
	location, 
	odometer, 
	action_type)
VALUES (
	6,
	'2026-05-26 14:30',
	'2026-05-26 19:30',
	'Strandby Brewery',
	196710,
	'load');

-- UNLOAD
INSERT INTO trip_events (
	trip_id, 
	arrival_timestamp, 
	departure_timestamp, 
	location, 
	odometer, 
	action_type)
VALUES (
	6,
	'2026-05-28 05:50',
	'2026-05-28 08:00',
	'Kopernitz LiquidStore',
	197388,
	'unload');

-- WASH
INSERT INTO trip_events (
	trip_id, 
	arrival_timestamp, 
	departure_timestamp, 
	location, 
	odometer, 
	action_type)
VALUES (
	6,
	'2026-05-28 11:00',
	'2026-05-28 12:00',
	'Oderburg CleanStation',
	197550,'wash');

-- LOAD
INSERT INTO trip_events (
	trip_id, 
	arrival_timestamp, 
	departure_timestamp, 
	location, 
	odometer, 
	action_type)
VALUES (
	6,
	'2026-05-28 12:20',
	'2026-05-28 14:00',
	'Oderburg Grainport',
	197560,
	'load');

-- UNLOAD
INSERT INTO trip_events (
	trip_id, 
	arrival_timestamp, 
	departure_timestamp, 
	location, 
	odometer, 
	action_type)
VALUES (
	6,
	'2026-06-01 07:00',
	'2026-06-01 10:10',
	'Ostvik Confectionery',
	198281,
	'unload');

-- WASH
INSERT INTO trip_events (
	trip_id, 
	arrival_timestamp, 
	departure_timestamp, 
	location, 
	odometer, 
	action_type)
VALUES (
	6,
	'2026-06-01 11:50',
	'2026-06-01 13:10',
	'Markvej TankClean',
	198374,
	'wash');

-- LOAD
INSERT INTO trip_events (
	trip_id, 
	arrival_timestamp, 
	departure_timestamp, 
	location, 
	odometer, 
	action_type)
VALUES (
	6,
	'2026-06-01 13:50',
	'2026-06-01 15:10',
	'Fjordby BioFarm',
	198400,
	'load');

-- UNLOAD
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
	departure_timestamp,
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-03 06:50',
	'2026-06-03 09:30',
	'Schwarztal Dairy',
	199536,
	'unload'
);

-- WASH
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
	departure_timestamp,
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-03 15:50',
	'2026-06-03 17:30',
	'Rheinburg TankService',
	199618,
	'wash'
);

-- LOAD
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
	departure_timestamp,
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-04 10:00',
	'2026-06-04 12:00',
	'Eifelmark Dairy',
	199907,
	'load'
);

-- UNLOAD
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
	departure_timestamp,
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-05 13:40',
	'2026-06-05 15:00',
	'Vestfjord Dairy Central',
	200847,
	'unload'
);

-- WASH
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
	departure_timestamp,
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-08 14:30',
	'2026-06-08 15:30',
	'Westkust OilTerminal',
	201335,
	'wash'
);

-- LOAD
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
	departure_timestamp,
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-08 15:30',
	'2026-06-08 16:30',
	'Westkust OilTerminal',
	201337,
	'load'
);

-- UNLOAD
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
	departure_timestamp,
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-09 16:20',
	'2026-06-09 17:20',
	'Nordfjord Bakery',
	201894,
	'unload'
);

-- WASH
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
	departure_timestamp,
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-10 09:50',
	'2026-06-10 12:30',
	'Grenzmark AutoService',
	202226,
	'wash'
);

-- LOAD
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
	departure_timestamp,
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-10 14:00',
	'2026-06-10 16:40',
	'Flensby Creamery',
	202296,
	'load'
);

-- UNLOAD
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
	departure_timestamp,
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-11 11:10',
	'2026-06-11 12:40',
	'Westmark FoodIndustry',
	202698,
	'unload'
);

-- WASH
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
	departure_timestamp,
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-11 17:00',
	'2026-06-11 18:30',
	'Rheintal TankWash',
	202914,
	'wash'
);

-- LOAD
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
	departure_timestamp,
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-12 09:00',
	'2026-06-12 11:50',
	'Niederrhein Grainport',
	202942,
	'load'
);

-- FINISH
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,	
	location,
	odometer,
	action_type
)
VALUES (
	6,
	'2026-06-12 22:00',
	'Grenzstadt Depot',
	203531,
	'finish'
);

SELECT *
FROM trip_events te 
WHERE trip_id = 6;
