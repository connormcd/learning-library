# Create and Configure Oracle MySQL Database Service

## Introduction

This lab will teach how to setup and configure MySQL Database Service

## Objectives:

* Create and Configure MySQL Database Service

## Task 1: Create and Configure MySQL Database Service

1. Open the navigation menu. Under **Database**, go to **MySQL** and click **DB Systems**

2. On the **DB Systems** page, select the compartment and click on **Create MySQL DB System**.

3. Provide DB System information:

* **Compartment**: if you selected the correct compartment in the initial page, you should not need to change
* **Name DB system**: Enter the name of your DB system
* **Description**: MySQL system Description
* **Select the DB system Type**: *Standalone*

4. Create Administrator credentials:

* **Username**: administrator user name
* **Password**: admin password
* **Confirm Password**: admin password

5. Configure networking

* ***Virtual Cloud Network in <Compartment>** select the VCN
* **Subnet in <Compartment>** select the a private VCN

6. Configure placement

* **Availability Domain**: select the availability domain
* **Choose a Fault Domain**: Optional. Can be left unchecked

7. Configure hardware

* **Select a Shape**: choose the desired shape by clicking on **Change Shape**
* **Data Storage Size (GB)**: Enter the desired storage size. Default is 50 GB

8. Configure Backup Plan

* **Enable Automatic Backups**: *leave selected*
* **Backup Retention period**: *7*

9. Create the Database system by clicking on **Create**

10. You will be taken to the MySQL DB System's details page. Once the yellow hexagon turns green, your DB system will be provisioned, up and running.

## Acknowledgements
* **Author** - Perside Foster, MySQL Solution Engineering, Orlando Gentil, Principal Training Lead and Evangelist
* **Contributors** - Frédéric Descamps, MySQL Community Manager 
* **Last Updated By/Date** - Perside Foster, MySQL Solution Engineering, March 2022