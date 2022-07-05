# How can I copy data from Object storage to ADB?
Duration: 10 minutes

To load data from files in the cloud into your ADB, use the PL/SQL **DBMS\_CLOUD** package.

## Copying data from Object Storage to ADB

1. Locate the base URL in your object store

  Copy the base URL from the **View Object Details** in the right side ellipsis menu in the OCI Object Store. Do not include the trailing slash. Save the base URL in a text notepad as you will need this later.

  **Note:**  The URL can also be constructed as below:
 
    ```
    https://objectstorage.{region name}.oraclecloud.com/n/{namespace name}>/b/{bucket name}/o
    ```

2. Create an OCI Object Store Auth Token

  You need to create an Auth Token for the object store.

3. Create a Database Credential

  Create a private CREDENTIAL object for your user.

4. Load Data from the OCI Object Store to tables in ADB

  You can use the Oracle PL/SQL package DBMS_CLOUD to load data from the OCI Object Store to tables in Oracle database.

  Copy the code snippet to a text editor.

    ```
    <copy>
    /* Replace the <file_uri_base> variable in this file with the URL you copied from your files in OCI Object Storage.*/
    begin
    dbms_cloud.copy_data(
      table_name =>'CHANNELS',
      credential_name =>'OBJ_STORE_CRED',
      file_uri_list =>'<file_uri_base>/<your_data_file>',
      format => json_object('ignoremissingcolumns' value 'true', 'removequotes' value 'true')
    );
    end;
    /
    </copy>
    ```

  Copy and paste your edited file to an Oracle SQL Developer Web worksheet. This script uses the copy\_data procedure of the DBMS_CLOUD package to copy the data from the source files to the target tables you created earlier.
  
  Run the script.

You have successfully loaded the sample tables from Object Storage to ADB.


## Learn More

* [DBMS_CLOUD Documentation](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/dbms-cloud-package.html#GUID-CE359BEA-51EA-4DE2-88DB-F21A9FC10721)
