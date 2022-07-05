# Load HeatWave cluster in MySQL Database System  

## Introduction

A HeatWave cluster comprise of a MySQL DB System node and two or more HeatWave nodes. The MySQL DB System node includes a plugin that is responsible for cluster management, loading data into the HeatWave cluster, query scheduling, and returning query result.

![Connect](./images/10addheat00.png " ")

_Estimated Time:_ 10 minutes

### Objectives

In this lab, you will be guided through the following task:

- Add a HeatWave Cluster to MySQL Database System
- Load Airportdb Data into HeatWave

### Prerequisites

- An Oracle Trial or Paid Cloud Account
- Some Experience with MySQL Shell
- Completed Lab1, Lab2, and Lab3


## Task 1: Add a HeatWave Cluster to MySQL HeatWave Database System

In this Task, you will add a HeatWave Cluster to your MySQL HeatWave DB system

1. Open the navigation Menu > Databases > MySQL >  DB Systems

2. Choose the root Compartment. A list of DB Systems is displayed.
    ![Connect](./images/10addheat01.png " ")
3. In the list of DB Systems, click the **MDS-HW** system. click **More Action ->  Add HeatWave Cluster**.
    ![Connect](./images/10addheat02.png " ")
4. On the “Add HeatWave Cluster” dialog, select “MySQL.HeatWave.VM.Standard.E3” shape
5. Click “Estimate Node Count” button
    ![Connect](./images/10addheat03.png " ")
6. On the “Estimate Node Count” page, click “Generate Estimate”. This will trigger the auto
provisioning advisor to sample the data stored in InnoDB and based on machine learning
algorithm, it will predict the number of nodes needed.
    ![Connect](./images/10addheat04.png " ")
7. Once the estimations are calculated, it shows list of database schemas in MySQL node. If you expand the schema and select different tables, you will see the estimated memory required in the Summary box, There is a Load Command (heatwave_load) generated in the text box window, which will change based on the selection of databases/tables
8. Select the airportdb schema and click “Apply Node Count Estimate” to apply the node count
    ![Connect](./images/10addheat05.png " ")
9. Click “Add HeatWave Cluster” to create the HeatWave cluster
    ![Connect](./images/10addheat06.png " ")
10. HeatWave creation will take about 10 minutes. From the DB display page scroll down to the Resources section. Click the **HeatWave** link. Your completed HeatWave Cluster Information section will look like this:
    ![Connect](./images/10addheat07.png " ")

## Task 2: Load airportdb Data into HeatWave Cluster
1. If not already connected with SSH, connect to Compute instance using Cloud Shell

    (Example: **ssh -i ~/.ssh/id_rsa opc@132.145.17....**)

2. On command Line, connect to MySQL using the MySQL Shell client tool with the following command:

    ```
    <copy>mysqlsh -uadmin -p -h 10.0.1... --sql </copy>
    ```
    ![Connect](./images/heatwave-load-01-shell.png " ")


3. View the airportdb total records per table

    ```
    <copy>SELECT table_name, table_rows FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'airportdb';</copy>
    ```
    ![Connect](./images/airportdb-list.png " ")

4. Run the following Auto Parallel Load command to load the airportdb tables into HeatWave..

    ```
    <copy>CALL sys.heatwave_load(JSON_ARRAY('airportdb'), NULL);</copy>
    ```
5. The completed load cluster screen should look like this:

    ![Connect](./images/heatwave-load-02.png " ")

    ![Connect](./images/heatwave-load-03.png " ")

6.	Verify that the tables are loaded in the HeatWave cluster. Loaded tables have an AVAIL_RPDGSTABSTATE load status.

    ```
    <copy>USE performance_schema;</copy>
    ```
    ```
    <copy>SELECT NAME, LOAD_STATUS FROM rpd_tables,rpd_table_id WHERE rpd_tables.ID = rpd_table_id.ID;</copy>
    ```
    ![Connect](./images/heatwave-load-04.png " ")


**You may now proceed to the next lab**

## Acknowledgements

* **Author** - Perside Foster, MySQL Solution Engineering, Harsh Nayak , MySQL Solution Engineering
* **Contributors** - Mandy Pang, MySQL Principal Product Manager,  Priscila Galvao, MySQL Solution Engineering, Nick Mader, MySQL Global Channel Enablement & Strategy Manager
* **Last Updated By/Date** - Perside Foster, MySQL Solution Engineering, February 2022
