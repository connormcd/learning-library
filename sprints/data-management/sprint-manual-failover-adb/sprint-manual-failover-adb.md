# How can I manually failover to a standby database?
Duration: 10 minutes

When Autonomous Data Guard cannot automatically fail over to a local Standby database, if a local Standby database is available you can perform a manual failover to make the local Standby database the Primary database. If a cross-region Standby is available, you can perform a switchover to make the cross-region Standby database the Primary database and if the switchover fails, you can initiate a manual failover to the cross-region Standby. It is possible for data loss to occur with a manual failover.

When you initiate a manual failover Autonomous Data Guard fails over to the Standby database based on the Recovery Time Objective (RTO) and Recovery Point Objective (RPO) targets.

## Add a Standby Database

Perform the following prerequisite steps as necessary:
* Open the navigation menu. Click **Oracle Database**. Under Autonomous Database, click Autonomous Data Warehouse, Autonomous JSON Database, or Autonomous Transaction Processing depending on your workload.
* Choose your **Compartment**.
* In the list of Autonomous Databases, click the display name of the database you want to administer.

**To initiate a manual failover to a cross-region Standby, do the following:**

1. On the Standby database, perform a switchover.
2. If the switchover attempt in Step 1 fails, on the Standby database the **Role** field shows a **Failover** link. On the Standby database, click the **Failover** link.

This shows the **Confirm Manual Failover to Standby** dialog, along with information on possible data loss that may result if you perform the manual failover to the Standby database.

3. In the **Confirm Manual Failover to Standby** dialog, enter the Autonomous Database name to confirm that you want to failover.
4. In the **Confirm Manual Failover to Standby** dialog, click **Confirm Manual Failover to Standby**.

When concurrent operations such as scaling or creating a manual backup are active, the confirmation also confirms either pausing or canceling the concurrent operation.

**To initiate a manual failover when the Primary database is unavailable and the local Standby is available, do the following:**

1. On the **Details** page, under Autonomous Data Guard, in the **Role** field, click **Failover**.

This shows the Confirm Manual Failover to Standby dialog, along with information on possible data loss that may result if you perform the manual failover to standby.

2. In the **Confirm Manual Failover to Standby** dialog, enter the Autonomous Database name to confirm that you want to failover.
3. In the **Confirm Manual Failover to Standby** dialog, click **Confirm Manual Failover to Standby**.

## Learn More
* [Autonomous Data Guard with Cross-Region Standby] (https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/autonomous-data-guard-failover.html#GUID-9FE2DCBA-A6EB-41D0-9E99-6EA3145BE9B9)
* [Autonomous Data Guard Recovery Time Objective (RTO) and Recovery Point Objective (RPO)] (https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/autonomous-data-guard-about.html#GUID-AF736587-4F6D-45C3-9886-7211B0A33745)
* [Concurrent Operations on Autonomous Database] (https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/autonomous-concurrent-operations.html#GUID-9933CA2D-F413-4D31-AA59-E4DBA7CB12E1)
