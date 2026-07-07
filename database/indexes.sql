CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE hotel_bookings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    org_id UUID NOT NULL,

    hotel_id VARCHAR(100) NOT NULL,

    city VARCHAR(100) NOT NULL,

    checkin_date DATE NOT NULL,

    checkout_date DATE NOT NULL,

    amount NUMERIC(50) NOT NULL,

    status VARCHAR(50) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE booking_events (
    id BIGSERIAL PRIMARY KEY,

    booking_id UUID NOT NULL REFERENCES hotel_bookings(id),

    event_type VARCHAR(100) NOT NULL,

    payload JSONB,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- seed
CREATE INDEX idx_hotel_bookings_city_created_at
ON hotel_bookings(city, created_at);

CREATE INDEX idx_hotel_bookings_org_status
ON hotel_bookings(org_id, status);