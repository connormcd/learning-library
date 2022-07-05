# Create and run the Extract and Replicat

## Introduction

This lab walks you through the steps to create and run an Extract, instantiate the target database using Oracle Data Pump, and create and run a Replicat in the Oracle Cloud Infrastructure (OCI) GoldenGate Deployment Console.

Estimated time: 15 minutes

### About Extracts and Replicats

An Extract is a process that extracts, or captures, data from a source database. A Replicat is a process that delivers data to a target database.

### Objectives

In this lab, you will:
* Log in to the OCI GoldenGate deployment console
* Add transaction data and a checkpoint table
* Add and run an Extract
* Add and run a Replicat

### Prerequisites

This lab assumes that you completed all preceding labs, and your deployment is in the Active state.

## Task 1: Log in to the Oracle GoldenGate Deployment Console

1.  Use the Oracle Cloud Console navigation menu to navigate back to GoldenGate.

2.  On the Deployments page, select **GGSDeployment**.

3.  On the Deployment Details page, click **Launch Console**.

    ![Deployment Details page](images/01-03-ggs-launchconsole.png " ")

4.  On the OCI GoldenGate Deployment Console sign in page, enter **oggadmin** for User Name and the password you provided when you created the deployment, and then click **Sign In**.

    ![OCI GoldenGate Deployment Console Sign In](images/01-04.png " ")

    You're brought to the OCI GoldenGate Deployment Console Home page after successfully signing in.

## Task 2: Add Transaction Data and a Checkpoint Table

> **Note:** *Ensure that you enable supplemental logging before adding an Extract or you may encounter errors. If you encounter errors, delete and add the Extract before trying again.*

1.  Open the navigation menu and then click **Configuration**.

    ![Administration Service navigation menu](images/02-01-nav-config.png " ")

2.  Click **Connect to database SourceATP**.

    ![Credentials list with Connect to database SourceATP highlighted](images/02-02-connect-source.png " ")

3.  Next to **TRANDATA Information** click **Add TRANDATA**.

    ![Add TRANDATA](images/02-03-trandata.png " ")

4.  For **Schema Name**, enter **SRC\_OCIGGLL**, and then click **Submit**.

    ![Schema Name field populated with SRC_OCIGGLL](images/02-04-schema-name.png " ")

5.  To verify, click **Search TRANDATA**, and then enter **SRC\_OCIGGLL** into the Search field and click **Search**.

    ![Search icon highlighted](images/02-05-search.png " ")

    ![SRC_OCIGGLL entered in search field and search results returned](images/01-05-trandata.png " ")

6.  Click **Connect to database TargetADW**.

    ![Credentials list with Connect to database TargetADW highlighted](images/02-06.png " ")

7.  Next to Checkpoint, click **Add Checkpoint**.

    ![Add Checkpoint highlighted](images/02-06-add-checkpoint.png " ")

8.  For **Checkpoint Table**, enter **"SRCMIRROR\_OCIGGLL"."CHECKTABLE"**, and then click **Submit**.

    ![Populated Checkpoint table field and submit button highlighted](images/02-07-checktable.png " ")

To return to the GoldenGate Deployment Console Home page, click **Overview** in the left navigation.

## Task 3: Add and Run an Extract

1.  On the GoldenGate Deployment Console Home page, click **Add Extract** (plus icon).

    ![Click Add Extract](images/02-02-ggs-add-extract.png " ")

2.  On the Add Extract page, select **Integrated Extract**, and then click **Next**.

    ![Add Extract page with Integrated Extract highlighted](images/03-02.png " ")

3.  For **Process Name**, enter UAEXT.

4.  For **Trail Name**, enter E1.

    ![Add Extract - Basic Information](images/02-04-ggs-basic-info.png " ")

5.  Under **Source Database Credential**, for **Credential Domain**, select **OracleGoldenGate**.

6.  For **Credential Alias**, select the **SourceATP**.

    ![Add Extract - Source Database Credential](images/02-04-ggs-src-db-credential.png " ")

