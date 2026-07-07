# Triphoria DevOps Assessment

## Overview

This project demonstrates Infrastructure as Code (Terraform), Dockerized PostgreSQL database management, data seeding, query optimization, and database backup/restore automation.

## Project Structure

```text
triphoria-devops-assessment/
│
├── infra/
│   ├── modules/
│   │   ├── network/
│   │   ├── ecs/
│   │   └── rds/
│   └── envs/
│       ├── dev/
│       └── prod/
│
├── database/
│   ├── docker-compose.yml
│   ├── indexes.sql
│   ├── seed.sql
│
├── scripts/
│   ├── backup.sh
│   └── restore.sh
│
├── backups/
│
└── README.md
```

---

# Prerequisites

- Terraform >= 1.5
- Docker Desktop
- Docker Compose
- Git
- PostgreSQL 16 (Docker image)

---

# Infrastructure

Terraform is organized using reusable modules.

### Modules

- Network
  - VPC
  - Public Subnets
  - Private Subnets
  - Internet Gateway
  - Route Tables

- ECS
  - ECS Cluster
  - Fargate Service
  - Task Definition

- RDS
  - PostgreSQL Database
  - DB Subnet Group
  - Security Groups

Separate configurations are maintained for:

- Development
- Production

---

# Start PostgreSQL

Navigate to the database directory.

```bash
cd database
docker compose up -d
```

Verify the container.

```bash
docker ps
```

---

# Database Schema

The following tables are created automatically.

## hotel_bookings

- id (UUID)
- org_id (UUID)
- hotel_id
- city
- checkin_date
- checkout_date
- amount
- status
- created_at

## booking_events

- id
- booking_id
- event_type
- payload
- created_at

---

# Seed Data

The seed script generates:

- 100 hotel bookings
- Multiple organizations
- Multiple hotels
- Multiple cities
- Multiple booking statuses
- Booking events for sample bookings

Execute:

```bash
docker exec -i triphoria-postgres \
psql -U admin -d triphoria < seed.sql
```

---

# Query Optimization

Optimized query:

```sql
SELECT
    org_id,
    status,
    COUNT(*),
    SUM(amount)
FROM hotel_bookings
WHERE city='delhi'
AND created_at>=NOW()-INTERVAL '30 days'
GROUP BY org_id,status;
```

## Index Created

```sql
CREATE INDEX idx_hotel_bookings_city_created_at
ON hotel_bookings(city, created_at);
```

### Why this index?

The query filters records using:

- city
- created_at

A composite index on these columns significantly reduces table scans and allows PostgreSQL to retrieve matching rows efficiently before performing the aggregation.

---

# Backup

Run:

```bash
cd scripts

./backup.sh
```

A timestamped PostgreSQL dump is created inside the `backups/` directory.

Example:

```text
backups/triphoria_20260707_170530.dump
```

---

# Restore

Restore the latest backup:

```bash
cd scripts

./restore.sh
```

Or restore a specific backup:

```bash
./restore.sh ../backups/triphoria_20260707_170530.dump
```

---

# Verify Restore

Connect to PostgreSQL.

```bash
docker exec -it triphoria-postgres psql -U admin -d triphoria
```

Verify the tables:

```sql
SELECT COUNT(*) FROM hotel_bookings;

SELECT COUNT(*) FROM booking_events;
```

The restore is considered successful if:

- Both tables exist.
- Record counts match the original backup.
- Sample data is available.

---

# Technologies Used

- Terraform
- AWS
- Docker
- Docker Compose
- PostgreSQL 16
- Git
- Bash

---

# Assumptions

- PostgreSQL runs inside a Docker container named `triphoria-postgres`.
- Terraform state is configured separately for each environment.
- Backup files are stored under the `backups/` directory.
- The scripts are intended to be run in a POSIX-compatible shell (Linux, macOS, or Git Bash/WSL on Windows).

---

# Author

**Rohith Vaddepally**

DevOps Engineer
