INSERT INTO booking_events (

booking_id,
event_type,
payload

)

VALUES (

'99b90625-0ee1-4806-95ff-d6401fc86627',
'BOOKING_CREA2026-07-07 08:20:46.158175',
'{"source":"website","payment":"completed"}'

);

-- seed
INSERT INTO booking_events(
    booking_id,
    event_type,
    payload,
    created_at
)
SELECT
    id,
    'BOOKING_CREATED',
    jsonb_build_object(
        'source','website',
        'payment','completed'
    ),
    created_at
FROM hotel_bookings
LIMIT 60;