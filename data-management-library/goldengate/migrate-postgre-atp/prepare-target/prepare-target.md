# Prepare Target ATP

## Introduction

Up to now we have created all of the necessary resources using Terraform in OCI. It is now time to prepare the Target Database, ATP. 

*Estimated lab time*: 10 minutes

### Objectives

We need to create our target tables for our GoldenGate migration and enable GGADMIN for replication to the Autonomous Database.

For a technical overview of this lab step, please watch the following video:

[Technical overview of Preparing Target ATP](youtube:K89v3fprzpg)

### Prerequisites

* This lab assumes that you completed all preceding labs.

## Task 1: Open SQL Developer Web 

1. Go to the top-left hamburger icon, navigate to **Oracle Database** and choose **Autonomous Transaction Processing**. It will show you all available ATP workload type databases. Click on **HOL Target ATP** database.

	![Available ATP workload databases](/images/2-atp.png)

2. In **Tools** tab, where you will see **Database Actions**, click on **Open Database Actions**. You may need to enable a pop-up in your browser if it doesn't open anything.

	![Open database actions.](/images/2-atp-1.PNG)

3. A new sign-in page opens, enter **ADMIN** in Username, when it asks you to enter the password, which is in the terraform output. Go and copy, then paste here.

	![Admin login page.](/images/sql-dev-1.png)

4. In the **DEVELOPMENT** section, click on **SQL**. 

	![Database development SQL selection.](/images/sql-dev-5.png)

## Task 2: Create Target Tables

1. Let's create our target tables for migration. Please download the target table creation script **[from here](./files/create-tables.sql)**. Make sure to save these with the correct extension **.sql** not txt!

2. SQL Developer Web opens a worksheet tab, where you execute queries. Drag your downloaded **CreateTables.sql** file and drop it in the worksheet area. Then run create statements.

	![SQL development workspace.](/images/sql-dev-2.png)

	There should be **5** tables created after script execution.


## Task 3: Enable GGADMIN 

1. Now let's continue to unlock and change the password for Oracle GoldenGate user (ggadmin) in the Autonomous Database. Enable GGADMIN by running the following query.

	```
	<copy>
	alter user ggadmin identified by "GG##lab12345" account unlock;
	</copy>
	```

	![Run the SQL query.](/images/sql-dev-3.png)

2. Let's check whether the parameter `enable_GoldenGate_replicaton` is set to true. 

	```
	<copy>
	select * from v$parameter where name = 'enable_GoldenGate_replication';
	</copy>
	```

	![Check if parameter is set to true.](/images/sql-dev-4.png)
	
	If value is _**FALSE**_ then modify the parameter, else go to next Lab.

	```
	<copy>
	alter system set enable_GoldenGate_replication = true scope=both;
	</copy>
	```

	We successfully enabled GGADMIN in our target Autonomous Database and created target table structures. 

**This concludes this lab. You may now proceed to the next lab.**

## Acknowledgements

* **Author** - Bilegt Bat-Ochir - Senior Solution Engineer
* **Contributors** - John Craig - Technology Strategy Program Manager, Patrick Agreiter - Senior Cloud Engineer
* **Last Updated By/Date** - Bilegt Bat-Ochir 04/04/2022