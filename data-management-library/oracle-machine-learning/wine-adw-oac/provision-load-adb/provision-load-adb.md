# Provision and Load Data into an Autonomous Database Instance

## Introduction

In this lab, you will provision the Oracle Autonomous Database instance, create and grant privileges to a user in the Autonomous Database Instance, and load data into it. 

Estimated Lab Time: 30 minutes

Quick walk through on how to provision and load data into an Autonomous Database Instance.

[](youtube:YCxjo_TjqpE)

*Note: The OCI Cloud Service Console navigation may look different then what you see in the video as it is subject to change.*

### Objectives

In this lab, you will:
- Provision an Autonomous Database instance
- Create and grant privileges to a user in the Autonomous Database
- Load data into the Autonomous Database

### Prerequisites

- This lab requires an [Oracle Cloud account](https://www.oracle.com/cloud/free/). You may use your own cloud account, a cloud account that you obtained through a trial, a Free Tier account, or a LiveLabs account.

## Task 1: Provision an Autonomous Database Instance

1. Login to the Oracle Cloud, as shown in the previous lab.

2. If you are using a Free Trial or Always Free account, and you want to use Always Free Resources, you need to be in a region where Always Free Resources are available. You can see your current default **Region** in the top, right hand corner of the page.

    ![Select region on the far upper-right corner of the page.](./images/Region.png " ")

3. Once you are logged in, you can view the cloud services dashboard where all the services available to you. Click on hamburger menu, search for Autonomous Data Warehouse and select it.

    **Note:** You can also directly access your Autonomous Data Warehouse service in the **Quick Actions** section of the dashboard.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png " ")

4. From the compartment drop-down menu select the **Compartment** where you want to create your ADB instance. This console shows that no databases yet exist. If there were a long list of databases, you could filter the list by the **State** of the databases (Available, Stopped, Terminated, and so on). You can also sort by **Workload Type**. Here, the **Data Warehouse** workload type is selected.

    ![](images/livelabs-compartment.png " ")

5. Click **Create Autonomous Database** to start the instance creation process.

    ![Click Create Autonomous Database.](./images/Picture100-23.png " ")

6.  This brings up the **Create Autonomous Database** screen, specify the configuration of the instance:
    - **Compartment** - Select a compartment for the database from the drop-down list.
    - **Display Name** - Enter a memorable name for the database for display purposes. This lab uses **ADW Good Wine** as the ADB display name.
    - **Database Name** - Use letters and numbers only, starting with a letter. Maximum length is 14 characters. (Underscores not initially supported.) This lab uses **ADWWINE** as database name.

    ![Enter the required details.](./images/adw-wine.png " ")

7. Choose a workload type, deployment type and configure the database:
    - **Choose a workload type** - For this lab, choose __Data Warehouse__ as the workload type.
    - **Choose a deployment type** - For this lab, choose **Shared Infrastructure** as the deployment type.
    - **Always Free** - If your Cloud Account is an Always Free account, you can select this option to create an always free autonomous database. An always free database comes with 1 CPU and 20 GB of storage. For this lab, we recommend you leave Always Free unchecked.
    - **Choose database version** - For this lab, choose **19c**.
    - **OCPU count** - Number of CPUs for your service. For this lab, change this number to **2**.
    - **Storage (TB)** - Select your storage capacity in terabytes. Leave it as **1**.
    - **Auto Scaling** - For this lab, keep auto scaling enabled.

    ![Choose the remaining parameters.](./images/Picture100-26c.png " ")

8. Create administrator credentials, choose network access and license type and click **Create Autonomous Database**.

    - **Password** - Specify the password for **ADMIN** user of the service instance.
    - **Confirm Password** - Re-enter the password to confirm it. Make a note of this password.
    - **Choose network access** - For this lab, accept the default **Allow secure access from everywhere**.
    - **Choose a license type** - For this lab, choose **Bring Your Own License**.

    ![](./images/create.png " ")

9.  Your instance will begin provisioning. In a few minutes, the state will turn from Provisioning to Available. At this point, your Autonomous Database instance is ready to use! Have a look at your instance's details here including its name, database version, OCPU count, and storage size.

    ![Database instance homepage.](./images/provision.png " ")

    ![Database instance homepage.](./images/provision-2.png " ")

## Task 2: Create OMLUSER in Autonomous Database Instance

1.  From the hamburger menu, select **Autonomous Data Warehouse** and navigate to your ADB instance.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png " ")

    ![](./images/choose-adb-adw.png " ")

2.  Select **Tools** on the Autonomous Database Details page.

    ![](./images/tools.png " ")

3.  Select **Open Oracle ML User Administration** under the tools menu.

    ![](./images/open-ml-admin.png " ")

4. Sign in as **Username - ADMIN** and with the password you used when you created your Autonomous instance.

    ![](./images/ml-login.png  " ")

5.  Click **Create** to create a new ML user.

    ![](./images/create-user.png  " ")

