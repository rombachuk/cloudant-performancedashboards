# Performance Dashboards User Guide

The performance dashboards are supported by the various collectors that the cloudant-performancecollector provides.

Volume dashboards are dependent on data collected at daily intervals whereas the others are dependent on per-minute data.

For each dashboard, this guide provides : 

* sample screenshot
* some use cases
* dependent collectors
* dependent schema

##	Cluster Overview by Project 

[byproject]: clusteroverviewbyproject.png

![byproject]

#### Options

This dashboard provides a per-minute plot of key metrics per REST verb selectable by :  

* cluster, all projects, all databases
* cluster, all projects, selected databases (one or more)
* cluster, selected projects (one or more), selected databases
* filters for minimum GET,PUT,POST,DELETE values can be used to ignore small cases

projects are defined as the characters before first '_' in database name

#### Use Cases

Overall cluster volumes from application clients per groups of database(s)- split by verb to indicate type of calls.   
POST to _find are **reads** and so this dashboard is not a reliable read/write split.   
Use `Endpoint Overview by Project` to get POST \_find and similar metrics (investigations only)

#### Dependencies

Dependent on the proxyagent collector at `verb` granularity.  
Dependent on the `verb_stats` table  
Uses the proxyagent `stats_exclusions` : commonly backup cluster clientips are filtered out by exclusions, so volumes from these clients are not included.

##	Endpoint Overview by Project 

[byendpoint]: endpointoverviewbyproject.png

![byendpoint]

#### Options

This dashboard provides a per-minute plot of key metrics per REST verb selectable by :  

* cluster, all projects, all databases, all endpoints
* cluster, all projects, all databases, selected endpoints (one or more)
* cluster, all projects, selected databases (one or more), selected endpoints
* cluster, selected projects (one or more), selected databases, selected endpoints
* filters for minimum GET,PUT,POST,DELETE values can be used to ignore small cases

projects are defined as the characters before first '_' in database name


#### Use Cases

Overall cluster volumes from application clients per groups of database-endpoint pairs split by verb to indicate type of calls.   
POST to _find are identified separately so this dashboard is a reliable read/write split display   
Use `Endpoint Overview by Project` to get POST \_find and similar metrics (investigations only)

#### Dependencies

Dependent on the proxyagent collector at `endpoint` granularity.  
Only recommended for short term investigative use. Data volumes can be too high otherwise.  
Dependent on the `endpoint_stats` table  
Uses the proxyagent `stats_exclusions` : commonly backup cluster clientips are filtered out by exclusions, so volumes from these clients are not included.

##	Cluster Overview by Client(ip) 

[byclient]: clusteroverviewbyclient.png

![byclient]

#### Options

This dashboard provides a per-minute plot of key metrics per REST verb selectable by :  

* cluster, all clients
* cluster, selected clients (one or more)  
* filters for minimum GET,PUT,POST,DELETE values can be used to ignore small cases

clients are identified by ip address, ports are ignored

#### Use Cases

Overall cluster volumes from REST clients - split by verb to indicate type of calls.    

Useful to see volumes based on the calling client - so you can split traffic by location of client or by function : application, backup, monitoring : depending on how clientips are allocated  

POST to _find are **reads** and so this dashboard is not a reliable read/write split.   


#### Dependencies

Dependent on the clientagent collector at `verb` granularity.  
Dependent on the `client_verb_stats` table  
Uses the clientagent `stats_exclusions` : determine behaviour and volume of replication and monitoring by not excluding ips for this collection

##	Compaction Overview 

[compaction]: compactionoverview.png

![compaction]

#### Options

This dashboard provides a mix of per-minute dbnode charts and per-day volume charts (per database). 

For volume-collector sourced charts :  

* cluster, all projects, all databases 
* cluster, all projects, selected databases
* cluster, selected project(s), selected database(s)

For matricsdbdata-collector sourced charts :  
* cluster, all dbnodes
* cluster, selected dbnodes

#### Use Cases

The Jobs waiting charts are the best indicator of overall volumes of compaction activity. The Jobs active charts relate solely to those compaction jobs actually running.   

When compaction is very active, the waiting queues can be become large or continually refill if the smoosh settings are not ideal. Consult IBM for help.

The volume charts are guide to dynamics of data build-up and likely demand for compaction.   


