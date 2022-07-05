# How do I add a standby database?

Duration: 5 minutes

When you enable Autonomous Data Guard you create one standby database, either in the current region (local), or in a remote region (cross-region). After you enable Autonomous Data Guard, you can add a second standby database.

When you enable Autonomous Data Guard with a current region (local) standby database, you can add a second standby database that is a remote (cross-region) standby database. When you enable Autonomous Data Guard with a remote standby database (cross-region), you can add a second standby database that is a current region (local) standby database.

## Add a Standby Database

Perform the following prerequisite steps as necessary:
* Open the navigation menu. Click **Oracle Database**. Under Autonomous Database, click Autonomous Data Warehouse, Autonomous JSON Database, or Autonomous Transaction Processing depending on your workload.
* Choose your **Compartment**.
* In the list of Autonomous Databases, click the display name of the database you want to administer.

To add a standby database, do the following:

1. On the **Autonomous Database Details** page, in the **Resources** area select **Autonomous Data Guard**.
2. Click **Add Standby Database**. If you select a remote region for your standby, Autonomous Database shows the **Select a compartment** list. From this list, choose a compartment.
3. Click **Add Standby Database**. The Autonomous Database Lifecycle State changes to **Updating**. In the **Resources** area the number next to **Autonomous Data Guard** shows that you now have two standby databases **(2)**, one local and one remote, and the **State** field shows **Provisioning** for the new standby database.

After some time, the **Lifecycle State** shows **Available** and the standby database provisioning continues.

**Notes for adding a second standby database with Autonomous Data Guard:**
* Autonomous Database generates an Enable Autonomous Data Guard work request. To view the request, under **Resources** click **Work Requests**.
* After you add an Autonomous Data Guard with a remote standby, download a new instance wallet. The instance wallet file you download from the primary database contains connection strings for both the primary region and the remote region database. The same instance wallet works after you switchover or failover to the remote region standby.

The order of the connections strings in the instance wallet file impacts the database connection time. For best performance, use an instance wallet file downloaded from the region in which the current Primary instance resides.

## Learn More
[Autonomous Data Guard with Cross-Region Standby] (https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/autonomous-data-guard-add.html#GUID-967ED737-4A05-4D6E-A7CA-C3F21ACF9BF0)
