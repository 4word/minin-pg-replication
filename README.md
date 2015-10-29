# Setup

Download replication.sh and put it in your munin plugins directory on your servers. Make sure the account munin is using to monitor can sudo as postgres. Thats it, your graph should populate within 10 minutes.

# Graphs
Master DB graph: Replication Targets<br />
Slave DB graph: Replication Lag

# Default warning/critical levels:
Replication lag warning: 3s<br />
Replication lag critical: 5s<br />
Replication targets warning: 1<br />
Replication targets critical: 0<br />
&nbsp;&nbsp;&nbsp;&nbsp;Adjust these yourself to match your use case, I use them for on-site secondary and off-site tertiary monitoring as-is.
