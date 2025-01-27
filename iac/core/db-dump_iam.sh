cd /run-env/db-dump
NOW=$(date +"%Y-%m-%d-%H-%M-%S")
FILENAME=db_dump_iam_${NOW}.sql.gz
echo "Dumping into ${FILENAME}"
docker exec iam-db pg_dump -h localhost -U keycloak keycloak | gzip -9  > $FILENAME
echo "Done"