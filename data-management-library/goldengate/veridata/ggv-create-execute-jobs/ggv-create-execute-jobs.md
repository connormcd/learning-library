# Create Jobs and Execute Jobs

## Introduction
This lab describes how to create and execute Jobs.

You must create and execute a job to run the comparisons. The job configuration determines which compare pair groups are processed.

*Estimated Time*: 30 minutes

### Objectives
In this lab, you will:
* Create a job for the Compare Pair Groups.
* Run the job.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- You have completed:
    * Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    * Lab: Environment Setup
    * Lab: Initialize Environment
    * Lab: Create Datasource Connections
    * Lab: Create Groups and Compare Pairs

## Task 1: Create a Job for the Compare Pair Group
To create a job:

1. From the left navigation pane, click **Configuration** and **Job configuration** to display the **Job Configuration** page.

    ![Job Configuration](./images/select-job-configuration.png " ")

2. Click **New** to display the **New Job Assistant** page.

3. Enter a **Name** and **Description** for the new job, click **Next**.

    ![New Job Name and Description](./images/new-job-create-job.png " ")

4. Enter the **Group Name** that you want to link to this job and click **Apply Filter**.

    ![Group Name](./images/create-job-select-group-apply-filter.png " ")

5. Select the Group and click **Finish**.

    ![Select Group](./images/create-job-select-group-click-finish.png " ")

A new job is created for the compare pair.

## Task 2: Execute the Job
To execute a job:

1. From the left navigation pane, click **Run/Execute Job** to display the **Run configuration** page.

    ![Run Configuration](./images/run-job-run-configuration-page.png " ")

2. Select the job you just created from the **Job** drop-down list.

    ![Select Job](./images/run-job.png " ")

3. Click **Retrieve Compare Pair List** to display the list of Compare Pairs and then click **Run Job**.

    ![Retrieve Compare Pair List](./images/select-job-retrieve-job.png " ")

4. From the left navigation pane, click **Running Jobs** to display the status of the jobs that are running.

  ![Running Jobs](./images/running-jobs-status.png " ")

5. From the left navigation pane, click **Finished Jobs** to display the completed job and the details of the compare pairs.

    ![Finished Jobs](./images/completed-jobs-compare-pair-status-chart.png " ")

You may now **proceed to the next lab**.

## Learn More
* [Get Started with Oracle GoldenGate Veridata Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=833&clear=180&session=4555570607052)
* [Master Oracle GoldenGate Veridata Advanced Features Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=913&clear=180&session=4555570607052)
* [Oracle GoldenGate Veridata Documentation](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/index.html)
* [Configuring Groups](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdug/configure-workflow-objects.html#GUID-70B42ABB-EA8E-4ADF-8414-7EA1752CA7E6)
* [Compare Pairs](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdug/configure-workflow-objects.html#GUID-055CE119-0307-4826-98C7-A51F53E28763)
* [Jobs](https://docs.oracle.com/en/middleware/goldengate/veridata/12.2.1.4/gvdug/working-jobs.html#GUID-EE434517-18EB-4827-A05F-D420D9E5B0DD)


## Acknowledgements
* **Author** - Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate User Assistance
* **Contributors** -  Nisharahmed Soneji, Sukin Varghese, Jonathan Fu
* **Last Updated By/Date** - Anuradha Chepuri, May 2022