#### Dependencies

Dependent on the metricsdbagent collector .  
Dependent on the volume collector (usually per day)  
metricsdb collects all data and does not support exclusions - so effectively all clients volumes.

Dependent on the `smoosh_stats`, `ioq_stats`, `db_stats`,`smoosh_stats` tables

##	Volume Overview by Cluster

[volumebycluster]: volumeoverviewbycluster.png

![volumebycluster]

#### Options

This dashboard provides a mix of per-minute proxy-sourced, dbnode charts and per-day volume charts just for the whole cluster. 

The only selection option is the cluster

#### Use Cases

This is intended as a capture of all the key metrics at cluster level, which provide a health and growth picture.   

Daily trends at the cluster level should be readily apparent.

Changes from 'normal' should be readily apparent.

#### Dependencies

Dependent on the proxydata and clientdata collectors
Dependent on the metricsdbagent collector .  
Dependent on the volume collector (usually per day)  
metricsdb collects all data and does not support exclusions - so effectively all clients volumes.

Dependent on the `verb_stats`,`client_verb_stats`,`ioq_stats`, `db_stats` and `view_stats` tables

##	Volume Overview by Database

[volumebydatabase]: volumeoverviewbydatabase.png

![volumebydatabase]

#### Options

This dashboard provides a ranked topn distribution of cluster database volumes for a number of criteria using the volume data collector. Items ranked lower than n are lumped into an others item.  

n can be 10,20,50,100 (or can be easily any others using grafana)

The min database and view size can be used asa a threshold to ignore small sizes. Ranking includes this filter.

The data is derived from the latest data available and this timepoint is displayed on the chart in YYYYMMDDHH24MISS format.

#### Use Cases

This is intended as a means to identify the key databases which are occupying resources on the cluster.

Also invaluable in identifying the effectiveness of compaction.   

The dashboard `Volume Overview By Cluster` captures the time-dynamics of volume growth at the db level.

#### Dependencies
  
Dependent on the volume collector (usually per day)  

Dependent on the `db_stats` and `view_stats` tables

##	Volume Overview by View

[volumebyview]: volumeoverviewbyview.png

![volumebyview]

#### Options

This dashboard provides a ranked topn distribution of cluster mrview volumes for a number of criteria using the volume data collector. Items ranked lower than n are lumped into an others item.  

n can be 10,20,50,100 (or can be easily any others using grafana)

The min view size can be used asa a threshold to ignore small sizes. Ranking includes this filter.

The data is derived from the latest data available and this timepoint is displayed on the chart in YYYYMMDDHH24MISS format.

#### Use Cases

This is intended as a means to identify the key views which are occupying resources on the cluster, and provides ranking of views independent of owning databases.

Also invaluable in identifying the effectiveness of compaction.   

#### Dependencies
  
Dependent on the volume collector (usually per day)  

Dependent on the `view_stats` tables


##	Volume Status by Project Phase

[volumebyprojectphase]: volumestatusbyprojectphase.png

![volumebyprojectphase]

#### Options

This dashboard provides a ranked distribution of databases of a given context of cluster,project,phase where:   

* project is usually a client application using the cluster
* phase is a milestone marker such as 'dev'.  

n can be 10,20,50,100 (or can be easily any others using grafana)

Options can be :  

* cluster,project,phase and all databases owned
* cluster,project,phase and selected databases owned
* the view details apply to the databases selected

The min data and min view size can be used asa a threshold to ignore small sizes. Ranking includes this filter.

The data is derived from the latest data available and this timepoint is displayed on the chart in YYYYMMDDHH24MISS format.


#### Use Cases

The dashboard is designed for detailed exploration of the volume collector data. Drilldown to view details for one or more databases owned by the project-phase is possible. 

Also invaluable in identifying the effectiveness of compaction, and provides shard counts, slack and ratio calculations   

#### Dependencies
  
Dependent on the volume collector (usually per day)  

Dependent on the `db_project_phase_stats` and`view_project_phase_stats` views, which sits above db_stats and view_stats, and provides pre-calculated project & phase extraction logic from dbnames.  
The default view definitions are contained in the script `volumestatus_views_create.sql` provided in the release. It assumes dbs are named with the `projname_phasename_dbname` convention.  
Other naming strategies or lookup table joins can be used, but the view must be changed.