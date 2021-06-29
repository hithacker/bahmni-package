#!/bin/sh

if [ -f /etc/bahmni-installer/bahmni.conf ]; then
. /etc/bahmni-installer/bahmni.conf
fi

. /etc/openmrs/openmrs.conf
. /etc/openmrs/bahmni-emr.conf

run_migrations() {
    echo "Running openmrs liquibase-core-data.xml and liquibase-update-to-latest.xml"
    /opt/openmrs/etc/run-liquibase.sh liquibase-core-data.xml
    /opt/openmrs/etc/run-liquibase.sh liquibase-update-to-latest.xml
}

RESULT=`mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD --skip-column-names -e "SHOW DATABASES LIKE '$OPENMRS_DB_NAME'"`
if [ "$RESULT" != "$OPENMRS_DB_NAME" ] ; then
  mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $OPENMRS_DB_NAME;"
  if [ "${IMPLEMENTATION_NAME:-default}" = "default" ]; then
    echo "$OPENMRS_DB_NAME database not found... Restoring a base dump suitable to work with default config"
    mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD $OPENMRS_DB_NAME < openmrs_demo_dump.sql
  else
    echo "clean $OPENMRS_DB_NAME database will be created with no demo data"
    mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD  < openmrs_clean_dump.sql
  fi
fi

run_migrations