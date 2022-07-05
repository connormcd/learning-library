# Get started with Oracle Cloud Free Tier Setup

## Introduction

This lab walks you through the steps to set up your Oracle Cloud Free Tier environment that includes provisioning an Oracle Autonomous Database, and signing into Oracle Machine Learning user interface.

Estimated Time: 15 minutes

### Objectives

In this lab, you will learn how to:

* Provision an Oracle Autonomous Database
* Create an Oracle Machine Learning user
* Sign into Oracle Machine Learning user interface
* Create the CUSTOMERS360 table.

	> **Note:** You will use this table in the _Using Oracle Machine Learning AutoML UI_ lab and _Using Oracle Machine Learning Services_ lab.

### Prerequisites

* Sign up for a Free Tier Oracle Cloud account.

> **Note:** You may see differences in account details (eg: Compartment Name is different in different places) as you work through the labs. This is because the workshop was developed using different accounts over time.


## Task 1: Provision an Oracle Autonomous Database

To provision an Oracle Autonomous Database:

1. Sign into your OCI account, and under the Launch Resources section, click **Create an ADW database**.

	![Create ADW Database](images/adw-database.png)

	 Alternatively, you may click the left navigation pane on the upper left corner, and click **Autonomous Data Warehouse** under **Oracle Database**.

	![Autonomous Data Warehouse option under Oracle Database](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png "Autonomous Data Warehouse option under Oracle Database")

2. From the Oracle Cloud Infrastructure console, on the Oracle Autonomous Database page choose your region and select a compartment. Click **Create Autonomous Database**. This opens the Create Autonomous Database page.

   ![Create Autonomous Database option](images/create-autonomous-db.png)

3. On the Create Autonomous Database page, provide the basic information about the database. By default, a database name and a display name for the database are provided. You can modify these names to enter a user-friendly display name for the ADB instance to easily identify the resource. The display name does not have to be unique.    

   ![Autonomous Database information](images/adb-basic-inform.png)

4. For Workload Type, click **Data Warehouse**.

	 ![Autonomous Database Workload type](images/workload-type.png)

5. For Deployment, select **Shared Infrastructure**.

	 ![Autonomous Database deployment type](images/deployment-type.png)

6. For Database Configuration, select Always Free. For the Always Free option, the database configuration options - OCPU count, Storage, and Auto scaling are not available. You must upgrade to a paid account to avail of it.

	 > **Note:** You can create Always Free resources both in Free Tier and Paid accounts

  ![Configure Database](images/db-configuration.png)

7. Create your Autonomous Database administrator credentials by providing a password. You will need these credentials to sign into this Autonomous Database instance.   

	> **Note:** The default administrator username is ADMIN.

	![Database Administrator credentials](images/db-admin-credentials.png)

8. For network access, select **Allow secure access from everywhere.**

    ![Network Access settings](images/create-adw-network.png)

9. For License, select **License Included**.

    ![License settings](images/create-adw-license.png)

10. Click **Create Autonomous Database**. The Oracle Autonomous Data Warehouse instance starts provisioning. Once your Autonomous Database is created, the database details are listed with the status Available.

	  ![ADB details](images/adw-details.png)

This completes the task of provisioning an Oracle Autonomous Database.

## Task 2: Create an Oracle Machine Learning user

An administrator creates a new user account and user credentials for Oracle Machine Learning in the User Management interface.

> **Note:** You must have the administrator role to access the Oracle Machine Learning User Management interface.

To create a user account:

1. Sign into your OCI account, click the hamburger on the left to open the left navigation pane, and click **Autonomous Data Warehouse**.

	![Oracle Autonomous Data Warehouse](images/adw.png)

2. Click on the Autonomous Database instance.   

	![Oracle Autonomous Data Warehouse](images/provisioned-adb.png)

3. On the Autonomous Database Details page, click **Database Actions**.

	![Oracle Autonomous Data Warehouse](images/database-actions.png)

4. The Oracle Database Actions Launchpad page opens in a separate tab. Scroll down to the Administration section and click **DATABASE USERS**.

	![Oracle Autonomous Data Warehouse](images/admin-db-users.png)

5. Click **Create User**. The Create User dialog opens.

	![Oracle Autonomous Data Warehouse](images/create-users-db.png)

6. On the Create User dialog, enter the following details and click **Create User**:	  

	![Oracle Machine Learning User Administration Sign in page](images/create-user-dialog.png)

	* **User Name:** Enter the user name OMLUSER.
	* **Password:** Enter a password for this user.
	* **Confirm Password:** Re-enter the password that you entered in the Password field.
	* **Graph:** Select this option to enable graph for this user.
	* **Web Access:** Select this option to allow web access to this user.
	* **OML:** Select this option to allow this user to access Oracle Machine Learning.
	* **Quota of tablespace data:** Click on the drop-down list and select an option. For this lab, 1G is selected.
	* **Password Expired:** Select this option if you want the user to reset the password.
	* **Account is locked:** Select this option to lock the account.


