# How can I connect Oracle Object Storage to my Oracle ADB instance using Database Tools?

Duration: 5 minutes

In some cases, you may not be allowed to download or store files on your local computer. An alternative approach for loading the data you need in such environments is to use data files stored in the Oracle Object Store. Oracle Autonomous Database supports a variety of object stores, including Oracle Object Storage, Amazon S3, Azure Blob Storage, Google Cloud Storage and, Wasabi Hot Cloud Storage ([see the documentation for more details](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/data-load.html#GUID-E810061A-42B3-485F-92B8-3B872D790D85)). You will establish a cloud storage link, a connection to a bucket in cloud storage to access the files. Let's see how to connect [Oracle Cloud Infrastructure Object Storage](https://www.oracle.com/cloud/storage/object-storage.html) to your Oracle Autonomous Database instance using Data Tool.

## Add a new cloud storage connection to your ADB instance

1. On the Oracle Cloud Console, make sure you are in the region where your ADB instance is provisioned. Click on the navigation menu, search **Oracle Database**, and click on **Autonomous Database**.

2. From the compartment drop-down menu, select the **Compartment** where your Oracle Autonomous Database resource is provisioned. If there were a long list of databases, you could filter the list by the **State** of the databases, and you can also sort by **Workload Type**.

3. From the databases displayed, click **Display Name** of the database you wish to add a cloud storage connection to navigate to the **Details** page of your Autonomous Database and click the **Database Actions** button.

4. In the Database Action login form, enter your username and click **Next**. On the next form, enter the password for the user.

5. On the Database Actions launchpad page, under Data Tools, click the **DATA LOAD** card.

6. On the Data Load main page, under Explore and Connect, click **CLOUD LOCATIONS**

7. On the Manage Cloud page, click **Add Cloud Storage**.

8. A form will appear on the right-hand side of your browser window. Provide the details below in the Storage Settings section:

    - **Name:** Provide a name for your cloud storage connection
    - **Description:** Add a description for this connection
    - **Create Credential:** From the cloud connection options, select **Create Credential**
    - **Cloud Store:** From the cloud store drop-down, choose **Oracle** as we are adding a connection between Oracle Object Storage and your Oracle ADB instance
    - **Credential Name:** Give a name for your credential
    - **Oracle Cloud Infrastructure User Name:** Provide your OCI user name
    - **Auth Token:** Provide the auth token for your OCI user
    - Select **Bucket URI:** Provide the URI path for the bucket that has the files you want to load into your ADB instance

9. Once you have filled the Storage Settings Section, click **Next**. It displays the files currently at the Cloud storage location you provided earlier.

10. Once you can view the files, click **Create** to create the connection between Oracle Object Storage and your Oracle ADB instance.

    Congratulations! Now you have connected your Oracle Object Storage and your Oracle ADB instance.

## Learn more

- [Managing Cloud Storage Connections](https://docs.oracle.com/en/database/oracle/sql-developer-web/sdwad/manage-cloud-connections.html#GUID-0AB44485-17A3-4794-ACAF-AF55C77D24EF)