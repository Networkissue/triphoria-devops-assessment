INSERT INTO hotel_bookings (
    id,
    org_id,
    hotel_id,
    city,
    checkin_date,
    checkout_date,
    amount,
    status,
    created_at
)
SELECT
    uuid_generate_v4(),
    uuid_generate_v4(),
    'HOTEL-' || (random()*20)::int,
    (
        ARRAY[
            'delhi',
            'hyderabad',
            'bangalore',
            'mumbai',
            'chennai',
            'pune'
        ]
    )[floor(random()*6+1)],
    CURRENT_DATE + ((random()*20)::int),
    CURRENT_DATE + ((random()*25)::int),
    ROUND((1000 + random()*9000)::numeric,2),
    (
        ARRAY[
            'CONFIRMED',
            'CANCELLED',
            'PENDING',
            'COMPLETED'
        ]
    )[floor(random()*4+1)],
    NOW() - (random()*30 || ' days')::interval
FROM generate_series(1,100);