7.  Under Managed Options, enable **Critical to deployment health**.

    ![Critical to deployment health highlighted](images/03-07.png " ")

8.  Click **Next**.

9.  On the Parameter File page, in the text area, add a new line to the existing text and add the following:

    ```
    <copy>-- Capture DDL operations for listed schema tables
    ddl include mapped

    -- Add step-by-step history of ddl operations captured
    -- to the report file. Very useful when troubleshooting.
    ddloptions report

    -- Write capture stats per table to the report file daily.
    report at 00:01

    -- Rollover the report file weekly. Useful when IE runs
    -- without being stopped/started for long periods of time to
    -- keep the report files from becoming too large.
    reportrollover at 00:01 on Sunday

    -- Report total operations captured, and operations per second
    -- every 10 minutes.
    reportcount every 10 minutes, rate

    -- Table list for capture
    table SRC_OCIGGLL.*;</copy>
    ```

    ![](images/03-09-params.png " ")

10. Click **Create**. You're returned to the OCI GoldenGate Deployment Console Home page.

11. In the UAEXT **Actions** menu, select **Start**. In the Confirm Action dialog, click **OK**.

    ![Start Extract](images/02-12-ggs-start-extract.png)

    The yellow exclamation point icon changes to a green checkmark.

    ![Extract started](images/02-ggs-extract-started.png)

## Task 4: Check for long running transactions

1.  In the source database SQL window, enter the following script, and then click **Run Statement**:

    ```
    <copy>select start_scn, start_time from gv$transaction where start_scn < (select max(start_scn) from dba_capture);</copy>
    ```

    If the query returns any rows, then you must locate the transaction's SCN and then either commit or rollback the transaction.

    ![Run statement and no query results highlighted](images/04-02-sql.png " ")

## Task 5: Export data using Oracle Data Pump (ExpDP)

Before using Oracle Data Pump to export data from the source database, first create an Oracle Object Store bucket, then create yourself a Credential Token, and then use these resources to create a credential in ATP.

1.  From the Oracle Cloud Console navigation menu (hamburger icon), click **Storage**, and then **Buckets**.

    ![Object Storage bucket in Oracle Cloud navigation menu](images/05-01-storage-buckets.png " ")

2.  On the **Buckets in &lt;compartment-name&gt;** page, click **Create Bucket**.

    ![Buckets in compartment page](images/05-02-create-bucket.png " ")

3.  In the **Create Bucket** panel, enter a name, and then click **Create**.

    ![Create Bucket panel](images/05-03-bucket.png " ")

4.  From the list of buckets, click the bucket you created. You're brought to the bucket Details page.

5.  Using the bucket details, formulate and take note of your bucket URI:

    ```
    <copy>https://objectstorage.&lt;region&gt;.oraclecloud.com/n/&lt;namespace&gt;/b/&lt;bucket-name&gt;/o/</copy>
    ```

    For example, if your region is Phoenix, your namespace (tenancy) is c4u04, and your bucket name ADB-LLStore, then your URI would be: `https://objectstorage.us-phoenix-1.oraclecloud.com/n/c4u04/b/ADB-LLStore/o/`.

    To find your &lt;region&gt;, click on the three dots to the right of your bucket, click **Create Pre-Authenticated Request**. In the dialog, you can see your region code to put into the bucket URL.

    ![Find Region Code](images/bucket-region.png " ")

6.  In the Oracle Cloud Console global header, click **Profile** (user icon), and then select your username.

    ![Profile menu](images/05-06-profile.png " ")

7.  On the User Details page, under **Resources**, click **Auth Tokens**, and then click **Generate Token**.

    ![Resources on User Details page](images/05-07-auth-token.png " ")

8.  In the Generate Token dialog, enter a description, and then click **Generate Token**.

    ![Generate Token dialog](images/05-08-generate-token.png " ")

9.  Click **Copy**, and then click **Close**.

    > **Note:** *Paste the token to a text editor for use in the next step.*

    ![Copy highlighted](images/05-09-copy-token.png " ")

