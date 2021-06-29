#!/bin/sh
set -e -x

run_migrations(){
    echo "Running liquibase migrations"
    sh run-liquibase.sh $1 $2 $3 $4 $5
}

. /etc/bahmni-reports/bahmni-reports.conf
if [ -f /etc/bahmni-installer/bahmni.conf ]; then
. /etc/bahmni-installer/bahmni.conf
fi

mysql -h $REPORTS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $REPORTS_DB_NAME;"
mysql -h $REPORTS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $REPORTS_DB_NAME.* TO '$REPORTS_DB_USERNAME'@'$REPORTS_DB_SERVER' identified by '$REPORTS_DB_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"

run_migrations liquibase.xml $OPENMRS_DB_SERVER $OPENMRS_DB_NAME $OPENMRS_DB_USERNAME $OPENMRS_DB_PASSWORD
run_migrations liquibase_bahmni_reports.xml $REPORTS_DB_SERVER $REPORTS_DB_NAME $REPORTS_DB_USERNAME $REPORTS_DB_PASSWORD