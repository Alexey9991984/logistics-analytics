-- =============================================
-- TRIP: MARCH 22 – APRIL 3, 2026
-- Driver 1, Truck 2 (LKW 4MN2)
-- Trailer swap: TA2302 -> TA2303
-- =============================================

-- TRIP 1: TA2302 (trailer_id = 4)
INSERT INTO trips (driver_id, truck_id, trailer_id, start_date, end_date)
VALUES (1, 2, 4, '2026-03-22', '2026-03-26');
-- trip_id = 2

-- TRIP 2: TA2303 (trailer_id = 3)
INSERT INTO trips (driver_id, truck_id, trailer_id, start_date, end_date)
VALUES (1, 2, 3, '2026-03-26', '2026-04-03');
-- trip_id = 6

-- DRIVER ASSIGNMENTS
INSERT INTO truck_driver_assignments (truck_id, driver_id, start_timestamp, end_timestamp)
VALUES (2, 1, '2026-03-22 05:00', '2026-04-03 13:00');

-- TRAILER ASSIGNMENTS
INSERT INTO truck_trailer_assignments (truck_id, trailer_id, start_timestamp, end_timestamp)
VALUES (2, 4, '2026-03-22 05:00', '2026-03-26 10:10');  -- TA2302

INSERT INTO truck_trailer_assignments (truck_id, trailer_id, start_timestamp, end_timestamp)
VALUES (2, 3, '2026-03-26 10:10', '2026-04-03 13:00');  -- TA2303


-- =============================================
-- EVENTS: TRIP 2 (TA2302, trip_id = 3)
-- =============================================
INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (3, '2026-03-22 17:40', '2026-03-23 05:00', 'Grenzstadt Depot', 345026, 'start');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (3, '2026-03-23 07:50', '2026-03-23 09:20', 'Nordhafen Grainport', 345218, 'load');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (3, '2026-03-23 14:10', '2026-03-23 17:00', 'Elbestadt Malting', 345437, 'unload');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (3, '2026-03-23 18:30', '2026-03-24 07:30', 'Mittelburg TankClean', 345550, 'wash');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (3, '2026-03-24 08:20', '2026-03-24 11:40', 'Westfeld Grains', 345602, 'load');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (3, '2026-03-25 09:30', '2026-03-25 10:20', 'Ostvik Brewery', 346045, 'unload');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (3, '2026-03-25 11:30', '2026-03-25 13:40', 'Skovby Tankvask', 346083, 'wash');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (3, '2026-03-25 15:30', '2026-03-25 17:20', 'Sodersjon SugarWorks', 346192, 'load');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (3, '2026-03-26 08:20', '2026-03-26 10:10', 'Nordbjerg Bakery', 346568, 'unload');

-- =============================================
-- EVENTS: TRIP 4 (TA2303, trip_id = 4)
-- =============================================
INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (4, '2026-03-26 18:00', '2026-03-26 19:20', 'Nordhafen Grainport', 346778, 'load');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (4, '2026-03-27 08:00', '2026-03-27 11:00', 'Elbestadt Malting', 346982, 'unload');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (4, '2026-03-27 14:50', '2026-03-30 06:30', 'Hafenrein TankService', 347217, 'wash');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (4, '2026-03-30 07:20', '2026-03-30 08:10', 'Ostport FuelStop', 347240, 'load');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (4, '2026-03-31 11:30', '2026-03-31 13:30', 'Vlaamstad Processing', 348155, 'unload');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (4, '2026-03-31 16:10', '2026-03-31 18:50', 'Kanalburg CleanTank', 348275, 'wash');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (4, '2026-03-31 18:00', '2026-04-01 13:20', 'Nordville StarChem', 348286, 'load');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (4, '2026-04-03 08:40', '2026-04-03 10:00', 'Fjordby BioFarm', 349455, 'unload');

INSERT INTO trip_events (trip_id, arrival_timestamp, departure_timestamp, location, odometer, action_type)
VALUES (4, '2026-04-03 13:30', '2026-04-03 14:00', 'Grenzstadt Depot', 349705, 'finish');


