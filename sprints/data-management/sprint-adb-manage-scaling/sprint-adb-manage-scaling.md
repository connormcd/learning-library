# How do I scale my Oracle Autonomous Database instance?

To increase transaction throughput, you can dynamically scale up a database while the workload is running. Scaling up can also provide more concurrency for your users. We will show you how to scale up/down your Oracle Autonomous Data instance service to have more CPUs.

Duration: 3 minutes

## Scale your Autonomous Database instance

1. On the Oracle Cloud Console, make sure you are in the region where your ADB instance is provisioned. Click the navigation menu, search **Oracle Database** and click on **Autonomous Database**.

2. From the compartment drop-down menu, select the **Compartment** where your Oracle Autonomous Database resource is provisioned. If there were a long list of databases, you could filter the list by the **State** of the databases, and sort by **Workload Type**.

3. Click **Display Name** of the database you wish to scale from the databases displayed.

4. On the database instance Details page, click **More Actions**.

5. From the more actions drop-down menu, select **Manage Scaling**.

6. Manage Scaling dialog box will appear on the right-hand side of your browser window. Fill in the Manage scaling dialog with the following information:

    -   **OCPU count:** Provide the number of OCPU count you wish to update
    -   **OCPU auto scaling:** If you have accepted the default value while provisioning the instance, you might have accepted the default enablement of auto scaling. If not, keep this checkmark in this checkbox.
    -   **Storage (TB):** Provide the storage size you wish to update
    -   **Storage auto scaling:** Keep this checkbox deselected; by default, the checkbox does not have a checkmark

    > **Note:** You can scale up/down your autonomous database only if your autonomous database is NOT Always Free.

7.  Click **Apply** after filling in the Manage scaling dialog.

    > *Note: Applications can continue running during the scale operation without downtime.*

8.  This will take you to the database instance's Details page. A message will appear indicating **SCALING IN PROGRESS**. Wait a few minutes for the scaling to finish. When scaling finishes, the message will change to **AVAILABLE**. You may need to refresh the page to see the result of the scale operation.

## Learn More

- Click [here](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/autonomous-add-resources.html#GUID-DA72422A-5A70-42FA-A363-AB269600D4B0) for documentation on enabling auto scaling.
- Watch this quick [demo](YgwbqurhxjM) that shows the performance and concurrency impacts of scaling your service online.