6. On the Create User form, enter **Username - OMLUSER**, an e-mail address (you can use admin@oracle.com), un-check **Generate password**, and enter a password you will remember. You can use the same password you used for the ADMIN account. Then click **Create**.

    ![](./images/create-user-details.png  " ")

7. Notice that the **OMLUSER** is created.

    ![](./images/create-user-created.png " ")

## Task 3: Grant OMLUSER privileges to Database Actions

1.  From the hamburger menu, select **Autonomous Data Warehouse** and navigate to your ADB instance.

	![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png " ")

    ![](./images/choose-adb-adw.png " ")

2.  Select **Tools** on the Autonomous Database Details page.

    ![](./images/tools.png " ")

3. Select **Open Database Actions** under the tools menu.

    ![](./images/open-database-actions.png  " ")

4. On the Database Actions login page, log in with your ADB credentials, provide the **Username - ADMIN** and click **Next**. Then provide the <if type="freetier">**Password** you created for the Autonomous instance.</if><if type="livelabs">password **WELcome__1234**</if> and click **Sign in**.

    ![](./images/db-admin.png " ")

    ![](./images/db-admin-password.png " ")

5. From the Database Action menu, select **SQL**.

    ![](./images/sql.png " ")

6. Dismiss the Help by clicking on the **X** in the popup.

    ![](./images/click-x.png  " ")

7.  By default, only the ADMIN user can use the SQL Developer Web. To enable OMLUSER to use it, you need to enter the following and execute the procedure to grant SQL developer web access to OMLUSER.

    ````
    <copy>
    BEGIN
      ORDS_ADMIN.ENABLE_SCHEMA(
        p_enabled => TRUE,
        p_schema => 'OMLUSER',
        p_url_mapping_type => 'BASE_PATH',
        p_url_mapping_pattern => 'OMLUSER',
        p_auto_rest_auth => TRUE
      );
      COMMIT;
    END;
    /
    </copy>
    ````
    ![](./images/mluser-access-granted.png " ")

8.  Grant storage privileges to OMLUSER.

    ````
    <copy>
    alter user OMLUSER quota 500m on data;
    </copy>
    ````

    ![](./images/storage-privileges.png " ")

## Task 4: Download the Necessary Data

1.  Click the link below to download the Wine Reviews CSV file.

    [WINEREVIEWS130KTEXT.csv](https://objectstorage.us-ashburn-1.oraclecloud.com/p/VEKec7t0mGwBkJX92Jn0nMptuXIlEpJ5XJA-A6C9PymRgY2LhKbjWqHeB5rVBbaV/n/c4u04/b/livelabsfiles/o/data-management-library-files/WINEREVIEWS130KTEXT.csv)

2.  Save the WINEREVIEWS130KTEXT.csv to a location and note the path for later.

    ![](./images/download-csv.png  " ")

## Task 5: Upload the Data File

1. On the tab with your ADB instance, click on **Open Database Actions** under Tools.

    ![](./images/open-database-actions.png  " ")


2. Sign in as **ADMIN**. Provide the **Username - ADMIN** and click **Next**. Then provide the password for your ADMIN and click **Sign in**.

    ![](images/db-admin.png)
    
    ![](images/db-admin-password.png)

3. In the webpage's URL, find the section that says **ADMIN** and change it to **OMLUSER**, then press enter. You may want to bookmark this page to access it faster in the future.

    ![](images/admin-url.png)

    ![](images/omluser-url1.png)

4. This time sign in as **OMLUSER**. Provide the **Username - OMLUSER** and the password for your OMLUSER and click **Sign in**.

    ![](images/omluser-login1.png)

5. Select **Data Load** from Database Actions menu.

    ![](images/data-load.png)

6. Leave the default selections - **Load data** and **Local File** and click **Next**.

    ![](images/to-load-data.png)

7. Drag and drop the **WINEREVIEWS130KTEXT.csv** from the location where you downloaded it onto the Drag and Drop target or click on **Select files** to browse the WINEREVIEWS130KTEXT.csv file and upload it.

    ![](images/select-files.png)

8. When the upload is complete, click **Start** and click **Run** in the Run Data Load Job confirmation dialog box.

    ![](images/upload-run.png)

    ![](images/upload-run2.png)

9. Notice the *Status: Running(0/1)* while loading the data. The status will be updated to *Status: Completed(1/1)* once the data loading job is completed.

    ![](./images/upload-loading.png " ")

    ![](images/upload-done.png)

10. Click on the hamburger menu and click on **Development**. From the database actions development menu, select **SQL**.

    ![](images/upload-sql1.png)

11. Click on the **X** in the popup to dismiss the Help.

    ![](./images/sql-close.png  " ")

12. The SQL Web Developer shows the table has been successfully created (and associated with OMLUSER).

    ![](images/sql-table.png)

[Please proceed to the next lab](#next).

## Acknowledgements
* **Author** - Anoosha Pilli & Didi Han, Database Product Management
* **Last Updated By/Date** - Didi Han, Database Product Management,  April 2021