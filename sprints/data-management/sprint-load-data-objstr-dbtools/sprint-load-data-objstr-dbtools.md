# How can I load data from Oracle Object Storage to my ADB instance using Data Tools?

In some cases, you may not be allowed to download or store files on your local computer. An alternative approach for loading the data you need in such environments is to use data files stored in the Oracle Object Store. Oracle Autonomous Database supports a variety of object stores, including Oracle Object Storage, Amazon S3, Azure Blob Storage, Google Cloud Storage, and Wasabi Hot Cloud Storage ([see the documentation for more details](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/data-load.html#GUID-E810061A-42B3-485F-92B8-3B872D790D85)). You will need to establish a cloud storage link, a connection to a bucket in cloud storage to access the files, or use an existing connection to load files into the database. Let's see how to load data from [Oracle Cloud Infrastructure Object Storage](https://www.oracle.com/cloud/storage/object-storage.html) into an Oracle Autonomous Database instance using Data Tool.

Duration: 10 minutes

## Load data from Oracle Object Storage to your Oracle ADB instance using Data Tools

1. On the Oracle Cloud Console, make sure you are in the region where your ADB instance is provisioned. Click on the navigation menu, search **Oracle Database**, and click on **Autonomous Database**.

2. From the compartment drop-down menu, select the **Compartment** where your Oracle Autonomous Database resource is provisioned. If there were a long list of databases, you could filter the list by the **State** of the databases, and sort by **Workload Type**.

3. From the databases displayed, click **Display Name** of the database you wish to add a cloud storage connection to navigate to the **Details** page of your Autonomous Database and click the **Database Actions** button.

4. In the Database Action login form, enter your username and click **Next**. On the following form, enter the password for the user.

5. On the Database Actions launchpad page, under Data Tools, click the **DATA LOAD** card.

6. On the Data Load main page, under "What do you want to do with your data?" click **LOAD DATA** and under "Where is your data?" choose **CLOUD STORAGE**, then click **Next**.

7. If this is your first time loading data from an existing cloud connection, click **Done** on the help tip to set up access to a bucket on Oracle Cloud Infrastructure Object Storage.

8. From the **Select a cloud storage** drop-down, choose your cloud storage connection. The files in the bucket associated with the connection will be displayed on the left side of the Load Cloud Object page.

    If you do not see the files you are looking for to load into the ADB instance, you can create a new connection from an existing credential or create a new connection with a new credential. To add a new connection, click on the **+ symbol** next to Select cloud storage.

    ### Option A: Create a new connection from an existing credential

    Add cloud Storage form will appear on the right-hand side of your browser window. Provide the details below in the Storage Settings section:

    - **Name:** Provide a name for your cloud storage connection
    - **Description:** Add a description for this connection
    - **Select Credential:** From the cloud connection options, click **Select Credential**, and from the credentials drop-down, select from the credential with the user that has the bucket with the files you need to load into the ADB instance
    - Select **Bucket URI:** Provide the URI path for the bucket that has the files you want to load into your ADB instance

    ### Option B: Create a new connection with a new credential

    Add cloud Storage form will appear on the right-hand side of your browser window. Provide the details below in the Storage Settings section:

    - **Name:** Provide a name for your cloud storage connection
    - **Description:** Add a description for this connection
    - **Create Credential:** From the cloud connection options, select **Create Credential**
    - **Cloud Store:** From the cloud store drop-down menu choose **Oracle** as we are adding a connection between Oracle Object Storage and your Oracle ADB instance
    - **Credential Name:** Give a name for your credential
    - **Oracle Cloud Infrastructure User Name:** Provide your OCI user name
    - **Auth Token:** Provide the auth token for your OCI user
    - **Bucket URI:** Provide the URI path for the bucket that has the files you want to load into your ADB instance

    Once you have filled the Storage Settings Section, click **Next**. It displays the files that currently exist at the Cloud storage location you provided earlier.

    Once you can view the files, click **Create** to create the connection between Oracle Object Storage and your Oracle ADB instance.

9. Drag and drop the files or folders from the chosen cloud storage connection to the right-hand pane to do the data loading job.

    If you are loading a folder, note that a dialog box appears asking if you want to load all the files in the folder to a single target table, click **OK**. For example, if you have few parquet files partitioned by a column (for example, month) that you want to load into a single table, click ok.

10.  Click the pencil icon on the right side of the card to inspect the data loading properties.

11. Add load data from cloud Storage dialog box will appear on the right-hand side of your browser window, on the Settings tab view, for a table, view, or to modify the below settings:

    - **Option:** The default option to **Create Table** from the source is chosen
    - **Name:** Update the name of the table if needed.
    - **Mapping:** Under Mapping, notice the data loader derived the column names and data types from the file contents, update or modify the datatypes as needed.

12. Click **Close** after updating the details. If you have more sources to load, drag the file or folder over to the right-hand pane and repeat steps 10 to 12.

13. When you are ready to load the tables into the database, click the Play button to run the data load job. On the Run Data Load Job dialog box, click **Run**. The time to load each file depends on factors including file size and network speed. The progress of the job can be monitored from the status bar and the ring to the left of each job card. When the ring is complete, the file has been uploaded successfully.

14. Check that all the data load cards have green tick marks, indicating that the data load tasks have been completed successfully.

15. To inspect the table(s) that were automatically created during the data load process, click on a tile where you wish to view the data. The load data from the cloud Storage dialog box will appear on the right-hand side of your browser window. Select the **Table** tab in the left-hand side listing. You will see the data from the source. Then, click **Close** to dismiss the dialog.

Congratulations! In a few clicks, you were able to load data into your new tables without having to write any SQL code. It was all done with a few mouse clicks.

## Learn More

- [Data Loading](https://docs.oracle.com/en/database/oracle/sql-developer-web/sdwad/data-load.html#GUID-E810061A-42B3-485F-92B8-3B872D790D85)


