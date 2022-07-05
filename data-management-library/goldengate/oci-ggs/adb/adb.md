# Set up the environment

## Introduction

This lab walks you through the steps to create the required resources you'll use for Oracle Cloud Infrastructure (OCI) GoldenGate. We'll show you how to create a VCN and subnet, provision autonomous database instances, and load data into the databases.

Estimated time: 20 mins

### Objectives

-  Learn to provision a VCN and subnet
-  Learn how to provision, connect, and load data into an Autonomous Transaction Processing (ATP) instance
-  Learn how to provision an Autonomous Data Warehouse (ADW) instance

### Prerequisites

This lab assumes you have completed the following labs:
* Sign Up for Free Tier/Login to Oracle Cloud

> **Note:** *You may see differences in account details (eg: Compartment Name is different in different places) as you work through the labs. This is because the workshop was developed using different accounts over time.*

In this section, you will provision a VCN and subnet, ATP and ADW instances, and load data to use with OCI GoldenGate.

> **Note:** *This workshop was designed to use Oracle Autonomous Databases as the source and target. If you plan to use Oracle Database, ensure that you use the CDB user to capture data from the PDBs.*

## Task 1: Create a VCN and subnet

1.  Open the **Navigation Menu**, navigate to **Networking**, and select **Virtual Cloud Networks**.

	![Virtual Cloud Networks in Oracle Cloud navigation menu](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/networking-vcn.png " ")

2.  On the **Virtual Cloud Networks in &lt;compartment-name&gt;** page, click **Start VCN Wizard**.

	![Virtual Cloud Networks page](images/01-02.png " ")

3.  In the Start VCN Wizard dialog, select **VCN with Internet Connectivity**, and then click **Start VCN Wizard.**

    ![Start VCN Wizard dialog](./images/00-03-vcn-wizard.png " ")

4.  Enter a name for the VCN, select a compartment, and then click **Next**.

    ![Enter VCN details](./images/00-04.png " ")

5.  Verify the configuration, and then click **Create**.

    ![Verify configuration details](./images/00-05.png " ")

You can click View VCN Details and see both a Public and Private subnet were created.

## Task 2: Create an ATP instance

1.  Open the **Navigation Menu**, navigate to **Oracle Database**, and select **Autonomous Transaction Processing**.

	![Autonomous Transaction Processing in Oracle Cloud navigation menu](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-atp.png " ")

2.  On the **Autonomous Database &lt;compartment-name&gt;** page, click **Create Autonomous Database**.

    ![Autonomous Database page](./images/01-02-create-adb.png " ")

3. For **Compartment** select a compartment from the dropdown. (Note that yours will be different - do not select **ManagedCompartmentforPaaS**) and then enter **ATPSource** for **Display Name** and **Database Name**.

    ![Create Autonomous Database page](./images/01-03-compartment.png " ")

4.  Under **Choose a workload type**, select **Transaction Processing**.

    ![Workload type options](./images/01-04-workload.png " ")

5.  Under **Choose a deployment type**, select **Shared Infrastructure**.

    ![Deployment type options](./images/01-05-deployment.png " ")

6.  Under **Configure the database**, leave **Choose database version** and **Storage (TB)** and **OCPU Count** as they are.

7.  Add a password. Take note of the password, you will need it later in this lab.

    ![Password field](./images/01-07-pw.png " ")

8.  Under **Choose a license type**, select **License Included**.

    ![License type options](./images/01-08-license.png " ")

9.  Click **Create Autonomous Database**. Once it finishes provisioning, you can click on the instance name to see details of it.


## Task 3: Load the ATP schema

1.  Click the following link to download the database schema.

    [Archive.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/VEKec7t0mGwBkJX92Jn0nMptuXIlEpJ5XJA-A6C9PymRgY2LhKbjWqHeB5rVBbaV/n/c4u04/b/livelabsfiles/o/data-management-library-files/Archive.zip)

2.  Save `Archive.zip` to a download directory, and then unzip the file.

3.  Back in the OCI Console, select your ATP instance from the Autonomous Databases page to view its details and access tools.

    ![Select your Autonomous Database instance](./images/02-03-atp.png " ")

4.  Click **Open DB Actions**.

5.  Log in with the ADMIN user and password provided when you created the ATP instance.

    ![DB Actions log in page](./images/02-05-login.png " ")

6.  From the Database Actions menu, under **Development**, select **SQL**.

    ![Database Actions page](./images/02-06-db-actions.png " ")

7.  (Optional) Click **X** to close the Help dialog.

8.  Copy and paste the SQL script from **OCIGGLL\_OCIGGS\_SETUP\_USERS\_ATP.sql** into the SQL Worksheet.

    ![Pasted script in SQL Worksheet](./images/02-08-atp-sql.png " ")

9.  Click **Run Script**. The Script Output tab displays confirmation messages.

10. Copy and paste the SQL script from **OCIGGLL\_OCIGGS\_SRC\_USER\_SEED\_DATA.sql** a new SQL Worksheet.

    ![Pasted schema script in SQL Worksheet](./images/02-10-atp-schema.png " ")

11. Click **Run Script**. The Script Output tab displays confirmation messages.

	>**Note:** *If you find that running the entire script does not create the tables, then try running each table creation statement one at a time until all the tables are created.*

12. In the Navigator tab, look for the SRC\_OCIGGLL schema and then select tables from their respective dropdowns to verify the schema and tables were created. You may need to log out and log back in if you can't locate SRC\_OCIGGLL.

    ![Displays the SRC\_OCIGGLL tables](./images/02-11-verify.png " ")

13. To enable supplemental logging, run the following command:

    ```
    <copy>ALTER PLUGGABLE DATABASE ADD SUPPLEMENTAL LOG DATA;</copy>
    ```

## Task 4: Create an ADW instance and user

1.  Open the **Navigation Menu**, navigate to **Oracle Database**, and select **Autonomous Data Warehouse**.

	![Autonomous Data Warehouse in Oracle Cloud navigation menu](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png " ")

2.  Click **Create Autonomous Database**.

    ![Autonomous Database page](./images/01-02-create-adb.png " ")

3. Select **Compartment** by clicking on the drop-down list. (Note that yours will be different - do not select **ManagedCompartmentforPaaS**) and then enter **ADWTarget** for **Display Name** and **Database Name**.

    ![Create Autonomous Database page](./images/01-03-compartment.png " ")

4.  Under **Choose a workload type**, select **Data Warehouse**.

    ![Workload type options](./images/01-04-workload.png " ")

5.  Under **Choose a deployment type**, select **Shared Infrastructure**.

    ![Deployment type options](./images/01-05-deployment.png " ")

6.  Under **Configure the database**, leave **Choose database version** and **Storage (TB)** and **OCPU Count** as they are.

7.  Add a password. Note the password down in a notepad, you will need it later in Lab 2.

    ![Password field](./images/01-07-pw.png " ")

8.  Under **Choose a license type**, select **License Included**.

    ![License type options](./images/01-08-license.png " ")

9.  Click **Create Autonomous Database**. After it finishes provisioning, you can click on the instance name to see details of it.

10. On the Details page, click **DB Actions**.

11. Log in using the ADMIN username and password set in step 7.

12. Copy and paste the script from **OCIGGLL\_OCIGGS\_SETUP\_USERS\_ADW.sql** into the SQL worksheet, and then click **Run Script**.

	![Pasted script in SQL worksheet](images/04-05-adw.png " ")

13. Log out of DB Actions.

## Acknowledgements

- **Author** - Jenny Chan, Consulting User Assistance Developer
- **Last Updated** - March 2022
- **PAR Expiration date** - March 31, 2022
