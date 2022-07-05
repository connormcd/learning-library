# Register databases

## Introduction

This lab walks you through the steps to create a database registration.

Estimated time: 2 minutes

### About Database Registrations
Database Registrations capture source and target credential information. A database registration also enables networking between the OCI GoldenGate service tenancy virtual cloud network (VCN) and your tenancy VCN using a private endpoint.

### Objectives
In this lab, you will register source and target databases for Oracle GoldenGate deployments to use for the duration of this lab.

### Prerequisites
This lab assumes that you completed all preceding labs.

## Task 1: Register the source database

First, follow the steps below to register the source Oracle Autonomous Transaction Processing \(ATP\) Database.

1.  Use the Oracle Cloud Console breadcrumb to navigate back to the GoldenGate page.

    ![GoldenGate highlighted in Oracle Cloud Console breadcrumb](images/01-01-breadcrumb.png " ")

2.  Click **Registered Databases**.

    ![Registered Databases in GoldenGate menu](images/01-02-ggs-registerdb.png " ")

3.  Click **Register database**.

    ![Registered Databases page](images/01-03-ggs-registerdb.png " ")

4.  In the Register Database panel, for Name and Alias, enter **SourceATP**.

5.  From the Compartment dropdown, select a compartment.

6.  Click **Select Database**.

7.  From the Database Type dropdown, select **Autonomous Database**.

8.  For **Autonomous Database in &lt;compartment-name&gt;**, click **Change Compartment**, select the compartment you created your ATP instance, and then select **SourceATP** from the dropdown. Some fields are autopopulated based on your selection.

9.  Enter the database's password in the Password field, and then click **Register**.

    ![Source Database details](images/01_01_12_regSourceDB.png)

    The database registration becomes Active after a few minutes.

## Task 2: Unlock the GGADMIN user and enable supplemental logging for the source database

Oracle Autonomous Databases come with a GGADMIN user that is locked by default. The following steps guide you through how to unlock the GGADMIN user.

1.  From the Oracle Cloud Console **Navigation Menu** (hamburger icon), click **Oracle Database**, and then select **Autonomous Transaction Processing**.

	![Autonomous Transaction Processing in the Oracle Cloud Console navigation menu](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-atp.png " ")

2.  From the list of databases, select **SourceATP**.

    ![Autonomous Transaction Processing page](images/02-02.png " ")

3.  On the SourceATP Database Details page, click **Database Actions**.

    ![SourceATP Database Details page](images/02-03-db-tools.png " ")

    > **Note:** *If you're prompted to log in to Database Actions, use the SourceATP admin credentials located in the Workshop Details.*

4.  Under **Administration**, click **Database Users**.

    ![Database Actions](images/database-actions.png " ")

5.  From the list of users, locate **GGADMIN**, and then click the ellipsis (three dots) icon and select **Edit**.

    ![Database users](images/02-06-locked.png)

6.  In the Edit User panel, deselect **Account is Locked**, enter the password you gave the ggadmin user in the database registration steps above (Lab 1, Task 1, Step 14), and then click **Apply Changes**. Note that the user icon changes from a padlock to a checkmark.

    ![Edit user](images/02-07-edit.png)

>**Note:** If you encounter errors when entering the password, please make sure your password contains only upper case letters, lower case letters, numbers, and underscores. If you are using the green button (run on LiveLabs tenancy), you can use your database admin password given to you on the reservation page. Just make sure this password matches the ggadmin user's password.

7.  Open the navigation menu (hamburger icon), and then under **Development**, select **SQL**.

    ![Open navigation menu](images/01-08-sql.png)

8.  Enter the following into the Worksheet, and then click **Run Statement**.

    ```
    <copy>ALTER PLUGGABLE DATABASE ADD SUPPLEMENTAL LOG DATA;</copy>
    ```

9.  Replace the supplemental logging script with the following to check support mode, and then click **Run Statement**:

    ```
    <copy>
    select * from DBA_GOLDENGATE_SUPPORT_MODE where owner = 'SRC_OCIGGLL';
    </copy>
    ```

    The Script Output panel displays six tables whose Support_Mode is **FULL**.

    ![Script Output](images/02-09b.png " ")

    You can leave the SQL window open and continue with the next Task.

## Task 3: Register the target database and unlock the GGADMIN user

Now, follow the steps below to register the target Autonomous Data Warehouse \(ADW\) instance.

1.  Use the Oracle Cloud Console navigation menu to navigate back to GoldenGate.

1.  Click **Registered Databases** and then **Register Database**.

    ![Registered Databases in GoldenGate menu](images/03-02.png)

2.  In the Register Database panel, enter **TargetADW** for Name and Alias.

3.  From the **Compartment** dropdown, select a compartment.

4.  Click **Select Database**.

5.  For **Autonomous Database in &lt;compartment-name&gt;**, click **Change Compartment**, select the compartment you created your ADW instance, and then select **TargetADW** from the dropdown. Some fields are autopopulated based on your selection.

6.  Enter the database's password in the Password field, and then click **Register**.

    ![Target Database details](images/02_10-ggs-regDB_target.png)

    The source and target databases appear in the list of Registered Databases. The database registration becomes Active after a few minutes.

7.  Repeat Task 2, steps 1 to 7, to unlock the GGADMIN user on the TargetADW database.

You may now **proceed to the next lab**.

## Learn more

* [Managing Database Registrations](https://docs.oracle.com/en/cloud/paas/goldengate-service/using/database-registrations.html)

## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Denis Gray, Database Product Management; Arabella Yao, Database Product Management
* **Last Updated By/Date** - Arabella Yao, April 2022
