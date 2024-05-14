-- CREATE REPLICATION

CREATE PUBLICATION send_data_to_bq FOR ALL TABLES;

alter user budi with replication;

SELECT PG_CREATE_LOGICAL_REPLICATION_SLOT
('weekly5_replication', 'pgoutput');


--SEND DATA
CREATE USER budi_datastream WITH REPLICATION IN ROLE
cloudsqlsuperuser LOGIN PASSWORD 'budi_datastream';

GRANT SELECT ON ALL TABLES IN SCHEMA public TO budi_datastream;
GRANT USAGE ON SCHEMA public TO budi_datastream;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO budi_datastream;