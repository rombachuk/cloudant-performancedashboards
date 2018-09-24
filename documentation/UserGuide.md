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