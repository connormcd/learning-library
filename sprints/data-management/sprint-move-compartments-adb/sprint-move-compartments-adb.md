# How do I move an ADB instance to a different compartment?
Duration: 2 minutes

To move a database you must have the right to manage Autonomous Databases in the database's current compartment and in the compartment you are moving it to.

As soon as you move a database to a different compartment, the policies that govern the new compartment apply immediately and affect access to the database. Therefore, your access to the database may change, depending on the policies governing your Oracle Cloud user account's access to resources.

## Move an Autonomous Database to a Different Compartment

Perform the following prerequisite steps as necessary:
* Open the navigation menu. Click **Oracle Database**. Under Autonomous Database, click Autonomous Data Warehouse, Autonomous JSON Database, or Autonomous Transaction Processing depending on your workload.
* Choose your **Compartment**.
* In the list of Autonomous Databases, click the display name of the database you want to administer.

To move your ADB instance to a different compartment, do the following:
1. Choose your region.
2. Choose your **Compartment**.
3. Select an Autonomous Database instance from the list in your compartment.
4. On the **Details** page, from the **More Actions** drop-down list, select **Move Resource**.
5. In the **Move Resource to a Different Compartment** page, select the new compartment.
6. Click **Move Resource**.

## Learn More
[Moving Database Resources to a Different Compartment] (https://docs.oracle.com/en-us/iaas/Content/Database/Concepts/databaseoverview.htm#moveRes)
