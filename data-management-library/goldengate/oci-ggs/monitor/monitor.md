# Monitor Extracts and Replicats

## Introduction

This lab walks you through the steps to monitor the Extract and Replicat processes that were created and run in the previous lab.

Estimated Lab Time: 2 minutes

### About Performance Monitoring

Monitoring the performance of your GoldenGate instance ensures that your data replication processes are running smoothly and efficiently. You can monitor performance in both the Oracle Cloud Infrastructure (OCI) GoldenGate Deployment Console as well as in the Oracle Cloud Console on the Deployment Details page.

### Objectives

In this lab, you will:
* View charts and statistics using the Performance Metrics Server in the GoldenGate deployment console
* Use Metrics on the Deployment Details page in the Oracle Cloud Console to determine overall instance health and utilization.

### Prerequisites

In order to complete this lab, you should have completed the preceding lab and have both an Extract and Replicat running.

## Task 1: Perform Inserts to the Source Database

1.  Return to the Oracle Cloud Console and use the navigation menu (hamburger icon) to navigate back to **Oracle Database**, **Autonomous Transaction Processing**, and then **SourceATP**.

2.  On the Source ATP Details page, click **Tools**, and then **Database Actions**.

3.  Use the Source ATP database credentials in the Workshop details to log in to Database Actions, and then click **SQL**.

4.  Enter the following inserts, and then click **Run Script**:

    ```
    <copy>Insert into SRC_OCIGGLL.SRC_CITY (CITY_ID,CITY,REGION_ID,POPULATION) values (1000,'Houston',20,743113);
Insert into SRC_OCIGGLL.SRC_CITY (CITY_ID,CITY,REGION_ID,POPULATION) values (1001,'Dallas',20,822416);
Insert into SRC_OCIGGLL.SRC_CITY (CITY_ID,CITY,REGION_ID,POPULATION) values (1002,'San Francisco',21,157574);
Insert into SRC_OCIGGLL.SRC_CITY (CITY_ID,CITY,REGION_ID,POPULATION) values (1003,'Los Angeles',21,743878);
Insert into SRC_OCIGGLL.SRC_CITY (CITY_ID,CITY,REGION_ID,POPULATION) values (1004,'San Diego',21,840689);
Insert into SRC_OCIGGLL.SRC_CITY (CITY_ID,CITY,REGION_ID,POPULATION) values (1005,'Chicago',23,616472);
Insert into SRC_OCIGGLL.SRC_CITY (CITY_ID,CITY,REGION_ID,POPULATION) values (1006,'Memphis',23,580075);
Insert into SRC_OCIGGLL.SRC_CITY (CITY_ID,CITY,REGION_ID,POPULATION) values (1007,'New York City',22,124434);
Insert into SRC_OCIGGLL.SRC_CITY (CITY_ID,CITY,REGION_ID,POPULATION) values (1008,'Boston',22,275581);
Insert into SRC_OCIGGLL.SRC_CITY (CITY_ID,CITY,REGION_ID,POPULATION) values (1009,'Washington D.C.',22,688002);</copy>
    ```

5.  In the OCI GoldenGate Deployment Console, click the **Extract name (UAEXT)**, and then click **Statistics**. Verify that **SRC\_OCIGGLL.SRC\_CITY** is listed with 10 inserts.

    ![Extract Process Information - Statistics](images/04-17.png " ")

6.  Go back to the Overview screen, click the **Replicat name (REP)**, and then click **Statistics**. Verify that **SRC\_OCIGGLL.SRC\_CITY** is listed with 10 inserts.

    ![Replicat Process Information - Statistics](images/01-06-rep-statistics.png " ")

## Task 2: Using the Performance Metrics Server

1.  In the GoldenGate deployment console, click **Performance Metrics Server**, and then click **EXT**.

    ![Performance Metrics Service page - EXT highlighted](images/05-01-perf-serv.png)

    > **Note:** *You can also view performance details for the Administration, Distribution, and Receiver Servers, as well as any processes created.*

2.  Click **Database Statistics**.

    ![Database Statistics page](images/05-03-db-stats.png)

    Here, you can view the real time database statistics, such as Inserts, Updates, Deletes, and so on.

4.  Repeat steps 1-3 to view a snapshot of the Replicat's (named **Rep** in our lab) Database Statistics.

## Task 3: Viewing GoldenGate Metrics in the Oracle Cloud Console

1.  On the OCI GoldenGate Deployments page, select **GGSDeployment**.

2.  On the GGSDeployment Details page, scroll down to the **Metrics** section.

    ![Metrics on Deployment Details page](images/05b-02-metrics.png)

3.  Review the **DeploymentInboundLag** and **DeploymentOutboundLag** charts.

4.  Refresh your view after 5 minutes to see updated metrics.

In this lab, you learned to monitor performance in the OCI GoldenGate Deployment Console and in the OCI Console.

## Learn More

* [Viewing Performance Metrics](https://docs.oracle.com/en/cloud/paas/goldengate-service/using/goldengate-deployment-console.html#GUID-A533E3ED-ADB9-42EE-A1FF-D3E6C5638DF3)

## Acknowledgements
* **Author** - Jenny Chan, Consulting User Assistance Developer, Database User Assistance
* **Contributors** -  Denis Gray, Database Product Management
* **Last Updated By/Date** - Jenny Chan, February 2022
