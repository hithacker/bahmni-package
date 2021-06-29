#!/bin/sh
set -e -x

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

sh ./initDB.sh
run_migrations