10. In the source database SQL window, enter the following script, replace the placeholders with your user name and token value, and then click **Run Statement**:

    ```
    <copy>BEGIN
  DBMS_CLOUD.CREATE_CREDENTIAL(
    credential_name => 'ADB_OBJECTSTORE',
    username => '<user-name>',
    password => '<token>'
  );
END;</copy>
    ```

    > **Note:** If you're using a federated user, then the username should be in the following format: `oracle/<user-name>`


    ![SQL worksheet](images/05-10-create-credential.png " ")

11. Use the following script to create the Export Data job using Oracle Data Pump ExpDP. Ensure that you replace the Object Store URI (`https://objectstorage.<region>.oraclecloud.com/n/<namespace>/b/<bucket-name>/o/`) with **your URI** from step 5. `SRC_OCIGGLL.dmp` is a file that will be created when this script runs.

    ```
    <copy>DECLARE
    ind NUMBER;              -- Loop index
    h1 NUMBER;               -- Data Pump job handle
    percent_done NUMBER;     -- Percentage of job complete
    job_state VARCHAR2(30);  -- To keep track of job state
    le ku$_LogEntry;         -- For WIP and error messages
    js ku$_JobStatus;        -- The job status from get_status
    jd ku$_JobDesc;          -- The job description from get_status
    sts ku$_Status;          -- The status object returned by get_status

    BEGIN
    -- Create a (user-named) Data Pump job to do a schema export.
    h1 := DBMS_DATAPUMP.OPEN('EXPORT','SCHEMA',NULL,'SRC_OCIGGLL_EXPORT','LATEST');

    -- Specify a single dump file for the job (using the handle just returned
    -- and a directory object, which must already be defined and accessible
    -- to the user running this procedure.
    DBMS_DATAPUMP.ADD_FILE(h1,'https://objectstorage.&lt;region&gt;.oraclecloud.com/n/&lt;namespace&gt;/b/&lt;bucket-name&gt;/o/SRC_OCIGGLL.dmp','ADB_OBJECTSTORE','100MB',DBMS_DATAPUMP.KU$_FILE_TYPE_URIDUMP_FILE,1);

    -- A metadata filter is used to specify the schema that will be exported.
    DBMS_DATAPUMP.METADATA_FILTER(h1,'SCHEMA_EXPR','IN (''SRC_OCIGGLL'')');

    -- Start the job. An exception will be generated if something is not set up properly.
    DBMS_DATAPUMP.START_JOB(h1);

    -- The export job should now be running. In the following loop, the job
    -- is monitored until it completes. In the meantime, progress information is displayed.
    percent_done := 0;
    job_state := 'UNDEFINED';
    while (job_state != 'COMPLETED') and (job_state != 'STOPPED') loop
      dbms_datapump.get_status(h1,dbms_datapump.ku$_status_job_error + dbms_datapump.ku$_status_job_status + dbms_datapump.ku$_status_wip,-1,job_state,sts);
      js := sts.job_status;

    -- If the percentage done changed, display the new value.
    if js.percent_done != percent_done
    then
      dbms_output.put_line('*** Job percent done = ' || to_char(js.percent_done));
      percent_done := js.percent_done;
    end if;

    -- If any work-in-progress (WIP) or error messages were received for the job, display them.
    if (bitand(sts.mask,dbms_datapump.ku$_status_wip) != 0)
    then
      le := sts.wip;
    else
      if (bitand(sts.mask,dbms_datapump.ku$_status_job_error) != 0)
      then
        le := sts.error;
      else
        le := null;
      end if;
    end if;
    if le is not null
    then
      ind := le.FIRST;
      while ind is not null loop
        dbms_output.put_line(le(ind).LogText);
        ind := le.NEXT(ind);
      end loop;
    end if;
  end loop;

  -- Indicate that the job finished and detach from it.
  dbms_output.put_line('Job has completed');
  dbms_output.put_line('Final job state = ' || job_state);
  dbms_datapump.detach(h1);
END;</copy>
    ```

    ![SQL worksheet Run Script highlighted](images/05-11.png " ")

## Task 6: Import data using Oracle Data Pump (ImpDP)

