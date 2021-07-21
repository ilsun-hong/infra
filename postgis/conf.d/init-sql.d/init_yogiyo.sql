-- Init yogyo --
DROP DATABASE IF EXISTS yogyo;
CREATE DATABASE yogyo ENCODING 'UTF8';

-- Init template_postgis --
\c postgres postgres
UPDATE pg_database SET datistemplate='false' WHERE datname='template_postgis';

DROP DATABASE IF EXISTS template_postgis;
CREATE DATABASE template_postgis ENCODING 'UTF8';

-- Grant
GRANT ALL PRIVILEGES ON DATABASE yogyo TO postgres;

UPDATE pg_language SET lanpltrusted = true WHERE lanname LIKE 'c';
