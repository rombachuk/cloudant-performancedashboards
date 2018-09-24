# Installing the performance dashboards

The performancedashboards are dependent on:  

* performancecollector collectors
* postgres schema
* grafana server installation 

These components are all installed as part of the performancecollector installation.

Some additional views are required for these dashboards.  
These are added to the postgres schema and used to speed up the dashboard responsiveness. 
  
Installing the dashboards requires: 
  
* create or replace of views in postgres  
* installing or updating dashboards via grafana web application


## Additional Views for dashboard

These can be conveniently loaded from one of the load-balancers, since psql postgres client is in place.


### Collecting software from Github

cloudant-metricsleaner is released via github. Use a github client to download the release level required.

The github repository is 
`https://github.com/rombachuk/cloudant-performancedashboards`

The releases option in Github shows the available releases.
Download from the site in either tar.gz or zip format, and place in a suitable directory:  

*  as `root` on the load-balancer eg `/root/software`
*  as any user on your client PC or mac which you access Grafana desktop app

### 	Unpacking 
Unpack the software with `tar xvf` or `unzip`, depending on the download format from github.  

On pcs or macs local unpacking apps can be used.

The software unpacks to the following directories :  
  
  * grafana-dashboards (the software to be installed)
  * documentation (markdown files documenting the package)

#### Example

Software release 27.0.2 is downloaded to server cl11c74lb1 directory  `/root/software/cloudant-performancedashboards-27.0.2.tar.gz` and unpacked with tar as  
  
  
```  
[root@cl11c74lb1 cloudant-performancedashboards-27.0.2]# pwd
/root/software/cloudant-performancedashboards-27.0.2
[root@cl11c74lb1 cloudant-performancedashboards-27.0.2]# ls -l
total 4
drwxrwxr-x 2 root root 275 Aug 29 17:44 grafana-dashboards
drwxrwxr-x 2 root root 280 Aug 29 17:44 documentation
-rw-rw-r-- 1 root root  83 Aug 29 17:44 README.md
```    

### Load Views
Go to directory `grafana-dashboards` as `root` and type:

`$ psql -U cloudant -d postgres -h postgreshost -f volumestatus_views_create.sql`

## Load dashboards into Grafana

From the client PC, login to Grafana as `admin` and import the dashboards using the `Import Dashboard` icon after clicking on Find Dashboard option.

It will replace any existing dashboard of the same name.   
You can save any existing dashboard to another name using the Grafana Save As option


