

```sql
-- nmqv3
CREATE DATABASE nmqv3;
CREATE USER nmqv3_admin password '';
GRANT ALL ON DATABASE nmqv3 TO nmqv3_admin;

-- nmqv3 dashboard
CREATE DATABASE nmqv3_dashboard;
CREATE USER nmqv3_dashboard_admin password '';
GRANT ALL ON DATABASE nmqv3_dashboard TO nmqv3_dashboard_admin;


---- CREATE Role ----
DROP ROLE nine1paymentdbuser;
CREATE ROLE nine1paymentdbuser LOGIN PASSWORD 'xxxxxxxxxxx';
GRANT USAGE ON SCHEMA dbo TO nine1paymentdbuser;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON ALL TABLES IN SCHEMA "dbo" TO nine1paymentdbuser;
GRANT SELECT, USAGE ON ALL SEQUENCE IN SCHEMA "dbo" TO nine1paymentdbuser;
```