Before importing data to the target database, create a credential in the target database to access the exported data file in Oracle Object Store.

1. In the **Oracle Cloud Console**, open the navigation menu (hamburger icon), select **Oracle Database**, and then click **Autonomous Data Warehouse**.

    ![Autonomous Data Warehouse in Oracle Cloud navigation menu](images/06-01.png " ")

2. In the list of Autonomous Data Warehouses, click **TargetADW**.

    ![Autonomous Data Warehouse page](images/06-02.png " ")

3. On the **TargetADW Details** page, click **Database Actions**.

    ![TargetADW Details page](images/database-actions.png " ")

4. Log in to Database Actions as ADMIN, and then click **SQL**.

5. Enter the following script and then click **Run Statement** to create a credential in ADW:

    ```
    <copy>BEGIN
    DBMS_CLOUD.CREATE_CREDENTIAL(
      credential_name => 'ADB_OBJECTSTORE',
      username => '<user-name>',
      password => '<token>'
    );
    END;
    </copy>
    ```

    > **Note:** If you're using a federated user, then the username should be in the following format: `oracle/<user-name>`

    ![Script in SQL Worksheet](images/06-05.png " ")

6.  Enter the following script and then click **Run Statement** to import data using ImpDP:

    ```
    <copy>DECLARE
    ind NUMBER;  -- Loop index
    h1 NUMBER;  -- Data Pump job handle
    percent_done NUMBER;  -- Percentage of job complete
    job_state VARCHAR2(30);  -- To keep track of job state
    le ku$_LogEntry;  -- For WIP and error messages
    js ku$_JobStatus;  -- The job status from get_status
    jd ku$_JobDesc;  -- The job description from get_status
    sts ku$_Status;  -- The status object returned by get_status
    BEGIN

    -- Create a (user-named) Data Pump job to do a "full" import (everything
    -- in the dump file without filtering).
    h1 := DBMS_DATAPUMP.OPEN('IMPORT','FULL',NULL,'SRCMIRROR_OCIGGLL_IMPORT');

    -- Specify the single dump file for the job (using the handle just returned)
    -- and directory object, which must already be defined and accessible
    -- to the user running this procedure. This is the dump file created by
    -- the export operation in the first example.

    DBMS_DATAPUMP.ADD_FILE(h1,'https://objectstorage.<region>.oraclecloud.com/n/<namespace>/b/<bucket-name>/o/SRC_OCIGGLL.dmp','ADB_OBJECTSTORE',null,DBMS_DATAPUMP.KU$_FILE_TYPE_URIDUMP_FILE);


    -- A metadata remap will map all schema objects from SRC_OCIGGLL to SRCMIRROR_OCIGGLL.
    DBMS_DATAPUMP.METADATA_REMAP(h1,'REMAP_SCHEMA','SRC_OCIGGLL','SRCMIRROR_OCIGGLL');

    -- If a table already exists in the destination schema, skip it (leave
    -- the preexisting table alone). This is the default, but it does not hurt
    -- to specify it explicitly.
    DBMS_DATAPUMP.SET_PARAMETER(h1,'TABLE_EXISTS_ACTION','SKIP');

    -- Start the job. An exception is returned if something is not set up properly.
    DBMS_DATAPUMP.START_JOB(h1);

    -- The import job should now be running. In the following loop, the job is
    -- monitored until it completes. In the meantime, progress information is
    -- displayed. Note: this is identical to the export example.
    percent_done := 0;
    job_state := 'UNDEFINED';
    while (job_state != 'COMPLETED') and (job_state != 'STOPPED') loop
      dbms_datapump.get_status(h1,
        dbms_datapump.ku$_status_job_error +
        dbms_datapump.ku$_status_job_status +
        dbms_datapump.ku$_status_wip,-1,job_state,sts);
        js := sts.job_status;

      -- If the percentage done changed, display the new value.
      if js.percent_done != percent_done
      then
        dbms_output.put_line('*** Job percent done = ' ||
        to_char(js.percent_done));
        percent_done := js.percent_done;
      end if;

      -- If any work-in-progress (WIP) or Error messages were received for the job, display them.
      if (bitand(sts.mask,dbms_datapump.ku$_status_wip) != 0)
      then
        le := sts.wip;
      else
        if (bitand(sts.mask,dbms_datapump.ku$_status_job_error) != 0)
        then
          le := sts.error;
        else
          le := null;
        end if;
      end if;
      if le is not null
      then
        ind := le.FIRST;
        while ind is not null loop
          dbms_output.put_line(le(ind).LogText);
          ind := le.NEXT(ind);
        end loop;
      end if;
    end loop;

    -- Indicate that the job finished and gracefully detach from it.
    dbms_output.put_line('Job has completed');
    dbms_output.put_line('Final job state = ' || job_state);
    dbms_datapump.detach(h1);
    END;</copy>
    ```

    ![Run script highlighted](images/06-06.png " ")

