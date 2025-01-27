docker exec -i dancer-db psql -h localhost -U dancer postgres << SQL
-- https://stackoverflow.com/questions/17449420/postgresql-unable-to-drop-database-because-of-some-auto-connections-to-db

REVOKE CONNECT ON DATABASE dancer FROM public;

SELECT pid, pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'dancer' AND pid <> pg_backend_pid();

drop database dancer;

create database dancer;

GRANT CONNECT ON DATABASE dancer TO public;

SQL


echo "Restoring from ${1}"

cat $1 | gunzip - | docker exec -i dancer-db psql dancer -h localhost -U dancer -b -f -
echo "Done"
