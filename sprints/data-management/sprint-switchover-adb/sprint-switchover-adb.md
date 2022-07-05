# How can I switchover to a standby database?
Duration: 5 minutes

When you perform a switchover the primary database becomes the standby database, and the standby database becomes the primary database, with no data loss. A switchover is typically done to test failover to the standby database for audit or certification reasons, or to test your application's failover procedures when Autonomous Data Guard is enabled.

The Oracle Cloud Infrastructure Console on the database with the **Primary** role shows a **Switchover** link in the **Role** field when both the primary database and the local standby database are available. The Oracle Cloud Infrastructure Console on the database with the **Standby** role shows a **Switchover** link in the **Role** field when both the primary database and the remote standby database are available. Thus, when the primary database **Lifecycle State** shows **Available** or **Stopped** and either a local standby database or a cross-region standby database is available, you can perform a switchover.

To see the standby database status, under **Resources** click Autonomous Data Guard and for the standby database listed in the **Peer Autonomous Database** column, check that the **State** field shows **Available** or **Stopped**.

## Add a Standby Database

Perform the following prerequisite steps as necessary:

**To perform switchover to a local standby, access the Primary database (Role: Primary) from the Oracle Cloud Infrastructure Console:**
* Open the navigation menu. Click **Oracle Database**. Under Autonomous Database, click Autonomous Data Warehouse, Autonomous JSON Database, or Autonomous Transaction Processing depending on your workload.
* Choose your **Compartment**.
* In the list of Autonomous Databases, click the display name of the database you want to administer.

**To perform switchover to a remote standby, access the Standby database (Role: Standby):**

For a cross-region switchover you must initiate the switchover from the Standby database. You have several options to access the Standby database:
* Select the remote region in Oracle Cloud Infrastructure Console and then select the Standby database.
* Access the Primary as above, and then from the Primary database you can access the Standby from the Oracle Cloud Infrastructure Console by selecting **Autonomous Data Guard** under **Resources** and clicking the link for the standby database in the **Peer Autonomous Database** column.

To perform a switchover, do the following:
1. On the Autonomous Database Details page, under Autonomous Data Guard, in the **Role** field, click **Switchover**.
As an alternative, to initiate a switchover you can select **More Actions** and **Switchover**.
2. In the **Confirm Manual Switchover to Standby** dialog, enter the database name to confirm that you want to switch over.
3. In the **Confirm Manual Switchover to Standby** dialog, click **Confirm Manual Switchover to Standby**.

The database Lifecycle State changes to Updating. To see the state of the peer database, under Resources click Autonomous Data Guard where the State column shows Role Change in Progress.

**Notes for Autonomous Data Guard switchover:**
* For a cross-region switchover you must initiate the switchover from the Standby database.
* During the switchover most of the actions on the Oracle Cloud Infrastructure Console are not available and the Autonomous Database Information page shows the **Lifecycle State** with the value **Updating**.
* The switchover operation keeps the original state of the Primary database. If the Primary database is stopped when you perform a switchover, the Primary database is stopped after the switchover.
* Autonomous Database generates the Switchover Autonomous Database work request. To view the request, under **Resources** click **Work Requests**.
* After a switchover or failover to the Standby, the Standby becomes the Primary and the graphs in the Service Console and the Oracle Cloud Infrastructure Metrics display information about the Primary, and do not contain information about the database that was the Primary before the switchover or failover operation.
* When you enable Autonomous Data Guard with both a local and a cross-region standby, Autonomous Data Guard does not provide a local standby while the remote region instance operates in the Primary role. Using the remote region in the Primary role is intended for use while the primary region is unavailable or for testing (a temporary scenario). After the primary region database returns to the Primary role, the local Standby will be available.
* You cannot cancel a cross-region switchover operation after the switchover begins and the **State** shows **Role Change in Progress**.

## Learn More
* [Using Standby Databases with Autonomous Database for Disaster Recovery] (https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/autonomous-data-guard-switchover.html#GUID-F341B58A-899F-4EA0-940E-590D4980074C)
* [Concurrent Operations on Autonomous Database] (https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/autonomous-concurrent-operations.html#GUID-9933CA2D-F413-4D31-AA59-E4DBA7CB12E1)
