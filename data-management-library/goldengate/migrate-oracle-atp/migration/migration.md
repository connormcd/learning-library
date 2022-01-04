# Migrate HR database

## Introduction

Up to now, we have created all of the necessary resources using Terraform in OCI. It is now time to prepare the Target Database, the Autonomous Database.

Many Oracle Cloud Infrastructure (OCI) GoldenGate customers overlook the need to ensure that the source and target database schemas to be replicated are in sync before replicating the data. GoldenGate’s underlying architecture for data replication ensures 100% consistency for all changes that occur on the source database. For each change on the source, such as an update or delete, GoldenGate guarantees the transaction was completed on the target. If the data didn’t exist on the target for an update or delete, then the replication of the transaction will fail and stop with an abnormal error. Usually, first-time GoldenGate users don’t understand this guaranteed consistency architecture and expect that GoldenGate would ignore these errors by default. However, if this was the case, then the target data would never match the source data.

For the purposes of this lab, the source database is an on-premise 12c database and the target is Autonomous database.  There are seven source tables in HR schema and each table and associated resources, such as primary key constraints, will be created in the target schema as part of the target instantiation.

To complete the lab, we will configure _**two extract**_ processes at the source database and _**two replicat**_ processes at the target database:

* An extract for **changed data capture**. This process will start by capturing changes also create some files called trail files. We will use these files after the initial load finish at the target database. Let's call it **the primary extract** during this workshop.

* We will connect to the source database and retrieve the oldest available System Change Number (SCN) using SQLPlus connection. This SCN will be used to the instantiation SCN, in other words, it means we will export database rows until that given SCN.

