# Getting Started with MySQL Database Service High Availability and HeatWave
![INTRO](./images/00_mds_heatwave_2.png " ")


## Introduction

In this hands-on workshop, you will be introduced to MySQL Database Service (MDS), a powerful union between MySQL Enterprise Edition and Oracle Cloud Infrastructure. You will learn how to create and use three different instances of MySQL Database Service Systems, Standalone, High Availability, and HeatWave,  in a secure Oracle Cloud Infrastructure environment.

Estimated Lab Time: 6 hours


### Objectives

In this lab, you will be guided through the following tasks:

- Create and configure a Virtual Cloud Network (VCN)
- Create the three MySQL Database Systems
    * Standalone
    * High Availability
    * HeatWave
- Create Client Linux Virtual Machine and install  MySQL Shell
- Connect and use MySQL Standalone
- Connect and use MySQL High Availability
- Connect and use MySQL HeatWave
    * Create Airportdb Database and Import Data
    * Add HeatWave Cluster to MySQL HeatWave
    * Load Airportdb Data into HeatWave
    * Run Queries in HeatWave
- Install Apache and PHP and create PHP / MYSQL Connect Application
- Create Oracle Analytics Cloud and connect to MySQL HeatWave
- Create a Bastion Host and connect to MySQL Standalone
    * Connect to MySQL Standalone using Workbench
- Manage MySQL Database Service Systems 
- Create a Bastion Host and connect to MySQL
- Manage MySQL Database Service Systems

### Prerequisites

- An Oracle Trial, or Paid Cloud Account
- Some Experience with MySQL Shell

## Task 1: Create Virtual Cloud Network

Estimated Time: 10 minutes

1. Navigation Menu > Core Infrastructure > Networking > Virtual Cloud Networks
    ![VCN](./images/03vcn01.png " ")

2. Click Start VCN Wizard.
    ![VCN](./images/03vcn02.png " ")

3. Select VCN with Internet Connectivity

    click on Button Start VCN Wizard
    ![VCN](./images/03vcn03.png " ")

4. Create a VCN with Internet Connectivity

    On Basic Information  Complete the following fields

 VCN Name:
     ````
    <copy>MDS-VCN</copy>
    ````
 Compartment: Select  **(root)**

 Your screen should look similar to the following
    ![VCN](./images/03vcn04.png " ")

5. Click the Next button at the bottom of the screen

6. Review Oracle Virtual Cloud Network (VCN), Subnets, and Gateways

    Click Create button to create the VCN
    ![VCN](./images/03vcn04-1.png " ")

7. The Virtual Cloud Network creation is completing
    ![VCN](./images/03vcn05.png " ")

8. Click "View Virtual Cloud Network" button to display the  created VCN
    ![VCN](./images/03vcn06.png " ")

9. MDS-VCN page Under Subnets in( (**(root)**)) Compartment Click on the  **Private Subnet-MDS-VCN** link
            ![VCN](./images/03vcn07.png " ")

10.	Private Subnet-MDS-VCN page under Security Lists  click on the **Security List for Private Subnet-MDS-VCN** link
        ![VCN](./images/03vcn08.png " ")

11.	Security List for Private Subnet-MDS-VCN page click on the **Add Ingress Rules** button

    ![VCN](./images/03vcn09.png " ")

12.	Add Ingress Rules page under Ingress Rule 1

 Add an Ingress Rule with Source CIDR
    ````
    <copy>0.0.0.0/0</copy>
    ````
 Destination Port Range
     ````
    <copy>3306,33060</copy>
     ````
    Description
     ````
    <copy>MySQL Port Access</copy>
     ````
 Click Add Ingress Rule.
    ![VCN](./images/03vcn10.png " ")

14.	On Security List for Private Subnet-MDS_VCN page

     New Ingress Rules will be shown under the Ingress Rules List
    ![VCN](./images/03vcn11.png " ")

15.	Add HTTP port for Web Application.

16. Click  Security List for Public Subnet-mds_vcn

17. Click on Default Security List for mds_vcn

18.	Click Add Ingress Rules page under Ingress Rule 1

 Add an Ingress Rule with Source CIDR
    ````
    <copy>0.0.0.0/0</copy>
    ````
 Destination Port Range
     ````
    <copy>80</copy>
     ````
    Description
     ````
    <copy>HTTP port</copy>
     ````

    ![VCN](./images/03vcn12.png " ")

## Task 2: Create a MySQL DB System - Standalone.

Estimated Time: 10 minutes

1. Open the navigation menu. Under Databases ->MySQL, click DB Systems
    ![MDS](./images/04mysql01.png " ")

2. Click Create MySQL DB System
    ![MDS](./images/04mysql02.png" ")

3. Create MySQL DB System dialog complete the fields in each section

    - Provide basic information for the DB System
    - Setup your required DB System
    - Create Administrator credentials
    - Configure Networking
    - Configure placement
    - Configure hardware
    - Exclude Backups


4. Provide basic information for the DB System:


 Select Compartment **(root)**

 Enter Name
     ````
    <copy>MDS-SA</copy>
    ````
 Enter Description
    ````
    <copy>MySQL Database Service Standalone instance</copy>
    ````

 Select **Standalone** to specify a Standalone DB System
    ![MDS](./images/04mysql03-1.png " ")

6. Create Administrator credentials

 Enter Username
    ````
    <copy>admin</copy>
    ````
 Enter Password
    ````
    <copy>Welcome#12345</copy>
    ````   
 Confirm Password
    ````
    <copy>Welcome#12345</copy>
    ````
    ![MDS](./images/04mysql04.png " ")

7. Configure networking Keep default values

    Virtual Cloud Network: **MDS-VCN**

    Subnet: **Private Subnet-MDS-VCN (Regional)**

    ![MDS](./images/04mysql05.png " ")

8. Configure placement  keep checked  "Availability Domain"

    Do not check "Choose a Fault Domain" for this DB System. Oracle will chooses the best placement for you.
    ![MDS](./images/04mysql06-1.png" ")

9. Configure hardware keep default shape  **MySQL.VM.Standard.E3.1.8GB**

    Data Storage Size (GB) keep default value **50**
    ![MDS](./images/04mysql07-1.png" ")

