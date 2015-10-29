#!/bin/sh

recov=`sudo -u postgres psql -t -c "SELECT pg_is_in_recovery();"`

case $1 in config)
	if [ `echo $recov` = "t" ]; then
		cat <<'EOM'
graph_title Replication Lag
graph_vlabel seconds
lag.label lag
lag.warning 3:4
lag.critical 5:
EOM
    else
    	cat <<'EOM'
graph_title Replication Targets
graph_vlabel targets
targets.label numTargets
targets.warning 1:1
targets.critical :0
EOM
    fi
    exit 0;;
esac

if [ `echo $recov` = "t" ]; then
	lagseconds=`sudo -u postgres psql -t -c "SELECT CASE WHEN pg_last_xlog_receive_location() = pg_last_xlog_replay_location() THEN 0 ELSE EXTRACT (EPOCH FROM now() - pg_last_xact_replay_timestamp()) END AS log_delay;"`
	echo 'lag.value '$lagseconds
else
	backendcount=`sudo -u postgres psql -t -c "select count(*) from pg_stat_replication where state='streaming';"`
	echo 'targets.value '$backendcount
fi