* The migration step needs another 'special' type of extract process while changes are being captured by the first extract process from the source database. This 'special' process is called the **Initial-Load extract**. It captures data from a specified list of tables and later will be loaded into target database tables using the SCN.

	> **NOTE:** This is very simple initial-load method for purpose of this lab, because our source database size is small. The Oracle Database expdp and impdp are fully documented in the Oracle Documentation and it is preferred method of instantiation. You may also use [official instantiation document for this type of initial load](https://docs.oracle.com/en/middleware/goldengate/core/19.1/admin/instantiating-oracle-goldengate-initial-load.html#GUID-3AA4446C-6875-40BC-9944-006435FCF240)

* When the initial-load extract finishes at the source, we will create the first replicat process to apply those changes. We will call it **Initial-Load replicat**, it is responsible for populating the target database using extracted data by the initial-load extract.

* The second replicat is for applying **changed data**. We will call it **the primary replicat**. Once the first replicat process, the initial-load finish, we will create a replicat process for applying changed data captured during the initial load to the target database. But how do we know from which starting point we start to replicate? How do we ensure there are no duplicates?
We will start applying changes after the **same SCN** we used for the initial-load extract. This is the instantiation SCN we used to mark the starting point for the replicat process.

*Estimated time*: 15 minutes

### Objectives

We will complete the below tasks:
* Add the extracts and replicats processes
* Add transaction data and a checkpoint tables
* Capture System Change Number (SCN) from the source database
* Configure continuous replication and do the migration

### Prerequisites

* This lab assumes that you completed all preceding labs.

## **Task 1**: Log in to OCI GoldenGate Deployment

1. Click the left-top hamburger icon, navigate to **Oracle Database** and choose **GoldenGate**. The page will list all available GoldenGate deployments. Click on **_`HOL_GG_Service`_**, this is what terraform has been created in the first lab.

	![](/images/3.goldengate.png)

2. Then click on **Launch Console** button, this will open in a new tab.

	![](/images/3.goldengate-0.png)

3. On the OCI GoldenGate Deployment Console sign-in page, please provide **_`oggadmin`_** in User Name and password is _**`CloudStars#123`**_ then sign in.

	![](/images/3.goldengate-1.png)

	You successfully have signed in GoldenGate Deployment Console.

## **Task 2**: Source Database Configuration

1.  You should see the empty Administration dashboard. Let's configure our source and target database for the extract and replication processes. Open the hamburger menu on the top-left corner, choose **Configuration**.

	![](/images/3.goldengate-config.png)

2. You can see that our Source and Target databases have already been added here. It is because we did database registration in the first lab using Terraform automation. Click on **Connect to database. source12** icon in the Action column.

	![](/images/3.goldengate-config-source.png)

3. Scroll down to the **Checkpoint** and click on **+** icon, then provide **_`ggadmin.chkpt`_** and click **SUBMIT**.

	![](/images/3.goldengate-config-source-0.png)

	The checkpoint table contains the data necessary for tracking the progress of capture process from source database's transactions.

4. Now let's add trandata for HR schema, right below the checkpoint, find **TRANDATA Information**. Make sure you choose **Schema** option then click on the **+** icon. Enter **_`HR`_** in the **Schema Name**, then click submit to save. This will enable trandata for all objects in the HR schema.

	![](/images/3.goldengate-config-source-trandata.png)

5. You will see the **Successfully added Trandata!** notification when you click on a bell icon located at the left-top corner.

	![](/images/3.goldengate-config-source-trandata-notification.png)

	However, you can verify it by your choice, enter **HR** in the search field and click on the search icon.

	![](/images/3.goldengate-config-source-trandata-check.png)

	The result will verify that you have prepared seven tables for trandata instantiation in HR schema. These are necessary steps for the source database.

## **Task 3**: Target Database Configuration

1.  It is time to configure the target database. Similar to **Step 2**, click on **Connect to database. target19** icon in the available databases.

	![](/images/3.goldengate-config-target.png)

3. Scroll down to the **Checkpoint** and click on **+** icon, then provide **_`ggadmin.chkpt`_** and **SUBMIT**.

	![](/images/3.goldengate-config-target-0.png)

	The checkpoint table contains the data necessary for tracking the progress of the Replicat as it applies transactions to the target system. Regardless of the Replicat that is being used, it is best practice to enable the checkpoint table for the target system.

4. Now let's go back to the Administration server overview, open the hamburger menu on the top-left corner, choose **Overview**.

## **Task 4**: Configure Primary Extract at The Source Database.

1. This is the first and primary extract, or should I say continuous extract process to initiate change data capture. In the administration server, click the **+** icon for adding the extract.

	![](/images/3.goldengate-ext-0.png)

2. On the Add Extract page, select **Integrated Extract**, and then click Next.

	![](/images/3.goldengate-ext-1.png)

3. Please provide **_`extprim`_** as it is our primary extract in  **Process Name**, and **_`ex`_** in **Trail Name**, then click Next.

	![](/images/3.goldengate-ext-2.png)

4. Scroll down to **Source Database Credential**, then click on the **Credentials Domain** drop-down list and choose **OracleGoldenGate**. In the **Credential Alias**, choose **source12** from the drop-down list. Click **Next** button.

	![](/images/3.goldengate-ext-3.png)

5. OCI GoldenGate created a draft parameter file for your convenience. Add the below line after the last line of the existing draft parameter:

	```
	<copy>
	MAP HR.COUNTRIES, TARGET HR.COUNTRIES;
	MAP HR.DEPARTMENTS, TARGET HR.DEPARTMENTS;
	MAP HR.EMPLOYEES, TARGET HR.EMPLOYEES;
	MAP HR.JOBS, TARGET HR.JOBS;
	MAP HR.JOB_HISTORY, TARGET HR.JOB_HISTORY;
	MAP HR.LOCATIONS, TARGET HR.LOCATIONS;
	MAP HR.REGIONS, TARGET HR.REGIONS;
	</copy>
	```

	Parameter file should be looking like the below image.

	![](/images/3.goldengate-ext-4.png)

6. Make sure everything is correct until this stage. Click **Create and Run** to start our extract.

	![](/images/3.goldengate-ext-5.png)

	> **NOTE:** You need to make sure [purge old trail files](https://docs.oracle.com/en/middleware/goldengate/core/21.3/ggmas/working-data-replications.html#GUID-41771EA7-8C7B-40D9-80EF-AF4DC0CA2FB5) in production scenario. The Purge Trail page works the same way as the Manager `PURGEOLDEXTRACTS` parameter in the Classic Architecture. It allows you to purge trail files when Oracle GoldenGate has finished processing them. Automating this task ensures that the trail files are periodically deleted to avoid excessive consumption of disk space.

## **Task 5**: Get the SCN from The Source Database

1. Remember that we copied the terraform output? Go and find the IP address of `Source_DB_Public_IP` from your note and connect to the source database using sqlplus connection. Modify the below line with your IP address, then run in your cloud shell.

	```
	<copy>
	sqlplus ggadmin/GG##lab12345@ip_address_source_database:1521/ORCL
	 </copy>
	```

	> **NOTE:** Make sure you replace _`ip_address_source_database`_ with your IP address for successful connection.

2. You will be successfully connected to your source database, then run the below command to get the SCN:

	```
	<copy>
	SELECT MIN(SCN) AS INSTANTIATION_SCN FROM
	(SELECT MIN(START_SCN) AS SCN FROM V$TRANSACTION UNION All
	SELECT CURRENT_SCN FROM V$DATABASE);
	</copy>
	```

3. Copy the SCN output! The below image shows the successful output. In this workshop, SCN is **1667664**. We will also use this in the last step.

	![](/images/3.goldengate-ext-scn-1.png)

## **Task 6**: Configure the Initial-Load Extract at the Source Database.

1. Let's go back to the GoldenGate deployment console. In the administration server, click the **+** icon for adding the extract. This is the second and initial-load extract, which will extract all rows in tables into a file.

	![](/images/3.goldengate-ext-6.png)


2. On the Add Extract page, select **Initial Load Extract**, and then click Next.

	![](/images/3.goldengate-ext-7.png)

3. In **Process Name**, please provide **_`initload`_** because this initial load extract, and then click Next.

	![](/images/3.goldengate-ext-8.png)

4. Open a notepad, and replace _xxxxxx_ in the below parameter with your SCN output:

	```
	<copy>
	USERIDALIAS source12 DOMAIN OracleGoldenGate
	ExtFile ix Megabytes 2000 Purge
	TABLE HR.*, SQLPredicate "As Of SCN xxxxxxx";
	</copy>
	```

5. Then modify the initload parameter file should be looking like the below image.

	![](/images/3.goldengate-ext-9.png)

6. Make sure everything is correct until this stage. Click **Create and Run** to start our extract.

	![](/images/3.goldengate-ext-5.png)

7. In the overview dashboard, you should see **initload** extract is stopped. Click on **Action** button, choose **Details**. Initial-load takes only a matter of seconds to finish sample 7 tables. You can see actual extract process details in the **Report** tab. Please refer to the below recording for your reference of this step.

	![](/images/3.goldengate-initial-load-1.gif)

	_RECAP:_ So far, we have configured two extract processes. EXTPRIM is capturing change data and INITLOAD captured every row of the source seven tables. Now we need to create two replicat processes for these two extracts.

## **Task 7**: Configure the Initial-Load Replicat at the Target Database.

1. The process for initial load replication is simple and easy to configure. There are four types of Replicats supported by OCI GoldenGate. Go to the Replicat part and click on the **+** icon to create our replicat process on the overview page,

	![](/images/3.goldengate-repload-0.png)

2. We will choose **Non-Integrated Replicat** for initial load, click **Next**. In non-integrated mode, the Replicat process uses standard SQL to apply data directly to the target tables. In our case, the number of records in the source database is small and we don't need to run in parallel, therefore it will suffice.

	![](/images/3.goldengate-repload-1.png)

3. Provide a name for the replicat process, for example, **_`repload`_**, because this will be our initial-load replicat process.

	![](/images/3.goldengate-repload-2-1.png)

4. Scroll down to **Credentials Domain**, choose **OracleGoldenGate** from drop-down list. In the **Credential Alias**, choose **target19** from the drop-down list.

	![](/images/3.goldengate-repload-2-2.png)

5. Scroll below and find Trail Name, add _**ix**_ as trail name in the field. Because we configured trail file name to `ix` in the **initload** process's parameter, therefore it _**cannot**_ be just a random name.

	![](/images/3.goldengate-repload-2-3.png)

6. Choose a **Checkpoint Table** from the drop-down list. It is **GGADMIN.CHKPT** in our case. Review everything then click **Next**

	![](/images/3.goldengate-repload-2-4.png)

7. OCI GoldenGate created a draft parameter file, replace the below line from the existing draft parameter:

	```MAP *.*, TARGET *.*```

	with the following lines:

	```
	<copy>
	MAP HR.REGIONS, TARGET HR.REGIONS;
	MAP HR.COUNTRIES, TARGET HR.COUNTRIES;
	MAP HR.LOCATIONS, TARGET HR.LOCATIONS;
	MAP HR.JOBS, TARGET HR.JOBS;
	MAP HR.JOB_HISTORY, TARGET HR.JOB_HISTORY;
	MAP HR.EMPLOYEES, TARGET HR.EMPLOYEES;
	MAP HR.DEPARTMENTS, TARGET HR.DEPARTMENTS;
	</copy>
	```

	Correct parameter file should be looking like the below image.

	![](/images/3.goldengate-repload-3.png)

8. Click **Create and Run** to start our replicat.

	![](/images/3.goldengate-ext-5.png)

9. Similar to the extract processes, go and see the detail of the **repload** process. In the statistics tab, you will see how many rows were inserted by the repload process. You can also check more detailed information in the Report tab.

	![](/images/3.goldengate-repload-report.png)

## **Task 8**: Run Update Statement at The Source Database.

1. Okay, now let's make some changes in the source database to make this migration closer to a real-life scenario. Open your cloud shell and run the below to enter the working directory.

	```
	<copy>
	cd ~/oci_gg_cloud_service
	</copy>
	```

2. Then run the below to make some changes at the source database.

	```
	<copy>
	sqlplus hr/GG##lab12345@ip_address_source_database:1521/ORCL @update.sql
	</copy>
	```

	> **NOTE:** Make sure you replace _`ip_address_source_database`_ with your IP address for successful connection.

	This statement updates a row in the countries table. Also, it must be captured by the **EXTPRIM** process. We now need to create the second replicat process to apply these captured changes at the source to the target database.

	![](/images/3.goldengate-repcont-update.png)

## **Task 9**: Configure The Continuous Replicat at The Target Database.

1. Go to the Replicat part and click on the **+** icon to create our continuous replicat process on the overview page,

	![](/images/3.goldengate-repcont-0.png)

2. We will choose **Non-Integrated Replicat** for initial load, click **Next**.

	![](/images/3.goldengate-repcont-1.png)

3. Provide a name for the replicat process, for example, **_`REPCONT`_**, because this will be our continuous replication process.

	![](/images/3.goldengate-repcont-2-1.png)

4. Scroll down to **Credentials Domain**, choose **OracleGoldenGate** from drop-down list. In the **Credential Alias**, choose **target19** from the drop-down list.

	![](/images/3.goldengate-repcont-2-2.png)

5. Scroll below and find **Trail Name**, add _**ex**_ as trail name in the field. Because we defined this in the **EXTPRIM** process, so it _**cannot**_ be a random name.

	![](/images/3.goldengate-repcont-2-3.png)

6. Choose a **Checkpoint Table** from the drop-down list. It is **GGADMIN.CHKPT** in our case. Review everything then click **Next**

	![](/images/3.goldengate-repcont-2-4.png)

7. Again, replace the below line from the existing draft parameter:

	```MAP *.*, TARGET *.*```

	with the following lines:

	```
	<copy>
	MAP HR.REGIONS, TARGET HR.REGIONS;
	MAP HR.COUNTRIES, TARGET HR.COUNTRIES;
	MAP HR.LOCATIONS, TARGET HR.LOCATIONS;
	MAP HR.JOBS, TARGET HR.JOBS;
	MAP HR.JOB_HISTORY, TARGET HR.JOB_HISTORY;
	MAP HR.EMPLOYEES, TARGET HR.EMPLOYEES;
	MAP HR.DEPARTMENTS, TARGET HR.DEPARTMENTS;
	</copy>
	```

	Correct parameter file should be looking like the below image.

	![](/images/3.goldengate-repcont-3.png)

8. Now do not click run, just choose **Create**. Because we need to add **SCN** to start synchronization.

	![](/images/3.goldengate-repcont-4.png)

9. From the replicats area, find **REPCONT** and click on **Action**. You need to select _**Start with Options**_ here. By doing this, you'd be able to provide **SCN** information. Because initial-load process extracted data as of **SCN** that we captured from database then populated our target database. Therefore, the **REPCONT** replicat should start after that point in time.  It will make sure the source and target are consistent.

	![](/images/3.goldengate-repcont-5.png)

10. Choose **After CSN** from Start Point, and provide the SCN you retrieved in Step 6 into the **CSN**. In this workshop case, 1667664 was the SCN number I used for the initial-load replicat. As we explained, it makes sense to start our replication after this SCN number. Otherwise, there can be some duplicate records, which will cause the replicat process to abend! Now click **Start**

	![](/images/3.goldengate-repcont-6.png)

	> **NOTE:** We captured System Change Number (SCN) from the source database, which increments whenever commit occurs. In GoldenGate terminology Commit Sequence Number (CSN) identifies a point in time when the transaction commits. Different naming, but same concept._

11. You can open the **REPCONT** extract process and navigate to the statistics tab, where you will find if **REPCONT** applied the change data from the **EXTPRIM** replicat.

	![](/images/3.goldengate-repcont-7.png)

	Congratulations! You have completed this workshop!

	You successfully migrated the Oracle 12c on-premises database to Oracle Autonomous Database in OCI. If you wish to continue to migrate a sample HR application, please proceed to the next Bonus lab.

## Acknowledgements

* **Author** - Bilegt Bat-Ochir - Senior Solution Engineer
* **Contributors** - Tsengel Ikhbayar - GenO Lift Implementation
* **Last Updated By/Date** - Bilegt Bat-Ochir 18/09/2021