19. Configure Backups, "Enable Automatic Backups"

    Turn off button to disable automatic backup

    ![MDS](./images/04mysql08.png" ")

    Click the **Create button**
    ![MDS](./images/04mysql09-1.png" ")

11. The New MySQL DB System will be ready to use after a few minutes.

    The state will be shown as Creating during the creation
    ![MDS](./images/04mysql10-1.png" ")

12. The state Active indicates that the DB System is ready to use.

    Check the MySQL endpoint (Address) under Instances in the MySQL DB System Details page.

    ![MDS](./images/04mysql11-1.png" ")

## Task 3: Create a MySQL DB System - High Availability.

Estimated Time: 10 minutes

1. Open the navigation menu. Under Databases ->MySQL, click DB Systems
    ![MDS](./images/04mysql01.png " ")

2. Click Create MySQL DB System
    ![MDS](./images/04mysql02.png" ")

3. Create MySQL DB System dialog complete the fields in each section

    - Provide basic information for the DB System
    - Setup your required DB System
    - Create Administrator credentials
    - Configure Networking
    - Configure placement
    - Configure hardware
    - Exlude Backups


4. Provide basic information for the DB System:


 Select Compartment **(root)**

 Enter Name
     ````
    <copy>MDS-HA</copy>
    ````
 Enter Description
    ````
    <copy>MySQL Database Service High Availability instance</copy>
    ````

 Select **Standalone** to specify a High Availability DB System
    ![MDS](./images/04mysql03-2.png " ")

6. Create Administrator credentials

 Enter Username
    ````
    <copy>admin</copy>
    ````
 Enter Password
    ````
    <copy>Welcome#12345</copy>
    ````   
 Confirm Password
    ````
    <copy>Welcome#12345</copy>
    ````
    ![MDS](./images/04mysql04.png " ")

7. Configure networking Keep default values

    Virtual Cloud Network: **MDS-VCN**

    Subnet: **Private Subnet-MDS-VCN (Regional)**

    ![MDS](./images/04mysql05.png " ")

8. Configure placement  "Availability Domain"

    Select AD-2

    Do not check "Choose a Fault Domain" for this DB System. Oracle will chooses the best placement for you.
    ![MDS](./images/04mysql06-2.png" ")

9. Configure hardware keep default shape  **MySQL.VM.Standard.E3.1.8GB**

    Data Storage Size (GB) keep default value **50**
    ![MDS](./images/04mysql07-1.png" ")

19. Configure Backups, "Enable Automatic Backups"

    Turn off button to disable automatic backup

    ![MDS](./images/04mysql08.png" ")

    Click the **Create button**
    ![MDS](./images/04mysql09-2.png" ")

11. The New MySQL DB System will be ready to use after a few minutes.

    The state will be shown as Creating during the creation
    ![MDS](./images/04mysql10-2.png" ")

12. The state Active indicates that the DB System is ready to use.

    Check the MySQL endpoint (Address) under Instances in the MySQL DB System Details page.

    ![MDS](./images/04mysql11-2.png" ")


## Task 4: Create a MySQL DB System - HeatWave.

Estimated Time: 10 minutes

1. Open the navigation menu. Under Databases ->MySQL, click DB Systems
    ![MDS](./images/04mysql01.png " ")

2. Click Create MySQL DB System
    ![MDS](./images/04mysql02.png" ")

3. Create MySQL DB System dialog complete the fields in each section

    - Provide basic information for the DB System
    - Setup your required DB System
    - Create Administrator credentials
    - Configure Networking
    - Configure placement
    - Configure hardware
    - Exlude Backups


4. Provide basic information for the DB System:


 Select Compartment **(root)**

 Enter Name
     ````
    <copy>MDS-HW</copy>
    ````
 Enter Description
    ````
    <copy>MySQL Database Service HeatWave instance</copy>
    ````

 Select **HeatWave** to specify a HeatWave DB System
    ![MDS](./images/04mysql03-3.png " ")

6. Create Administrator credentials

 Enter Username
    ````
    <copy>admin</copy>
    ````
 Enter Password
    ````
    <copy>Welcome#12345</copy>
    ````   
 Confirm Password
    ````
    <copy>Welcome#12345</copy>
    ````
    ![MDS](./images/04mysql04.png " ")

7. Configure networking Keep default values

    Virtual Cloud Network: **MDS-VCN**

    Subnet: **Private Subnet-MDS-VCN (Regional)**

    ![MDS](./images/04mysql05.png " ")

8. Configure placement "Availability Domain"

    Select AD-3

    Do not check "Choose a Fault Domain" for this DB System. Oracle will chooses the best placement for you.
    ![MDS](./images/04mysql06-3.png" ")

9. Configure hardware keep default shape as **MySQL.HeatWave.VM.Standard.E3**

    Data Storage Size (GB) Keep default value:  **1024**
    ![MDS](./images/04mysql07-3.png" ")

19. Configure Backups, "Enable Automatic Backups"

    Turn off button to disable automatic backup

20. Click on Hide Advanced Options link

    Select Networking tab

    Enter Hostname mdshw

    ![MDS](./images/04mysql08-3.png" ")

    Click the **Create button**
    ![MDS](./images/04mysql09-3.png" ")

11. The New MySQL DB System will be ready to use after a few minutes.

    The state will be shown as Creating during the creation
    ![MDS](./images/04mysql10-3.png" ")

12. The state Active indicates that the DB System is ready to use.

    Check the MySQL endpoint (Address) under Instances in the MySQL DB System Details page.

    ![MDS](./images/04mysql11-1.png" ")


## Task 5: Create Client Virtual Machine

Estimated Time: 10 minutes

1. You will need a client machine to connect to your brand new MySQL database. To launch a Linux Compute instance, go to the Console, menu Compute, Instances
    ![COMPUTE](./images/05compute01.png " ")

2. On Instances in **(root)** Compartment, click on Create Instance.
    ![COMPUTE](./images/05compute02.png " ")

3. On Create Compute Instance

 Enter Name
    ````
    <copy>MDS-Client</copy>
    ````   
4. Make sure **(root)** compartment is selected.

