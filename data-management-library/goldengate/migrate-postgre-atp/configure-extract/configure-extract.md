# Configure Extract Processes

## Introduction

With Oracle GoldenGate Classic for PostgreSQL, you can perform initial loads and capture transactional data from supported PostgreSQL versions. You can replicate the data to a PostgreSQL database or other supported Oracle GoldenGate targets, such as an Oracle Database. 

*Estimated lab time*: 30 minutes

### Objectives

We have created a source database and pre-loaded it with some sample data during lab 1 using terraform script. 

In this lab, we will configure _**three extract**_ processes within Oracle GoldenGate classic deployment for PostgreSQL.

-	An extract for **changed data capture**. Exttab process will start capturing changes and this will create some files called trails.
-	An extract for **sending those captured files** to GoldenGate Microservices. Extdmp will be pumping trail files.
-	An Initial-Load extract. While changes are being captured, the migration step needs a special type of extract and replicat process, this is cold data. Usually, after the initial load finishes, we will be applying the captured changed rows during the initial load.

	![Animation of data extract process to Oracle Autonomous Database](/images/general.gif)

For a technical overview of this lab step, please watch the following video:

[Video technical overview of lab steps](youtube:weupxqyBVoU)

### Prerequisites

* This lab assumes that you completed all preceding labs.

## Task 1: Connect to Microservices Instance

1. We need to enable network access to Microservices from our GoldenGate Classic instance. Without adding the ports to the Microservices' firewall, it would cause failure in the next step. Let's make a console connection to the Microservices instance, copy the IP address of `OGG_Microservices_Public_ip` from your note and connect using below ssh command.

	```
	<copy>
	ssh opc@your_microservice_ip_address -i ~/.ssh/oci
	</copy>
	```
	When you are connecting to a compute instance for the first time, you will see the question **Are you sure you want to continue connecting (yes/no)?**. Enter **yes**.
	
2. Once you are there run the below commands, which will add the necessary ports.

	```
	<copy>
	sudo firewall-cmd --zone=public --permanent --add-port=9011-9014/tcp

	sudo firewall-cmd --zone=public --permanent --add-port=9021-9024/tcp

	sudo firewall-cmd --zone=public --permanent --add-port=443/tcp

	sudo firewall-cmd --zone=public --permanent --add-port=80/tcp

	sudo firewall-cmd --zone=public --permanent --add-port=7809-7810/tcp

	sudo firewall-cmd --reload
	
	</copy>
	```

3. Exit from this instance with command **`exit`** and go back to your cloud-shell.

## Task 2: Access to GoldenGate Classic Instance

1. Oracle GoldenGate Classic for Non-Oracle (PostgreSQL) allows you to quickly access the GoldenGate Service Command Interface (GGCSI) and is preconfigured with a running Manager process. Copy the IP address of `OGG_PGSQL_Public_ip` from your note and connect using next command.

	```
	<copy>
	ssh opc@your_ogg_pgsql_ip_address -i ~/.ssh/oci
	</copy>
	```
	When you are connecting to a compute instance for the first time, you will see the question **Are you sure you want to continue connecting (yes/no)?**. Enter **yes**.
	
## Task 3: Run GGSCI 

