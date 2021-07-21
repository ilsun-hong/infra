-- Change to yogyo database
\c yogyo postgres

-- Add extentions
DROP EXTENSION IF EXISTS postgis CASCADE;
DROP EXTENSION IF EXISTS fuzzystrmatch CASCADE;

CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
CREATE EXTENSION fuzzystrmatch;
CREATE EXTENSION postgis_tiger_geocoder;

-- change template_postgis database to template
\c postgres postgres
UPDATE pg_database SET datistemplate='true' WHERE datname='template_postgis';

\c template_postgis postgres

GRANT ALL ON geometry_columns TO PUBLIC;
GRANT ALL ON geography_columns TO PUBLIC;
GRANT ALL ON spatial_ref_sys TO PUBLIC;