5. Choose an operating system or image source (for this lab , select Oracle Linux 7.9)

    **NOTE** Be sure to select image Oracle Linux 7.9 otherwise the PHP install will not work.

6. Edit Configure placement and hardware

   Keep the selected Availability Domain, Instance Shape (select VM.Standard.E2.1.Micro).

   For VCN make sure **MDS-VCN** is selected, "Assign a public IP address" should be set to Yes.

      ![COMPUTE](./images/05compute03.png " ")  

7. If you have not already created your SSH key, perform "Lab 1: Create Local SSH Key".  When you are done return to the next line (TASK 5: #8) .
8. In the Add SSH keys section upload your own public key.

    ![COMPUTE](./images/05compute05.png " ")

9. Hit the **Create** button to finish creating your Compute Instance.

    ![COMPUTE](./images/05compute06.png " ")

10. The New Virtual Machine will be ready to use after a few minutes. The state will be shown as Provisioning during the creation
    ![COMPUTE](./images/05compute07.png " ")

11.	The state Runing indicates that the Virtual Machine is ready to use.

    **Save the Public IP Address** under "Instance Access"  on the **MDS_Client** Instance page.
    ![COMPUTE](./images/05compute08.png " ")

## **TASK 6:** Connect to MySQL Database - Standalone

Estimated Time: 10 minutes

MySQL Database Service Standalone has daily automatic backups and is resilient to failures because it leverages Block Volumes to store user data. Consequently, it offers the same durability, security, and performance guarantees. Automatic and manual backups are replicated to another availability domain and can be restored in the event of a disaster or user error. Data loss is limited by the last successful backup.

1. Linux and Mac users  use Terminal

   Windows 10 users use Powershell


2.  From a terminal or powershell window on your local system. Connect to the Compute Instance with the SSH command.

    Indicate the location of the private key you created earlier with **MDS-Client**.

    Enter the username **opc** and the Public **IP Address**.

    Note: The **MDS-Client**  shows the  Public IP Address as mentioned on Task 5: #11
    Task
    (Example: **ssh -i ~/.ssh/id_rsa opc@132.145.170..**)


    ````
    <copy>ssh -i ~/.ssh/id_rsa opc@<your_compute_instance_ip></copy>
    ````


    ![Connect](./images/06connect01.png " ")

    **Install MySQL Shell on the Compute Instance**

3. You will need a MySQL client tool to connect to your new MySQL DB System from your client machine.


 Install MySQL Shell with the following command (enter y for each question)

 **[opc@...]$**
     ````
    <copy>sudo yum install –y mysql-shell</copy>
    ````

    ![Connect](./images/06connect02.png " ")

   **Connect to MySQL Database Service**

4. From your Compute instance, connect to MDS-SA MySQL using the MySQL Shell client tool.

   The endpoint (IP Address) can be found in the MDS-SA MySQL DB System Details page, under the "Endpoint" "Private IP Address".

    ![Connect](./images/06connect03.png " ")

5.  Use the following command to connect to MySQL using the MySQL Shell client tool. Be sure to add the MDS-SA private IP address at the end of the cammand. Also enter the admin user password

    (Example  **mysqlsh -uadmin -p -h10.0.1..**)

 **[opc@...]$**
    ````
    <copy>mysqlsh -uadmin -p -h 10.0.1....</copy>
    ````
    ![Connect](./images/06connect04.png " ")

6. On MySQL Shell, switch to SQL mode  to try out some SQL commands

 Enter the following command at the prompt:
     ````
    <copy>\sql</copy>
    ````
 To display a list of databases, Enter the following command at the prompt:
      ````
    <copy>SHOW DATABASES;</copy>
    ````  

 To display the database version, current_date, and user enter the following command at the prompt:
      ````
    <copy>SELECT VERSION(), CURRENT_DATE, USER();</copy>
    ````  
 To display MySQL user and host from user table enter the following command at the prompt:
       ````
    <copy>SELECT USER, HOST FROM mysql.user;</copy>
      ````
 Type the following command to exit MySQL:
      ````
    <copy>\q</copy>
    ````   

  **Final Sceen Shot**
    ![Connect](./images/06connect05.png " ")

## Task 7: Connect to MySQL Database and Switchover - High Availability

Estimated Time: 10 minutes

A highly available database system is one which guarantees if one instance fails, another takes over, with zero data loss and minimal downtime.
MySQL Database High Availability uses MySQL Group Replication to provide standby replicas to protect your data and provide business continuity. It is made up of three MySQL instances, a primary, and two secondaries. All data written to the primary instance is also written to the secondaries. In the event of failure of the primary, one of the secondaries is automatically promoted to primary, is set to read-write mode, and resumes availability to client applications with no data loss. This is called a failover. It is also possible to switch manually, and promote a secondary to primary. This is called a switchover.

1. Linux ad Mac users  use Terminal

   Windows 10 users use Powershell


2.  From a terminal or powershell window on your local system. Connect to the Compute Instance with the SSH command.

    Indicate the location of the private key you created earlier with **MDS-Client**.

    Enter the username **opc** and the Public **IP Address**.

    Note: The **MDS-Client**  shows the  Public IP Address as mentioned on Task 5: #11

    (Example: **ssh -i ~/.ssh/id_rsa opc@132.145.170...**)


    ````
    <copy>ssh -i ~/.ssh/id_rsa opc@<your_compute_instance_ip></copy>
    ````


    ![Connect](./images/06connect01.png " ")


3. You should have installed MySQL shell in Task 6

   **Connect to MySQL Database Service**

4. From your Compute instance, connect to MDS-HA MySQL using the MySQL Shell client tool.

   The endpoint (IP Address) can be found in the MDS-HA MySQL DB System Details page, under the "Endpoint" "Private IP Address".

    ![Connect](./images/06connect03.png " ")

5.  Use the following command to connect to MySQL using the MySQL Shell client tool. Be sure to add the MDS-HA private IP address at the end of the cammand. Also enter the admin user password

    (Example  **mysqlsh -uadmin -p -h10.0.1..**)

 **[opc@...]$**

    ````
    <copy>mysqlsh -uadmin -p -h 10.0.1....</copy>
    ````
    ![Connect](./images/06connect04.png " ")

6. On MySQL Shell, switch to SQL mode  to try out some SQL commands

 Enter the following command at the prompt:
     ````
    <copy>\sql</copy>
    ````
 To display a list of databases, Enter the following command at the prompt:
      ````
    <copy>SHOW DATABASES;</copy>
    ````  

 To display the database version, current_date, and user enter the following command at the prompt:
      ````
    <copy>SELECT VERSION(), CURRENT_DATE, USER();</copy>
    ````  
 To display MySQL user and host from user table enter the following command at the prompt:
       ````
    <copy>SELECT USER, HOST FROM mysql.user;</copy>
      ````
 Type the following command to exit MySQL:
      ````
    <copy>\q</copy>
    ````   

  **Final Sceen Shot**
    ![Connect](./images/06connect05.png " ")

7. **Switchover** - To switch from the current primary instance to one of the secondary instances, do the following:

* Open the navigation menu  Database > MySQL > DB Systems
* Choose **(root)** Compartment.
* In the list of DB Systems, Click MDS-HA DB System to display the details page and do the following:
    * Save the current endpoint values for a before and after comparisson of the switch
    ![Connect](./images/07switch01.png " ")  
    * Select Switchover from the More Actions menu. The Switchover dialog is displayed
     ![Connect](./images/07switch02.png " ")   
    * Switch the PRimary from AD-2 to AD-3  
    * Click Switchover to begin the switch process.
    ![Connect](./images/07switch03.png " ")  
    * The DB System's status changes to Updating, and the selected instance becomes the primary.
        ![Connect](./images/07switch04.png " ")  

## Task 8: Connect to MySQL Database - HeatWave

Estimated Time: 15 minutes

HeatWave is an add-on to MySQL Database Service. It provides a highly performant and scalable in-memory analytic processing engine optimized for Oracle Cloud Infrastructure. Customers can run HeatWave on data stored in the MySQL database without requiring ETL and without any change to the application. Applications simply access HeatWave via standard MySQL protocols, and the typical administration actions are automated, integrated and accessible via the OCI Web Console, REST API, CLI, or DevOps tools. HeatWave queries achieve orders of magnitude acceleration over the MySQL database.

1. Linux ad Mac users  use Terminal

   Windows 10 users use Powershell


2.  From a terminal or powershell window on your local system. Connect to the Compute Instance with the SSH command.

    Indicate the location of the private key you created earlier with **MDS-Client**.

    Enter the username **opc** and the Public **IP Address**.

    Note: The **MDS-Client**  shows the  Public IP Address as mentioned on TASK 5: #11

    (Example: **ssh -i ~/.ssh/id_rsa opc@132.145.170...**)


    ````
    <copy>ssh -i ~/.ssh/id_rsa opc@<your_compute_instance_ip></copy>
    ````


    ![Connect](./images/06connect01.png " ")


3. You should have installed MySQL shell in TASK 6

   **Connect to MySQL Database Service**

4. From your Compute instance, connect to MDS-HW MySQL using the MySQL Shell client tool.

   The endpoint (IP Address) can be found in the MDS-HW MySQL DB System Details page, under the "Endpoint" "Private IP Address".

    ![Connect](./images/06connect03.png " ")

5.  Use the following command to connect to MySQL using the MySQL Shell client tool. Be sure to add the MDS-HW private IP address at the end of the cammand. Also enter the admin user password

    (Example  **mysqlsh -uadmin -p -h10.0.1..**)

 **[opc@...]$**

    ````
    <copy>mysqlsh -uadmin -p -h 10.0.1....</copy>
    ````
    ![Connect](./images/06connect04.png " ")

6. On MySQL Shell, switch to SQL mode  to try out some SQL commands

 Enter the following command at the prompt:
     ````
    <copy>\sql</copy>
    ````
 To display a list of databases, Enter the following command at the prompt:
      ````
    <copy>SHOW DATABASES;</copy>
    ````  

 To display the database version, current_date, and user enter the following command at the prompt:
      ````
    <copy>SELECT VERSION(), CURRENT_DATE, USER();</copy>
    ````  
 To display MySQL user and host from user table enter the following command at the prompt:
       ````
    <copy>SELECT USER, HOST FROM mysql.user;</copy>
      ````
 Type the following command to exit MySQL:
      ````
    <copy>\q</copy>
    ````   

  **Final Sceen Shot**
    ![Connect](./images/06connect05.png " ")

## Task 9:  Create airportdb schema and load data using MySQL Shell

Estimated Time: 15 minutes

The airportdb data files were produced using the MySQL Shell Schema Dump Utility. For information about this utility, see Instance Dump Utility, Schema Dump Utility, and Table Dump Utility.

Data files produced by the MySQL Shell Schema Dump Utility include DDL files for creating the schema structure, compressed .tsv files that contain the data, and .json metadata files.

**Be sure to complete TASK 8 before doing TASK 9**

1. If you are not already connected to MDS-Client then do so now

    ````
    <copy>ssh -i ~/.ssh/id_rsa opc@<your_compute_instance_ip></copy>
    ````
2. Download the airportdb sample database and unpack it. (6 minutes)

    ````
    <copy>wget https://downloads.mysql.com/docs/airport-db.zip</copy>
    ````

    ````
    <copy>unzip airport-db.zip</copy>
    ````
3. List the  airport-db directory to view the unxipped data files

    ````
    <copy>ls /home/opc/airport-db</copy>
    ````
    ![Connect](./images/09import01.png " ")

4. Start MySQL Shell and connect to the MDS-HW

    ````
    <copy>mysqlsh -uadmin -p -h 10.0.1....</copy>
    ````
5. Load the airportdb database into into MDS-HW using the  MySQL Shell Dump Loading Utility (6 minutes)   

    ````
    <copy>util.loadDump("airport-db", {threads: 16, deferTableIndexes: "all", ignoreVersion: true})</copy>
    ````
6. Display the count of all records per table in airportdb

    ````
    <copy>\sql</copy>
    ````

    ````
    <copy>SELECT table_name, table_rows FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'airportdb';</copy>
    ````
    ![Connect](./images/09import02.png " ")

7.	Exit MySQL Shell

    ````
    <copy>\q</copy>
    ````
## Task 10:  Add a HeatWave Cluster to MDS-HW MySQL Database System

Estimated Time: 15 minutes

1. You will create a HeatWave cluster comprise of a MySQL DB System node and two or more HeatWave nodes. The MySQL DB System node includes a plugin that is responsible for cluster management, loading data into the HeatWave cluster, query scheduling, and returning query result.

    ![Connect](./images/10addheat00.png " ")

2. Open the navigation menu  Databases > MySQL > DB Systems
3. Choose the **(root)** Compartment. A list of DB Systems is displayed.
    ![Connect](./images/10addheat01.png " ")
4. In the list of DB Systems, click on the **MDS-HW** Ssystem. click the “More Action” -> “Add HeatWave Cluster”.
    ![Connect](./images/10addheat02.png " ")
6. On the “Add HeatWave Cluster” dialog, select “MySQL.HeatWave.VM.Standard.E3” shape

6. Click “Estimate Node Count” button
    ![Connect](./images/10addheat03.png " ")
7. Click “Estimate Node Count” button
8. On the “Estimate Node Count” page, click “Generate Estimate”. This will trigger the auto
provisioning advisor to sample the data stored in InnoDB and based on machine learning
algorithm, it will predict the number of nodes needed.
    ![Connect](./images/10addheat04.png " ")

9. Once the estimations are calculated, it shows list of database schemas in MySQL node. If
you expand the schema and select different tables, you will see the estimated memory
required in the Summary box, There is s Load Command (analytics_load) generated in the text box window, which will change based on the selection of databases/tables

10. Select the airportdb schema and click “Apply Node Count Estimate” to apply the node count
    ![Connect](./images/10addheat05.png " ")


11. Click “Add HeatWave Cluster” to create the HeatWave cluster
    ![Connect](./images/10addheat06.png " ")
12. HeatWave creation will take about 10 minutes. From the DB display page scroll down to the Resources section. Click on the **HeatWave** link. Your completed HeatWave Cluster Information section will look like this:
    ![Connect](./images/10addheat07.png " ")

## **TASK 11:**  Load airportdb Data into HeatWave Cluster

Estimated Time: 15 minutes

1. If not already connected with SSH, on Command Line, connect to the Compute instance using SSH

    (Example: **ssh -i ~/.ssh/id_rsa opc@&132.145.170..**)

2. On command Line, connect to MySQL using the MySQL Shell client tool

    (Example  **mysqlsh -uadmin -p -h10.0.1..**)

    ````
    <copy>mysqlsh -uadmin -p -h 10.0.1....</copy>
    ````

3. Change the MySQL Shell execution mode to SQL and run the following Auto Parallel Load command to load the airportdb tables into HeatWave.

    ````
    <copy>\sql</copy>
    ````

    ````
    <copy>CALL sys.heatwave_load(JSON_ARRAY('airportdb'), NULL);</copy>
    ````
4. The compled load cluster screen should look like this:

    ![Connect](./images/11loadcluster01.png " ")

5.	Verify that the tables are loaded in the HeatWave cluster. Loaded tables have an AVAIL_RPDGSTABSTATE load status.

    ````
    <copy>USE performance_schema;</copy>
    ````
    ````
    <copy>SELECT NAME, LOAD_STATUS FROM rpd_tables,rpd_table_id WHERE rpd_tables.ID = rpd_table_id.ID;</copy>
    ````
    ![Connect](./images/11loadcluster02.png " ")

## **TASK 12:**  Run Queries in HeatWave

Estimated Time: 15 minutes

1. If not already connected with SSH, on Command Line, connect to the Compute instance using SSH

    (Example: **ssh -i ~/.ssh/id_rsa opc@&132.145.170..**)

2. On command Line, connect to MySQL using the MySQL Shell client tool

    (Example  **mysqlsh -uadmin -p -h10.0.1..**)

3. Change the MySQL Shell execution mode to SQL. Enter the following command at the prompt:
    ````
    <copy>\sql</copy>
    ````

4.	Change to the airport database.  Enter the following command at the prompt:
    ````
    <copy>USE airportdb;</copy>
    ````
    ![Connect](./images/12hwqueries01.png " ")

 5. Turn on `use_secondary_engine` variable to use HeatWave
     ````
    <copy>SET SESSION use_secondary_engine=ON;</copy>
    ````

6. Query a - Find per-company average age of passengers from Switzerland, Italy and France

 7. Before Runing a query, use EXPLAIN to verify that the query can be offloaded to the HeatWave cluster. For example:

    ````
    <copy>EXPLAIN SELECT
    airline.airlinename,
    AVG(datediff(departure,birthdate)/365.25) as avg_age,
    count(*) as nb_people
FROM
    booking, flight, airline, passengerdetails
WHERE
    booking.flight_id=flight.flight_id AND
    airline.airline_id=flight.airline_id AND
    booking.passenger_id=passengerdetails.passenger_id AND
    country IN ("SWITZERLAND", "FRANCE", "ITALY")
GROUP BY
    airline.airlinename
ORDER BY
    airline.airlinename, avg_age
LIMIT 10;</copy>
    ````
    ![Connect](./images/12hwqueries02.png " ")

8. After verifying that the query can be offloaded, run the query and note the execution time. Enter the following command at the prompt:
     ````
    <copy>SELECT
    airline.airlinename,
    AVG(datediff(departure,birthdate)/365.25) as avg_age,
    count(*) as nb_people
FROM
    booking, flight, airline, passengerdetails
WHERE
    booking.flight_id=flight.flight_id AND
    airline.airline_id=flight.airline_id AND
    booking.passenger_id=passengerdetails.passenger_id AND
    country IN ("SWITZERLAND", "FRANCE", "ITALY")
GROUP BY
    airline.airlinename
ORDER BY
    airline.airlinename, avg_age
LIMIT 10;
</copy>
    ````
     ![Connect](./images/12hwqueries03.png " ")

 9. To compare the HeatWave execution time with MySQL DB System execution time, disable the `use_secondary_engine` variable to see how long it takes to run the same query on the MySQL DB System. For example:

 Enter the following command at the prompt:
     ````
    <copy>SET SESSION use_secondary_engine=OFF;</copy>
    ````

 10. Enter the following command at the prompt:
     ````
    <copy>SELECT
    airline.airlinename,
    AVG(datediff(departure,birthdate)/365.25) as avg_age,
    count(*) as nb_people
FROM
    booking, flight, airline, passengerdetails
WHERE
    booking.flight_id=flight.flight_id AND
    airline.airline_id=flight.airline_id AND
    booking.passenger_id=passengerdetails.passenger_id AND
    country IN ("SWITZERLAND", "FRANCE", "ITALY")
GROUP BY
    airline.airlinename
ORDER BY
    airline.airlinename, avg_age
LIMIT 10;</copy>
    ````
    ![Connect](./images/12hwqueries04.png " ")

 11. To see if `use_secondary_engine` is enabled (=ON)

 Enter the following command at the prompt:
     ````
    <copy>SHOW VARIABLES LIKE 'use_secondary_engine%';</copy>
    ````
 12. Runing additional queries. Remember to turn on and off the `use_secondary_engine`  to compare the execution time.

    (Example  **SET SESSION `use_secondary_engine`=On;**)

    (Example  **SET SESSION `use_secondary_engine`=Off;**)      

 13. Enter the following command at the prompt
     ````
    <copy>SET SESSION use_secondary_engine=ON;</copy>
    ````
 14. Query b -  Find top 10 companies selling the biggest amount of tickets for planes taking off from US airports.	Run Pricing Summary Report Query:

    ````
    <copy> SELECT
    airline.airlinename,
    SUM(booking.price) as price_tickets,
    count(*) as nb_tickets
FROM
    booking, flight, airline, airport_geo
WHERE
    booking.flight_id=flight.flight_id AND
    airline.airline_id=flight.airline_id AND
    flight.from=airport_geo.airport_id AND
    airport_geo.country = "UNITED STATES"
GROUP BY
    airline.airlinename
ORDER BY
    nb_tickets desc, airline.airlinename
LIMIT 10;
    </copy>
    ````
15. Enter the following command at the prompt:
     ````
    <copy>SET SESSION use_secondary_engine=OFF;</copy>
    ````
    Run Query b again:

    ````
    <copy> SELECT
    airline.airlinename,
    SUM(booking.price) as price_tickets,
    count(*) as nb_tickets
FROM
    booking, flight, airline, airport_geo
WHERE
    booking.flight_id=flight.flight_id AND
    airline.airline_id=flight.airline_id AND
    flight.from=airport_geo.airport_id AND
    airport_geo.country = "UNITED STATES"
GROUP BY
    airline.airlinename
ORDER BY
    nb_tickets desc, airline.airlinename
LIMIT 10;
    </copy>
    ````
16. Uery c - Give me the number of bookings that Neil Armstrong and Buzz Aldrin made for a price of > $400.00

    ````
    <copy>SET SESSION use_secondary_engine=ON;</copy>
    ````

    ````
    <copy>select firstname, lastname, count(booking.passenger_id) as count_bookings from passenger, booking   where booking.passenger_id = passenger.passenger_id  and passenger.lastname = 'Aldrin' or (passenger.firstname = 'Neil' and passenger.lastname = 'Armstrong') and booking.price > 400.00 group by firstname, lastname;</copy>
    ````
    ````
    <copy>SET SESSION use_secondary_engine=OFF;</copy>
    ````

    ````
    <copy>select firstname, lastname, count(booking.passenger_id) as count_bookings from passenger, booking   where booking.passenger_id = passenger.passenger_id  and passenger.lastname = 'Aldrin' or (passenger.firstname = 'Neil' and passenger.lastname = 'Armstrong') and booking.price > 400.00 group by firstname, lastname;</copy>
    ````

17. Keep HeatWave processing enabled

    ````
    <copy>SET SESSION use_secondary_engine=ON;</copy>
    ````
## **TASK 13:**  Connect to HeatWave using Workbench

Estimated Time: 5 minutes

1. At this point, you can also use MySQL Workbench from your local machine to connect to the MySQL endpoint using your new Compute instance as a jump box.

2. In your pre-installed MySQL Workbench, configure a connection using the method "Standard TCP/IP over SSH" and use the credentials of the Compute instance for SSH.

    **MySQL Workbench Configuration for MDS HeatWAve**
    ![MDS](./images/13workbench01.png " ")

    **MySQL Workbench Use  for MDS HeatWAve**
    ![MDS](./images/13workbench02.png " ")

## Task 14:  Create PHP MySQL Application

Estimated Time: 20 minutes

Subtask 1 – Install App Server (APACHE)

1.	If not already connected with SSH, on Command Line, connect to the Compute instance using SSH ... be sure replace the  "private key file"  and the "new compute instance ip"


     ````
    <copy>ssh -i private_key_file opc@new_compute_instance_ip</copy>
     ````
2.	Install app server

    ````
    <copy>sudo yum install httpd</copy>
    ````

    ````
    <copy>sudo systemctl enable httpd</copy>
    ````

    ````
    <copy>sudo systemctl restart httpd</copy>
    ````

    ````
    <copy>sudo firewall-cmd --permanent --add-port=80/tcp</copy>
    ````

    ````
    <copy>sudo firewall-cmd --reload</copy>
    ````

3.	From a browser test apache from your loacal machine using the Public IP Address of your Compute Instance

    Example: http://129.213....

Subtask 2 – Install PHP    

1.	Install php:

    **NOTE** This PHP installation only works on a Compute instance with the  Oracle Linux 7.9 image.  
    
    If you receive any errors then delete the MDS-Client Compute and go back to **Task 5** to create a new MDS-Client compute.

    ````
    <copy> sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm </copy>
    ````
    ````
    <copy>sudo yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm</copy>
    ````
    ````
    <copy>sudo yum install yum-utils</copy>
    ````
    ````
    <copy>sudo yum-config-manager --enable remi-php74</copy>
    ````
    ````
    <copy>sudo yum install php php-cli php-mysqlnd php-zip php-gd php-mcrypt php-mbstring php-xml php-json php-mysql_xdevapi</copy>
    ````
    ````
    <copy>php -v</copy>
    ````
    ````
    <copy>php -m |grep mysql</copy>
    ````
    ````
    <copy>sudo systemctl restart httpd</copy>
    ````

2.	Create test php file (info.php)

    ````
    <copy>sudo nano /var/www/html/info.php</copy>   
    ````
3. Add the following code to the editor and save the file (ctr + o) (ctl + x)

    ````
    <copy><?php
phpinfo();
?></copy>
    ````
4. From your local machine, browse the page info.php

   Example: http://129.213.167.../info.php

Subtask 3 – Create MDS / PHP connect app

1.	Security update"   set SELinux to allow Apache to connect to MySQL

    ````
    <copy> sudo setsebool -P httpd_can_network_connect 1 </copy>
    ````

2.	Create config.php

    ````
    <copy>cd /var/www/html</copy>
    ````

    ````
    <copy>sudo nano config.php</copy>
    ````
3. Add the following code to the editor and save the file (ctr + o) (ctl + x)

    ````
    <copy><?php
// Database credentials
define('DB_SERVER', '10.0.1...');// MDS server IP address
define('DB_USERNAME', 'admin');
define('DB_PASSWORD', 'Welcome#123');
define('DB_NAME', 'sys');
//Attempt to connect to MySQL database
$link = mysqli_connect(DB_SERVER, DB_USERNAME, DB_PASSWORD, DB_NAME);
// Check connection
if($link === false){
    die("ERROR: Could not connect. " . mysqli_connect_error());
}
// Print host information
echo 'Successfull Connect.';
echo 'Host info: ' . mysqli_get_host_info($link);
?>
</copy>
    ````

4.	Create dbtest.php

    ````
    <copy>cd /var/www/html</copy>
    ````

    ````
    <copy>sudo nano dbtest.php</copy>
    ````
5. Add the following code to the editor and save the file (ctr + o) (ctl + x)

    ````
    <copy><?php
require_once "config.php";
$query = "select firstname, lastname, count(booking.passenger_id) as count_bookings from passenger, booking
where booking.passenger_id = passenger.passenger_id
and passenger.lastname = 'Aldrin' or (passenger.firstname = 'Neil' and passenger.lastname = 'Armstrong')
and booking.price > 400.00 group by firstname, lastname;";
if ($stmt = $link->prepare($query)) {
   $stmt->execute();
   $stmt->bind_result($firstname,$lastname,$count_bookings);
   echo "<table>";
        echo "<tr>";
        echo "<th>Firstname</th>";
        echo "<th>Lastname</th>";
        echo "<th>Count</th>";
    echo "</tr>";

    while ($stmt->fetch()) {
        echo "<tr>";
           echo "<td>" . $firstname ."</td>";
           echo "<td>" . $lastname . "</td>";
           echo "<td>" . $count_bookings . "</td>";
        echo "</tr>";
     }

    $stmt->close();
}
?>

</copy>
    ````

6.	From your local  machine connect to dbhwtest.php

    Example: http://129.213.167..../dbtest.php  

## **TASK 15:**  Create an Oracle Analytic Cloud

Estimated Time: 20 minutes minus intallation time

NOTE:   the following exercise is quite complicated. To learn how to use OAC go to the following document:
Analytics - https://docs.oracle.com/en/cloud/paas/analytics-cloud/tutorials.html

In order to build analytics dashboard using OAC on MDS HeatWave, we need to do the following
1.	Create a user account for OAC to MDS
2.	Provision an OAC instance
3.	Build OAC project

**Subtask 1 - Create a user account for OAC to MDS**
1.	If not already connected with SSH, on Command Line, connect to the Compute instance using SSH

    ````
    <copy>ssh -i <private_key_file> opc@<new_compute_instance_ip></copy>
    ````
2.	On command Line, connect to MySQL using the MySQL Shell client tool

    ````
    <copy>mysqlsh -uadmin -p -h10.0.1..</copy>
    ````
3.	Change the MySQL Shell execution mode to SQL

    ````
    <copy>\sql</copy>
    ````
4. Create user oacadmin

    ````
    <copy>CREATE USER 'oacadmin'@'%' IDENTIFIED WITH mysql_native_password BY 'Welcome#123';</copy>
    ````
    ````
    <copy>GRANT all privileges on airportdb.* to oacadmin;</copy>
    ````
    ````
    <copy>exit;</copy>
    ````

**Subtask 2 - Provision an OAC instance**
1.	From the OCI console, navigate to Analytics & AI-> Analytics Clouds
 ![MDS](./images/15oac01.png " ")

2. Click Create Instance
 ![MDS](./images/15oac02.png " ")

3.	On the Create Analytics Instance enter the required information as shown below

Name:

````
    <copy>mdsoac</copy>
````

Description:

````
    <copy>Oracle Analytics Cloud HeatWave Test</copy>
````
Capacity: select **OCPU** and select **4**

License Type: select **License Included**

Click the **Create** button

 ![MDS](./images/15oac03.png " ")

4.	Wait 30 minutes for OAC instance creation to complete.

![MDS](./images/15oac04.png " ")

5.	Go down to the resources page and click on the **Configure Private Access Channel**  button

6.	Click the create Private Access Channel button

7.	On the create Private Access Channel page enter the following:

Name:

````
    <copy>mdsoacpac</copy>
````
DNS Zones:
**Check Virtual Cloud Network's domain name as DNS zone (mdsvcn.oraclevcn.com)**

Description:

````
    <copy>Testing</copy>
````
**Remove second  DNS Zone entry**

8.	Click the **Create** button
![MDS](./images/15oac05.png " ")

9.	Wait 30 minutes for the process to finish, then continue to Subtask 3
![MDS](./images/15oac06.png " ")


**Subtask 3 - Get HeatWave DB Hostname **

1. Before starting go to Menu Databases > DB Systems

2. Select HeatWave database: MDS-HW  

3. Go to Resources and click on the Endpoinst Link
![MDS](./images/15oac10.png " ")
4. Save the Hostname for use with OAC

Example : **mdshw.sub09012.....mdsvcn.oraclevcn.com**

5. Continue to Subtask 4

**Subtask 4 - Build OAC Dashboard**
1.	Navigate to hamburger->Analytics->Analytics Clouds

2.	Select the OAC instance you provisioned to access the OAC console by clicking on Analytics Home Page
![MDS](./images/15oac07.png " ")

3.	Create a Connection to HeatWave to build a dashboard
![MDS](./images/15oac08.png " ")

4.	Search for mysql and select mysql as the database
![MDS](./images/15oac09.png " ")

5.	Specify the connections details
Specify the hostname of MDS in FQDN such as mysql-xxx.oraclevpn.com and be sure to use the oacadmin mysql user and password Welcome#123
6.	Next build the dashboard on MDS HeatWave by selecting Create->Data Set
7.	Select the MySQL Connection created earlier
8.	For Add Data Set name to customer_nations
9.	Select airportdb database
10. Find per-company average age of passengers from Switzerland, Italy and France. Click on the “Enter SQL and type in the following sql statement:
    ````
    <copy> SELECT
    airline.airlinename,
    AVG(datediff(departure,birthdate)/365.25) as avg_age,
    count(*) as nbpeople
FROM
    booking, flight, airline, passengerdetails
WHERE
    booking.flight_id=flight.flight_id AND
    airline.airline_id=flight.airline_id AND
    booking.passenger_id=passengerdetails.passenger_id AND
    country IN ("SWITZERLAND", "FRANCE", "ITALY")
GROUP BY
    airline.airlinename
ORDER BY
    airline.airlinename, avg_age
LIMIT 10;</copy>
    ````

11.	Click the blue Add button
12.	On new display page click on the Create Project button
13.	On new display page  click on the graph icon, go down the side and select the map icon. Drag the icon to the middle of the page.
14.	Click the dataset icon and move the nbpeople field to size and airlinename field to Category
15.	Click on the bottom + sign to add Canvas 2 and drag the bar icon to the middle of the page
16.	Click the dataset icon and move the nbpeople field to Y-axis and airlinename field to Category
17.	Set project name to customernationsbargraph

## Task 16: Start, stop, or reboot MySQL DB System

Estimated Time: 10 minutes

Open the navigation menu. Under MySQL, click DB Systems.
![MDS](./images/04mysql01.png " ")

List DB Systems
![MDS](./images/12main.png " ")
Choose  **(root)** Compartment

Click **MDS-DB** to open the DB System details page
![MDS](./images/12dbdetail.png " ")

Select one of the following actions:
* Start: Starts a stopped DB System. After the DB System is started, the Stop action is enabled and the Start option is disabled.
* Stop: Stops a Runing DB System. After the DB System is powered off, the Start action is enabled.
* Restart: Shuts down a DB System, and restarts it.

**Note**  Stopping a DB System stops billing for all OCPUs associated with it.
* Billing continues for storage.
* Billing for OCPUs resumes if you restart the DB System.
* If you selected Stop or Restart, the Stop/Restart MySQL DB System dialog is displayed.

Select a shutdown type:
* Fast: Flushes dirty pages before shutting down the DB System.

    Some flush operations must be performed during next startup, potentially increasing the duration of the startup process.
* Slow: Flushes dirty pages and purges undo log pages for older transactions.

    The shutdown itself can take longer, but the subsequent startup is faster.
* Immediate: Does not flush dirty pages and does not purge any undo log pages.
    Stops MySQL immediately. Page flushes and log purging will take place during the next startup, increasing the duration of the startup process.

Select the required shutdown type and click the Stop or Restart button, depending on the action chosen.


## Task 17: Delete MySQL DB System

Estimated Time: 10 minutes

Deleting a DB System permanently deletes it. Any manual backups associated with the deleted DB System are retained for their retention periods. Automatic backups are deleted with the DB System.

Open the navigation menu. Under MySQL, click DB Systems.
![MDS](./images/04mysql01.png " ")

List DB Systems
![MDS](./images/12main.png " ")
Choose  **(root)** Compartment

Click **MDS-DB** to open the DB System details page
![MDS](./images/12dbdetail.png " ")

Click on "More Actions" drop down list and select **Delete**
![MDS](./images/12dbmoreactions.png " ")

A prompt is displayed asking you to confirm the deletion.
![MDS](./images/12dbdelete.png " ")
Enter the word, all caps, "DELETE" and click "Delete 1 MySQL DB System" button.

When delete process is done **MDS-DB** will be set to Delete status.

## **TASK 18:**  Create a Bastion Host and Connect to MySQL
1. Now we will create a new Bastion Service that will allow us to create a SSH Tunnel to our MySQL DB System

2. Open the navigation menu Identity & Security > Bastion

    ![MDS](./images/10bastion01.png " ") 

3. Click 'Create Bastion'

   ![MDS](./images/10bastion02.png " ") 

4. On Create Bastion page, complete the fields

    - Bastion Name: MDSBastion
    - Select the Target Virtual Cloud Network in root
    - Select the Target Subnet in root
    - Add the CIDR Block Allowlist: 0.0.0.0/0
    
    ![MDS](./images/10bastion03.png " ") 

5. Click on Create Bastion

6. Start the Cloud Shell and generate a SSH Key that will be used for the tunnel's session

    ![MDS](./images/10bastion04.png " ") 

7. In the Cloud Shell, create the SSH Key with the following command:

    ````
    <copy>
    $ ssh-keygen -t rsa
    </copy>
    ````

8. You will find the public key stored in ~/.ssh/id_rsa.pub

  ![MDS](./images/10bastion05.png " ") 

9. On MDS-Bastion page, under sessions, click on 'Create Session'

  ![MDS](./images/10bastion06.png " ") 

10. 

## Learn More

* [Oracle Cloud Infrastructure MySQL Database Service Documentation ](https://docs.cloud.oracle.com/en-us/iaas/mysql-database)
* [MySQL Database Documentation](https://www.mysql.com)
## Acknowledgements
* **Author** - Perside Foster, MySQL Solution Engineering 
* **Contributors** - Mandy Pang, MySQL Principal Product Manager,  Priscila Galvao, MySQL Solution Engineering, Nick Mader, MySQL Global Channel Enablement & Strategy Manager
* **Last Updated By/Date** - Perside Foster, MySQL Solution Engineering, September 2021