7. After the user is created successfully, the message _User OMLUSER created successfully_ is displayed.

	![Oracle Autonomous Data Warehouse](images/user-creation-msg.png)

	Scroll down the page to view the user. The OMLUSER is listed along with all details. Click ![ellipse icon](images/ellipse.png) to edit, delete, or disable any of the privileges granted to the user.
	![Oracle Autonomous Data Warehouse](images/view-user.png)

	This completes the task of creating a user.

## Task 3: Sign into Oracle Machine Learning

A notebook is a web-based interface for data analysis, data discovery, data visualization, and collaboration. You create and run notebooks in Oracle Machine Learning user interface. You can access Oracle Machine Learning user interface from Autonomous Database.

1. On your Oracle ADW instance, click **Database Actions**.

	![Database Actions in ADW](images/database_actions.png)

	 To go to Database Actions page from the Database Users page, click **Database Actions** on the top left corner of the page, as shown in the screenshot below.

	![Database Actions](images/db-users-db-actions.png)

2. On the Database Actions page, go to the Development section and click **Oracle Machine Learning**. This opens the Oracle Machine Learning sign in page.

	 ![Oracle Machine Learning Notebooks in ADW](images/adb-dev-oml.png)

3. Enter your user credentials and click **Sign in**.

	> **Note:** The credential is what you have defined while creating the Oracle Machine Learning user.

	![Oracle Machine Learning Notebooks Sign in page](images/omluser-signin.png)

  This opens the Oracle Machine Learning user interface home page.

	![Notebooks option in OML homepage](images/homepage.png)

This completes the task of signing into Oracle Machine Learning user interface.

## Task 4: Create the CUSTOMERS360 table

In this step, you will create the table ``CUSTOMERS60`` by using the Scratchpad. The Scratchpad is available on the Oracle Machine Learning Notebooks home page. The Scratchpad is a one-click access to a notebook for running SQL statements, PL/SQL scripts, and Python scripts. After you run your scripts, the Scratchpad is automatically saved as a notebook by the default name _Scratchpad_ in the Notebooks page. You can access it later in the Notebooks page. You will learn more about notebooks in Lab 1.

> **Note:** You will be using the table CUSTOMERS360 in the _Using Oracle Machine Learning AutoML UI_ lab and _Using Oracle Machine Learning Services_ lab.

To create the table:

1. On the Oracle Machine Learning home page, click **Scratchpad**.

	![Notebooks option in OML homepage](images/homepage-scratchpad.png)

2. By default, the Scratchpad opens with three paragraphs: `%sql` (to run SQL statements), `%script` (to run PL/SQL scripts), and `%python` (to run Python scripts). Here, you will use the SQL paragraph to run a SQL statement to create the CUSTOMER360 table. On the SQL paragraph, click after the `%sql` tag, and press enter.

	![Create Notebook dialog](images/scratchpad.png)

3. In the SQL paragraph, enter the following script and click the Run icon ![run icon](images/run.png):

    ```
    <copy>
		CREATE TABLE CUSTOMERS360 AS
              (SELECT a.CUST_ID, a.CUST_GENDER, a.CUST_MARITAL_STATUS,
                 a.CUST_YEAR_OF_BIRTH, a.CUST_INCOME_LEVEL, a.CUST_CREDIT_LIMIT,
                 b.EDUCATION, b.AFFINITY_CARD,
                 b.HOUSEHOLD_SIZE, b.OCCUPATION, b.YRS_RESIDENCE, b.Y_BOX_GAMES
           FROM SH.CUSTOMERS a, SH.SUPPLEMENTARY_DEMOGRAPHICS b
           WHERE a.CUST_ID = b.CUST_ID);
		</copy>
    ```

	![SQL script to create Customers360 table](images/scratchpad-run.png)

	After the script runs successfully, the paragraph status changes to `FINISHED`, as shown in the screenshot:

	![SQL script to create Customers360 table](images/scratchpad-finished.png)

6. In the next paragraph, edit the paragraph tag to change it to `%sql`, and run the following statement to view the data:

	```
		<copy>
		select * from CUSTOMERS360
			where rownum < 10;
		 </copy>
	 ```

	![Script to view Customers360 table](images/script-view-customers360.png)

This completes the task of creating the CUSTOMERS360 table.

## Learn More

* [Get Started with Oracle Machine Learning for Python](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/get-started-with-oml4py.html#GUID-B45A76E6-CE48-4E49-B803-D25CA44B09ED)
* [Oracle Machine Learning Notebooks](https://docs.oracle.com/en/database/oracle/machine-learning/oml-notebooks/)

## Acknowledgements

* **Author** - Moitreyee Hazarika, Principal User Assistance Developer, Database User Assistance Development
* **Contributors** -  Mark Hornick, Senior Director, Data Science and Machine Learning; Marcos Arancibia Coddou, Product Manager, Oracle Data Science; Sherry LaMonica, Principal Member of Tech Staff, Advanced Analytics, Machine Learning
* **Last Updated By/Date** - Moitreyee Hazarika, June 2022
