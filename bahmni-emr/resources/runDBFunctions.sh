#!/bin/sh

if [ -f /etc/bahmni-installer/bahmni.conf ]; then
. /etc/bahmni-installer/bahmni.conf
fi

. /etc/openmrs/openmrs.conf
. /etc/openmrs/bahmni-emr.conf

run_migrations() {
    echo "Running openmrs liquibase-core-data.xml and liquibase-update-to-latest.xml"
    ./run-liquibase.sh liquibase-core-data.xml
    ./run-liquibase.sh liquibase-update-to-latest.xml
}

#mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $OPENMRS_DB_NAME;"
#mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD $OPENMRS_DB_NAME < openmrs_demo_dump.sql

run_migrations