if [ -f /etc/bahmni-installer/bahmni.conf ]; then
. /etc/bahmni-installer/bahmni.conf
fi

createdb -Upostgres -h$OPENELIS_DB_SERVER $OPENELIS_DB_NAME;
psql -Uclinlims -h$OPENELIS_DB_SERVER $OPENELIS_DB_NAME < /opt/bahmni-lab/db-dump/openelis_demo_dump.sql
