# How do I track OCPU usage in an auto-scalable autonomous database?
Duration: 5 minutes

You have enabled auto scaling in your autonomous database. You want to track the instances when the auto scaling kicked in and added OCPU's for the load.

## Tracking OCPU usage 

The Overview and Activity tabs in the Service Console provide information about the performance of an Autonomous Database.
* Open the Oracle Cloud Infrastructure Console by clicking the navigation icon next to Oracle Cloud.
* From the Oracle Cloud Infrastructure left navigation menu click **Oracle Database** and then, depending on your workload click one of: Autonomous Data Warehouse, Autonomous JSON Database, or Autonomous Transaction Processing.
* From the Autonomous Databases list, under Display Name, select an Autonomous Database. From the Autonomous Database Details page click **Service Console**.
* In the Overview page, there is a graph for number of OCPUs allocated.  For databases with auto scaling enabled, for each hour the chart shows the average number of OCPUs used during that hour if that value is higher than the number of OCPUs provisioned. If the number of OCPUs used is not higher than the number of OCPUs provisioned, then the chart shows the number of OCPUs allocated for that hour.
* Click **Show details** for more information, including the number of OCPUs allocated to the database and to external resources, and the total allocated OCPUs.

**Note:** For databases with auto scaling disabled, for each hour the chart shows the number of OCPUs allocated to the database if the database is open for at least some part of the hour.

## Learn More
[Monitor the performance of Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/monitor-performance-intro.html#GUID-54CCC1C6-C32E-47F4-8EB6-64CD6EDB5938)
