CREATE OR REPLACE VIEW logistic.vw_trip_analysis AS
SELECT te.event_id,
    te.trip_id,
    row_number() OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS event_sequence,
    date(te.arrival_timestamp) AS event_date,
    date_trunc('week'::text, te.arrival_timestamp)::date AS week_start,
    date_trunc('month'::text, te.arrival_timestamp)::date AS month_start,
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
    round(EXTRACT(epoch FROM te.departure_timestamp - te.arrival_timestamp) / 3600::numeric, 2) AS stop_duration_hours,
    lag(te.location) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS previous_location,
    lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS previous_action,
    lag(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS previous_odometer,
    lag(te.departure_timestamp) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS previous_departure_timestamp,
    lead(te.location) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS next_location,
    lead(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS next_action,
    lead(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS next_odometer,
    lead(te.arrival_timestamp) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS next_arrival_timestamp,
    te.odometer - lag(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) AS km_from_previous_event,
    lead(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) - te.odometer AS km_to_next_event,
    round(EXTRACT(epoch FROM te.arrival_timestamp - lag(te.departure_timestamp) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)) / 3600::numeric, 2) AS time_from_previous_event_hours,
    round(EXTRACT(epoch FROM lead(te.arrival_timestamp) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) - te.departure_timestamp) / 3600::numeric, 2) AS time_to_next_event_hours,
    concat(lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp), ' → ', te.action_type) AS previous_current_flow,
    concat(te.action_type, ' → ', lead(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)) AS current_next_flow,
    concat(lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp), ' → ', te.action_type, ' → ', lead(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)) AS full_operational_cycle,
        CASE
            WHEN te.action_type::text = ANY (ARRAY['load'::character varying, 'unload'::character varying]::text[]) THEN 'loaded'::text
            WHEN te.action_type::text = 'wash'::text THEN 'service'::text
            ELSE 'empty'::text
        END AS operation_category,
        CASE
            WHEN te.action_type::text = 'start'::text THEN 'trip_start'::text
            WHEN te.action_type::text = 'finish'::text THEN 'trip_finish'::text
            WHEN lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)::text = 'load'::text AND te.action_type::text = 'unload'::text THEN 'loaded_trip'::text
            WHEN lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp) IS NULL AND te.action_type::text = 'unload'::text THEN 'loaded_trip'::text
            WHEN lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)::text = 'start'::text AND te.action_type::text = 'unload'::text THEN 'loaded_trip'::text
            WHEN lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)::text = 'unload'::text AND te.action_type::text = 'wash'::text THEN 'unload_to_wash'::text
            WHEN lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)::text = 'wash'::text AND te.action_type::text = 'load'::text THEN 'wash_to_load'::text
            WHEN te.action_type::text = 'wash'::text THEN 'service_trip'::text
            ELSE 'empty_trip'::text
        END AS movement_type,
        CASE
            WHEN te.action_type::text = 'wash'::text AND (te.odometer - lag(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)) > 150 THEN 'long_distance_to_wash'::text
            ELSE 'normal'::text
        END AS wash_efficiency_flag,
        CASE
            WHEN lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)::text = 'unload'::text AND te.action_type::text = 'wash'::text THEN te.odometer - lag(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)
            ELSE NULL::integer
        END AS km_unload_to_wash,
        CASE
            WHEN lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)::text = 'wash'::text AND te.action_type::text = 'load'::text THEN te.odometer - lag(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)
            ELSE NULL::integer
        END AS km_wash_to_load,
        CASE
            WHEN lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)::text = 'unload'::text AND te.action_type::text = 'wash'::text THEN round(EXTRACT(epoch FROM te.arrival_timestamp - lag(te.departure_timestamp) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)) / 3600::numeric, 2)
            ELSE NULL::numeric
        END AS time_unload_to_wash_hours,
        CASE
            WHEN lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)::text = 'load'::text AND te.action_type::text = 'unload'::text THEN te.odometer - lag(te.odometer) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)
            ELSE NULL::integer
        END AS km_load_to_unload,
        CASE
            WHEN lag(te.action_type) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)::text = 'wash'::text AND te.action_type::text = 'load'::text THEN round(EXTRACT(epoch FROM te.arrival_timestamp - lag(te.departure_timestamp) OVER (PARTITION BY tr.truck_id ORDER BY te.arrival_timestamp)) / 3600::numeric, 2)
            ELSE NULL::numeric
        END AS time_wash_to_load_hours
FROM logistic.trip_events te
JOIN logistic.trips t ON te.trip_id = t.trip_id
JOIN logistic.trucks tr ON t.truck_id = tr.truck_id
JOIN logistic.drivers d ON t.driver_id = d.driver_id
LEFT JOIN logistic.trailers tl ON t.trailer_id = tl.trailer_id;	 


