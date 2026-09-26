CREATE OR REPLACE VIEW logistic.vw_trip_analysis3 AS
SELECT
    te.event_id,
    te.trip_id,
    ROW_NUMBER() OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS event_sequence,
    DATE(te.arrival_timestamp) AS event_date,
    DATE_TRUNC('week', te.arrival_timestamp)::date AS week_start,
    DATE_TRUNC('month', te.arrival_timestamp)::date AS month_start,
    t.start_date,
    t.end_date,
    tr.truck_id,
    tr.truck_number,
    d.driver_id,
    d.full_name AS driver_name,
    tl.trailer_id,
    tl.trailer_number,
    te.arrival_timestamp,
    te.departure_timestamp,
    te.location,
    te.action_type,
    te.odometer,
    te.notes,
    ROUND(EXTRACT(EPOCH FROM (te.departure_timestamp - te.arrival_timestamp)) / 3600, 2) AS stop_duration_hours,
    LAG(te.location) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS previous_location,
    LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS previous_action,
    LAG(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS previous_odometer,
    LAG(te.departure_timestamp) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS previous_departure_timestamp,
    LEAD(te.location) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS next_location,
    LEAD(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS next_action,
    LEAD(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS next_odometer,
    LEAD(te.arrival_timestamp) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS next_arrival_timestamp,
    te.odometer - LAG(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS km_from_previous_event,
    LEAD(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) - te.odometer AS km_to_next_event,
    ROUND(EXTRACT(EPOCH FROM (
        te.arrival_timestamp - LAG(te.departure_timestamp) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)
    )) / 3600, 2) AS time_from_previous_event_hours,
    ROUND(EXTRACT(EPOCH FROM (
        LEAD(te.arrival_timestamp) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) - te.departure_timestamp
    )) / 3600, 2) AS time_to_next_event_hours,
    CONCAT(
        LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp),
        ' → ', te.action_type
    ) AS previous_current_flow,
    CONCAT(
        te.action_type, ' → ',
        LEAD(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)
    ) AS current_next_flow,
    CONCAT(
        LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp),
        ' → ', te.action_type, ' → ',
        LEAD(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)
    ) AS full_operational_cycle,
    CASE
        WHEN te.action_type IN ('load', 'unload') THEN 'loaded'
        WHEN te.action_type = 'wash' THEN 'service'
        ELSE 'empty'
    END AS operation_category,
    CASE
        WHEN te.action_type = 'start' THEN 'trip_start'
        WHEN te.action_type = 'finish' THEN 'trip_finish'
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'load'
             AND te.action_type = 'unload' THEN 'loaded_trip'
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) IS NULL
             AND te.action_type = 'unload' THEN 'loaded_trip'
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'start'
             AND te.action_type = 'unload' THEN 'loaded_trip'
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'unload'
             AND te.action_type = 'wash' THEN 'unload_to_wash'
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'wash'
             AND te.action_type = 'load' THEN 'wash_to_load'
        WHEN te.action_type = 'wash' THEN 'service_trip'
        ELSE 'empty_trip'
    END AS movement_type,
    CASE
        WHEN te.action_type = 'wash'
             AND te.odometer - LAG(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) > 150
        THEN 'long_distance_to_wash'
        ELSE 'normal'
    END AS wash_efficiency_flag,
    CASE
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'unload'
             AND te.action_type = 'wash'
        THEN te.odometer - LAG(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)
        ELSE NULL
    END AS km_unload_to_wash,
    CASE
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'wash'
             AND te.action_type = 'load'
        THEN te.odometer - LAG(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)
        ELSE NULL
    END AS km_wash_to_load,
    CASE
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'unload'
             AND te.action_type = 'wash'
        THEN ROUND(EXTRACT(EPOCH FROM (
            te.arrival_timestamp - LAG(te.departure_timestamp) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)
        )) / 3600, 2)
        ELSE NULL
    END AS time_unload_to_wash_hours,
    CASE
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'load'
             AND te.action_type = 'unload'
        THEN te.odometer - LAG(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)
        ELSE NULL
    END AS km_load_to_unload,
    CASE
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'wash'
             AND te.action_type = 'load'
        THEN ROUND(EXTRACT(EPOCH FROM (
            te.arrival_timestamp - LAG(te.departure_timestamp) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)
        )) / 3600, 2)
        ELSE NULL
    END AS time_wash_to_load_hours,
    CASE
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'load'
             AND te.action_type IN ('unload', 'finish') THEN 'loaded'
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'start'
             AND te.action_type = 'unload' THEN 'loaded'
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'unload'
             AND te.action_type IN ('wash', 'load', 'finish') THEN 'empty'
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'wash'
             AND te.action_type = 'load' THEN 'empty'
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'start'
             AND te.action_type IN ('wash', 'load') THEN 'empty'
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) = 'finish'
             AND te.action_type = 'start' THEN 'boundary'
        WHEN LAG(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) IS NULL THEN 'boundary'
        ELSE 'check'
    END AS distance_category
FROM logistic.trip_events te
JOIN logistic.trips t ON te.trip_id = t.trip_id
JOIN logistic.trucks tr ON t.truck_id = tr.truck_id
JOIN logistic.drivers d ON t.driver_id = d.driver_id
LEFT JOIN logistic.trailers tl ON t.trailer_id = tl.trailer_id;


CREATE OR REPLACE VIEW logistic.vw_trip_analysis4 AS
SELECT
    *,
    CASE
        WHEN distance_category = 'loaded'
        THEN km_from_previous_event
        ELSE 0
    END AS loaded_km,
 CASE
        WHEN distance_category = 'empty'
        THEN km_from_previous_event
        ELSE 0
    END AS empty_km,
CASE
        WHEN distance_category <> 'empty' THEN NULL
        WHEN previous_action = 'unload' AND action_type = 'wash'
            THEN 'Unloading → Wash'
        WHEN previous_action = 'wash' AND action_type = 'load'
            THEN 'Wash → Loading'
        WHEN previous_action = 'unload' AND action_type = 'finish'
            THEN 'Unloading → Base'
        WHEN previous_action = 'start' AND action_type = 'wash'
            THEN 'Base → Wash'
        WHEN previous_action = 'start' AND action_type = 'load'
            THEN 'Base → Loading'
        WHEN previous_action = 'unload' AND action_type = 'load'
            THEN 'Unloading → Loading'
        ELSE 'Other Empty'
    END AS empty_route_type
FROM logistic.vw_trip_analysis3;

SELECT *
FROM logistic.vw_trip_analysis4
LIMIT 10;