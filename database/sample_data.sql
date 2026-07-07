INSERT INTO hotel_bookings (
    org_id,
    hotel_id,
    city,
    checkin_date,
    checkout_date,
    amount,
    status
)
VALUES (
    uuid_generate_v4(),
    'HOTEL101',
    'Hyderabad',
    '2026-08-01',
    '2026-08-03',
    6500.00,
    'CONFIRMED'
);

INSERT INTO hotel_bookings (
    org_id,
    hotel_id,
    city,
    checkin_date,
    checkout_date,
    amount,
    status
)
VALUES (
    uuid_generate_v4(),
    'HOTEL205',
    'Bangalore',
    '2026-08-10',
    '2026-08-12',
    8500.00,
    'CONFIRMED'
);