1. After logging in to the compute node, you need to make sure your GoldenGate environment knows about the current odbc driver. Execute the following commands separately in your cloud-shell:

	```
	<copy>
	export ODBCINI=/home/opc/postgresql/odbc.ini

	cd /usr/local/bin/
	</copy>
	```
	This odbc.ini file contains your source database information. Terraform has created this file for you, however, make sure you create it using [official guide](https://docs.oracle.com/en/middleware/goldengate/core/21.3/gghdb/preparing-database-oracle-goldengate-postgresql.html#GUID-D995917F-3773-4B50-8897-9E33329DF352) if you are going to follow this lab for your own environment
2. Then run the below command to start GGSCI:

	```
	<copy>
	./ggsci
	</copy>
	```

	![Animation of Cloud Shell environment.](/images/gg-pg-config-2.gif)

## Task 4: Create GoldenGate Directories 

1. We need to create our work directories in GoldenGate before we start working. The below command creates the default directories within the Oracle GoldenGate home directory. When you are in GGSCI console, run the below command to create your directories.

	```
	<copy>
	CREATE SUBDIRS
	</copy>
	```

## Task 5: Edit GoldenGate Manager Port

1. We need to set the manager’s port to start the GoldenGate manager process. To do so, issue:

	```
	<copy>
	EDIT PARAMS MGR
	</copy>
	```

2. It will open the parameter file of the manager process and enter the below port value and save it.

	```
	<copy>
	PORT 7809
	</copy>
	```
	_**NOTE:** Editing uses **vi** editor, you have to press key **i** to edit. When you are done editing press **esc** button and press **:wq** keys, then **hit enter** for save & quit._

## Task 6: Start GoldenGate Manager

1. Now start GoldenGate manager process by issuing the below command:

	```
	<copy>
	START MGR
	</copy>
	```

2. You can check manager status by issuing **`INFO MGR`** command.

	![Animation of Cloud Shell outputs.](/images/gg-pg-config-3.gif)

## Task 7: Connect to Source DB

1. Run the following command to log into the database from GoldenGate instance:

	```
	<copy>
	DBLOGIN sourcedb PostgreSQL USERID postgres PASSWORD postgres
	</copy>
	```

2. You should be able to see below information saying *Successfully Logged into database*

	![Output showing successful login to database.](/images/gg-pg-dblogin.png)

	Now you are logged into the source database from GGSCI console, which means you are ready to proceed. Remember that we need to create three extract processes and we have five tables in the source PostgreSQL database.

## Task 8: Enabling Supplemental Logging

1. After logging into the source database, you must enable supplemental logging on the source schema for change data capture. The following commands are used to enable supplemental logging at the table level.

	```
	<copy>
	add trandata public."Countries"
	add trandata public."Cities"
	add trandata public."Parkings"
	add trandata public."ParkingData"
	add trandata public."PaymentData"
	</copy>
	```

	![Commands to enable supplemental logging at table level.](/images/gg-pg-trandata.png)

## Task 9: Registering EXTTAR

Oracle GoldenGate needs to register an extract with the database replication slot before adding the extract process. Let's begin to create the first extract process, which is continuous replication in the usual migration and replication project scenario. _**Ensure that you are connected to SourceDB using the DBLOGIN command**_ before doing the next steps.

1. First register your extract:

	```
	<copy>
	register extract exttar
	</copy>
	```

	![Register your extract.](/images/gg-pg-exttar-0.png)

2. Then edit extract configuration with the below:

	```
	<copy>
	edit params exttar
	</copy>
	```

	![Edit extract configuration.](/images/gg-pg-exttar-1.png)

3. Insert the below as your exttar parameter and save.

	```
	<copy>
	EXTRACT exttar
	SOURCEDB PostgreSQL USERID postgres PASSWORD postgres
	EXTTRAIL ./dirdat/pd
	TABLE public."Countries";
	TABLE public."Cities";
	TABLE public."Parkings";
	TABLE public."PaymentData";
	TABLE public."ParkingData";
	</copy>
	```

	_**NOTE:** Editing uses **vi** editor, you have to press key **i** to edit. When you are done editing press **esc** button and press **:wq** keys, then **hit enter** for save & quit._

4. To create your extract process issue below commands:

	```
	<copy>
	add extract exttar, tranlog, begin now
	</copy>
	```
	
	```
	<copy>
	add exttrail ./dirdat/pd, extract exttar
	</copy>
	```

	![Create extract process.](/images/gg-pg-exttar-2.png)

5. Confirm everything is correct then start the extract process.

	```
	<copy>
	start exttar
	</copy>
	```

	![Output confirming extract process is correct.](/images/gg-pg-exttar-3.png)

6. After completing this, you should be able to check the status of the extract with **`info all`** command and the result should show the **RUNNING** state.

	![Output showing running state extract status.](/images/gg-pg-exttar.png)

	This process is capturing change data from your source database. As it was mentioned earlier, this is a necessary step for a continuous replication project. 

## Task 10: Registering EXTDMP

Now changes are being captured from the source database and we need to send them to GG microservices in order to apply to the target database. Therefore we need another process, which acts as an extract but sends existing trail files to GG microservices. This is also known as a pump process. _**Ensure that you are connected to the source database using the DBLOGIN command**_ before doing the next steps.

1. Again, register your pump "extdmp" extract.

	```
	<copy>
	register extract extdmp
	</copy>
	```

	![Register your extract.](/images/gg-pg-extdmp-0.png)

2. Similar to previous step, edit extract configuration with the below:

	```
	<copy>
	edit params extdmp
	</copy>
	```

	![Edit extract configuration.](/images/gg-pg-extdmp-1.png)

2. Insert below as your extdmp parameter, and **make sure** you must change _**ip address**_ with your GoldenGate Microservice's IP Address! Why? Because we will send extracted records to Microservice.

	```
	<copy>
	EXTRACT extdmp
	RMTHOST ip_address, PORT 9023
	RMTTRAIL pd
	PASSTHRU
	TABLE public."Countries";
	TABLE public."Cities";
	TABLE public."Parkings";
	TABLE public."PaymentData";
	TABLE public."ParkingData";
	</copy>
	```

	_**NOTE:** Editing uses **vi** editor, you have to press key **i** to edit. When you are done editing press **esc** button and press **:wq** keys, then **hit enter** for save & quit._

3. To create your extract process, issue the below commands.

	```
	<copy>
	add extract extdmp, exttrailsource ./dirdat/pd
	</copy>
	```
	
	```
	<copy>
	add rmttrail pd, extract extdmp, megabytes 50
	</copy>
	```

	![Commands to create extract process.](/images/gg-pg-extdmp-2.png)

4. Confirm everything is correct then start this extract by issuing below command.

	```
	<copy>
	start extdmp
	</copy>
	```

	![Command to start extract process.](/images/gg-pg-extdmp-3.png)

5. After completing this, you should be able to see the status of the extract with **`info all`** command and the result should show you **RUNNING** state.

	![Output showing running extract status.](/images/gg-pg-extdmp.png)

	The **EXTTAR** process is capturing your changes at your source database, however, it was only kept locally in the GoldenGate instance.

	Then we created the **EXTDMP** process, which is pumping the captured trail files to GoldenGate Microservices instance. 
	
	We will check them if working properly in the next lab. These two processes are preparation for change synchronization for continuous replication.


## Task 11: Registering INITLOAD

Up to now, we created 2 extract processes that are now capturing changes and shipping to the Goldengate Microservices instance. However, we have not yet loaded our static data directly from our source objects to a target database. This specific process is called Initial-load. Steps are similar to the previous extract processes. _**Ensure that you are connected to the source database using the DBLOGIN command**_ before doing the next steps.

1. Register your initial load.

	```
	<copy>
	register extract init
	</copy>
	```

	![Register initial load.](/images/gg-pg-initload-0.png)

1. To edit initial load configuration, issue below.

	```
	<copy>
	edit params init
	</copy>
	```

	![Edit initial load configuration.](/images/gg-pg-initload-1.png)

2. Insert the below as your initial load parameter, and **make sure** you must change _**ip address**_ with your GG Microservice's IP Address! Why? Because we will send extracted records to Microservice.

	```
	<copy>
	EXTRACT init
	SOURCEDB PostgreSQL USERID postgres PASSWORD postgres
	RMTHOST ip_address, PORT 9023
	RMTFILE il
	TABLE public."Countries";
	TABLE public."Cities";
	TABLE public."Parkings";
	TABLE public."PaymentData";
	TABLE public."ParkingData";
	</copy>
	```

	_**NOTE:** Editing uses **vi** editor, you have to press key **i** to edit. When you are done editing press **esc** button and press **:wq** keys, then **hit enter** for save & quit._

3. After that add your initial load process. The extract process captures a current set of static data directly from the source objects in preparation for an initial load to another database. SOURCEISTABLE type does not use checkpoints.

	```
	<copy>
	add extract init, sourceistable
	</copy>
	```

	![Output showing using sourceistable type.](/images/gg-pg-initload-2.png)

4. Confirm everything is correct then start the initial load by issuing the below command.

	```
	<copy>
	start init
	</copy>
	```

	![Start the initial load.](/images/gg-pg-initload-3.png)

5. You can see status of this special type of extract process with **`info init`**.

	![Status of extract process.](/images/gg-pg-initload.png)

	Note that the number of records is 10000 and the status is already STOPPED. Because our sample data has only 5 tables and a few records, the initial load will take only a few seconds.

6. You can see more information about extract process with the below.

	```
	<copy>
	view report init
	</copy>
	```

	![Output showing report about the extract process.](/images/gg-pg-initload-report.png)

	This is a good way to investigate your GoldenGate process result. You can see some statistics at the end of this report. 
	As soon as the initial load process as finished and you have loaded to target database, you need to start applying the captured change data in your target database.

**This concludes this lab. You may now [proceed to the last lab](#next).**

## Acknowledgements

* **Author** - Bilegt Bat-Ochir - Senior Solution Engineer
* **Contributors** - John Craig - Technology Strategy Program Manager, Patrick Agreiter - Senior Cloud Engineer
* **Last Updated By/Date** - Bilegt Bat-Ochir 04/04/2022