# How do I restore an ADB instance?
Duration: 3 minutes

From the Oracle Cloud Infrastructure Console you can restore the database using the **Restore** operation, where you initiate recovery for your database.

## Restore and Recover your Autonomous Database

Perform the following prerequisite steps as necessary:
* Open the navigation menu. Click **Oracle Database**. Under Autonomous Database, click Autonomous Data Warehouse, Autonomous JSON Database, or Autonomous Transaction Processing depending on your workload.
* Choose your **Compartment**.
* In the list of Autonomous Databases, click the display name of the database you want to administer.

To restore and recover your database, do the following:
1. On the Autonomous Database Details page, from the **More Actions** drop-down list, select **Restore** to display the **Restore** prompt.
2. In the Restore prompt, select **Enter Timestamp** or **Select Backup** to restore to a point in time or to restore from a specified backup.
3. Enter Timestamp: Enter a timestamp to restore to in the **Enter Timestamp** calendar field.
4. Select Backup: Select a backup from the list of backups. Limit the number of backups you see by specifying a period using the **From** and **To** calendar fields.
5. Click **Restore**.
6. When the restore operation finishes your Autonomous Database instance opens and the Lifecycle State shows **Available**.

**Notes:**
* The restore operation also restores the DATA\_PUMP\_DIR directory and user defined directories to the timestamp you specified for the restore; files that were created after that timestamp would be lost.
* When you restore, the Oracle Machine Learning workspaces, projects, and notebooks are not restored.
* For external tables, partitioned external tables, and the external partitions of hybrid partitioned tables a backup does not include the external files that reside on your Object Store. Thus, for operations where you use a backup to restore your database, such as **Restore** or **Clone from a backup** it is your responsibility to backup, and restore if necessary, the external files associated with external tables, external partitioned tables, or the external files for a hybrid partitioned table.

## Learn More
[Clone Autonomous Database from a Backup] (https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/autonomous-clone-backup.html#GUID-20D2D970-0CB4-472F-BF89-1EE769BFB5E8)
