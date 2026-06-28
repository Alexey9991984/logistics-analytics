-- =============================================
-- TRIP: APRIL 12 – APRIL 24, 2026
-- Driver 1, Truck 1 (LKW 3BT7), Trailer 1 (TA2301)
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
	1,
	1,
	'2026-04-12',
	'2026-04-24'
);


--- driver and trailer assignment for the duration of the trip
INSERT INTO truck_driver_assignments (
    truck_id,
    driver_id,
    start_timestamp,
    end_timestamp
)
VALUES (
    1,
    1,
    '2026-04-12 18:10',
    '2026-04-24 20:00'
);

--- trailer assignment for the duration of the trip
INSERT INTO truck_trailer_assignments (
    truck_id,
    trailer_id,
    start_timestamp,
    end_timestamp
)
VALUES (
    1,
    1,
    '2026-04-12 18:10',
    '2026-04-24 20:00'
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
	5,
	'2026-04-12 18:10:00',
	'2026-04-13 06:10:00',
	'Grenzstadt Depot',
	 744783,
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
	5,
	'2026-04-13 10:10:00',
	'2026-04-13 11:20:00',
	'Nordfjord Bakery',
	 745075,
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
	5,
	'2026-04-14 07:40:00',
	'2026-04-14 08:50:00',
	'Nordhafen TankWash',
	 745560,
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
	5,
	'2026-04-14 09:00:00',
	'2026-04-14 16:40:00',
	'Nordhafen Grainport',
	 745564,
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
	5,
	'2026-04-15 11:40:00',
	'2026-04-15 16:20:00',
	'Kempenstad Foodworks',
	 746118,
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
	5,
	'2026-04-15 17:00:00',
	'2026-04-15 18:30:00',
	'Riverdal CleanTank',
	 746162,
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
	5,
	'2026-04-16 07:50:00',
	'2026-04-16 13:00:00',
	'Portdam OilTerminal',
	 746285,
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
	5,
	'2026-04-19 20:10:00',
	'2026-04-19 23:10:00',
	'Nordfjord Bakery',
	 747278,
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
	5,
	'2026-04-20 10:10:00',
	'2026-04-20 11:50:00',
	'Lynghavn Tankvask',
	 747406,
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
	5,
	'2026-04-20 12:40:00',
	'2026-04-20 14:40:00',
	'Hedemark Flavours',
	 747464,
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
	5,
	'2026-04-21 19:30:00',
	'2026-04-21 22:00:00',
	'Vistapol Snacks',
	 748566,
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
	5,
	'2026-04-22 14:40:00',
	'2026-04-22 17:00:00',
	'Oderburg CleanStation',
	 748980,
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
	5,
	'2026-04-22 17:40:00',
	'2026-04-23 11:40:00',
	'Oderburg Grainport',
	 748991,
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
	5,
	'2026-04-24 12:40:00',
	'2026-04-24 14:00:00',
	'Ostvik Confectionery',
	 749696,
	'unload'
);

-- FINISH
INSERT INTO trip_events (
	trip_id,
	arrival_timestamp,
    departure_timestamp,
    location,
	odometer,
	action_type
)
VALUES (
	5,
	'2026-04-24 20:00:00',
	'2026-04-25 07:00:00',
	'Grenzstadt Depot',
	 749966,
	'finish'
);

SELECT * 
FROM trip_events te ;