## Task 7: Add and run the Replicat

1.  On the GoldenGate Deployment Console Home page, click **Add Replicat** (plus icon).

    ![GoldenGate Deployment Console Home page](images/03-01-ggs-add-replicat.png)

2.  On the Add Replicat page, select **Nonintegrated Replicat**, and then click **Next**.

    ![Add Replicat page](images/07-02.png " ")

3.  On the Replicat Options page, for **Process Name**, enter **Rep**.

4.  For **Credential Domain**, select **OracleGoldenGate**.

5.  For **Credential Alias**, select **TargetADW**.

6.  For **Trail Name**, enter E1.

7.  For **Checkpoint Table**, select **"SRCMIRROR_OCIGGLL","CHECKTABLE"**.

    ![Add Replicat - Basic Information](images/07-07.png " ")

8.  Under **Managed Options**, enable **Critical to deployment health**, and then click **Next**.

    ![Critical to deployment health highlighted](images/07-08.png " ")

9.  In the **Parameter File** text area, replace **MAP \*.\*, TARGET \*.\*;** with the following script:

    ```
    <copy>-- Capture DDL operations for listed schema tables
    --
    ddl include mapped
    --
    -- Add step-by-step history of ddl operations captured
    -- to the report file. Very useful when troubleshooting.
    --
    ddloptions report
    --
    -- Write capture stats per table to the report file daily.
    --
    report at 00:01
    --
    -- Rollover the report file weekly. Useful when PR runs
    -- without being stopped/started for long periods of time to
    -- keep the report files from becoming too large.
    --
    reportrollover at 00:01 on Sunday
    --
    -- Report total operations captured, and operations per second
    -- every 10 minutes.
    --
    reportcount every 10 minutes, rate
    --
    -- Table map list for apply
    --
    DBOPTIONS ENABLE_INSTANTIATION_FILTERING;
    MAP SRC_OCIGGLL.*, TARGET SRCMIRROR_OCIGGLL.*;</copy>
    ```

    ![Add Replicat - Parameter File](images/07-09.png " ")

    > **Note:** *'DBOPTIONS ENABLE\_INSTATIATION\_FILTERING' enables CSN filtering on tables imported using Oracle Data Pump. For more information, see [DBOPTIONS Reference](https://docs.oracle.com/pls/topic/lookup?ctx=en/cloud/paas/goldengate-service/using&id=GWURF-GUID-BA8C0CED-D87F-4106-862E-4AD22D910160).*

10.  Click **Create**.

11. In the REP Replicat **Action** menu, select **Start**.

    The yellow exclamation point icon changes to a green checkmark.

## Learn more

* [Creating an Extract](https://docs.oracle.com/en/cloud/paas/goldengate-service/using/goldengate-deployment-console.html#GUID-3B004DB0-2F41-4FC2-BDD4-4DE809F52448)
* [Creating a Replicat](https://docs.oracle.com/en/cloud/paas/goldengate-service/using/goldengate-deployment-console.html#GUID-063CCFD9-81E0-4FEC-AFCC-3C9D9D3B8953)

## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Denis Gray, Database Product Management; Arabella Yao, Database Product Management
* **Last Updated By/Date** - Arabella Yao, May 2022
