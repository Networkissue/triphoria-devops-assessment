# Database Optimization

The following indexes were created:

### 1. idx_hotel_bookings_city_created_at

```sql
CREATE INDEX idx_hotel_bookings_city_created_at
ON hotel_bookings(city, created_at);
```

This composite index optimizes the WHERE clause by allowing PostgreSQL to quickly locate rows that match a specific city and recent creation date, reducing the number of rows scanned.

### 2. idx_hotel_bookings_org_status

```sql
CREATE INDEX idx_hotel_bookings_org_status
ON hotel_bookings(org_id, status);
```

This index helps the GROUP BY operation by improving access to rows grouped by organization and booking status.

These indexes reduce full table scans and improve query performance as the dataset grows.