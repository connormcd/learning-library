# How do I disable Data Guard for an ADB instance?
Duration: 5 minutes

When you enable Autonomous Data Guard the system creates a standby database that is continuously updated with the changes from the primary database. Once Autonomous Data Guard is enabled, you can disable it as needed.

## Disable Autonomous Data Guard

You can enable Autonomous Data Guard when Autonomous Database is available (Lifecycle State shows Available).
1. Open the navigation menu. Click **Oracle Database**. Under Autonomous Database, click Autonomous Data Warehouse, Autonomous JSON Database, or Autonomous Transaction Processing.
2. Choose your **Compartment**.
3. In the list of Autonomous Databases, click the display name of the database you want to administer.
4. On the **Autonomous Database Details** page, under Autonomous Data Guard, click **Disable** in the Status field.
5. In the Disable Autonomous Data Guard dialog, select a Standby database.
6. In the Disable Autonomous Data Guard dialog, enter the Autonomous Database name to confirm that you want to disable Autonomous Data Guard for the instance.
7. In the Disable Autonomous Data Guard dialog, click **Disable Autonomous Data Guard**. While the Standby database is terminating, the **Lifecycle State** changes to **Updating**.

**Note:** Disabling Autonomous Data Guard terminates the Standby database. If you later enable Autonomous Data Guard, the system creates a new Standby database.

Autonomous Database generates the Disable Autonomous Data Guard work request. To view the request, under Resources click Work Requests.

## Learn More
[Using Standby Databases with ADB for Database Recovery] (https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/autonomous-data-guard-disable.html#GUID-B8803FCC-586F-48A8-961E-3987F8DBE79F)
