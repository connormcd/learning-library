# Provision an Oracle Autonomous Database (ADW and ATP)

## Introduction

This lab walks you through the steps to get started using the Oracle Autonomous Database (Autonomous Data Warehouse [ADW] and Autonomous Transaction Processing [ATP]) on Oracle Cloud. In this lab, you will provision a new ADW instance.

 **Note:** While this lab uses ADW, the steps are the same for creating an ATP database.

Estimated Time: 5 minutes

Watch the video below for a quick walk through of the lab.

[Provision Autonomous Database Instance](youtube:a6Jm7lYaCWI)

### Objectives

In this lab, you will:

-   Learn how to provision a new Oracle Autonomous Database

### Prerequisites

- This lab requires completion of the Get Started section in the Contents menu on the left.

## Task 1: Choose ADW or ATP from the services menu

1. Log in to the Oracle Cloud.
2. Once you log in, the cloud services dashboard shows all the services available to you. Click the navigation menu in the upper left to show top level navigation choices.

    > **Note:** You can also directly access your Autonomous Data Warehouse or Autonomous Transaction Processing service in the __Quick Actions__ section of the dashboard.

    ![Oracle home page.](./images/oci-navigation.png " ")

3. The following steps apply similarly to either Autonomous Data Warehouse or Autonomous Transaction Processing. This lab shows provisioning of an Autonomous Data Warehouse database, so click **Oracle Database**, then **Autonomous Data Warehouse**.

    ![Click Autonomous Data Warehouse.](./images/oci-navigation-adw.png " ")

4. Make sure your Workload Type is __Data Warehouse__ or __All__ to see your Autonomous Data Warehouse instances. Use the __List Scope__ drop-down menu to select a compartment. <if type="livelabs">Enter the first part of your user name, for example `LL185` in the Search Compartments field to quickly locate your compartment.

    ![Check the workload type on the left.](images/adb-choose.png " ")
    </if>
    <if type="freetier">
    ![Check the workload type on the left.](images/adb-choose.png " ")

   > **Note:** Avoid the use of the *ManagedCompartmentforPaaS* compartment, as this is an Oracle default used for Oracle Platform Services.
   </if>

5. This console shows that no databases yet exist. If there were a long list of databases, you could filter the list by the **State** of the databases (Available, Stopped, Terminated). You can also sort by **Workload Type**. In this example, **Data Warehouse** is the workload type.

    ![Autonomous Databases console.](./images/adb-no-database.png " ")

<if type="freetier">
6. If you are using a Free Trial or Always Free account, and you want to use Always Free Resources, you need to be in a region where Always Free Resources are available. You can see your current default **region** in the top, right hand corner of the page.

    ![Select region on the far upper-right corner of the page.](./images/adb-select-region.png " ")
</if>

## Task 2: Create an Oracle Autonomous Database instance

1. Click **Create Autonomous Database** to start the instance creation process.

    ![Click Create Autonomous Database.](./images/adb-start-create.png)


2.  This brings up the *Create Autonomous Database* screen where you will specify the configuration of the instance.


3. Specify basic information for the autonomous database:

    | **Field**  | **Value** | Note |
    |---|---|---|
    | Compartment | (Defaut) | |
    | Display Name | `OICDemo` | Enter a memorable name for the database for display purposes |
    | Database Name | `OICDEMO` | Use letters and numbers only, starting with a letter. Maximum length is 14 characters. |
    |


4. Choose a workload type. Select the workload type for your database from the choices:

    - **Data Warehouse** - For this lab, choose **Data Warehouse** as the workload type.
    - __Transaction Processing__ - Or, you could have chosen Transaction Processing as the workload type.

    ![Choose workload type.](./images/create-adb-workload-type.png)


5. Choose a deployment type. Select the deployment type for your database from the choices:

    - __Shared Infrastructure__ - For this lab, choose __Shared Infrastructure__ as the deployment type.
    - __Dedicated Infrastructure__ - Or, you could have chosen Dedicated Infrastructure as the deployment type.


6. Configure the database:

    - __Always Free__ - If your Cloud Account is an Always Free account, you can select this option to create an always free autonomous database. An always free database comes with 1 CPU and 20 GB of storage. For this lab, we recommend you check **Always Free** option.
    - __Choose database version__ - Select a database version from the available versions.
    - __OCPU count__ - Number of CPUs for your service. For this lab, specify __1 CPU__. If you choose an Always Free database, it comes with 1 CPU.
    - __Storage (TB)__ - Select your storage capacity in terabytes. For this lab, specify __1 TB__ of storage. Or, if you choose an Always Free database, it comes with 20 GB of storage.
    - __Auto Scaling__ - For this lab, keep auto scaling enabled, to enable the system to automatically use up to three times more CPU and IO resources to meet workload demand.
    - __New Database Preview__ - If a checkbox is available to preview a new database version, do NOT select it.

    > **Note:** You cannot scale up/down an Always Free autonomous database.

    ![Choose the remaining parameters.](./images/create-adb-configure.png)


7. Create administrator credentials:

    - __Password and Confirm Password__ - Specify the password for *ADMIN* user of the service instance. The password must meet the following requirements:
    - The password must be between 12 and 30 characters long and must include at least one uppercase letter, one lowercase letter, and one numeric character.
    - The password cannot contain the username.
    - The password cannot contain the double quote (") character.
    - The password must be different from the last 4 passwords used.
    - The password must not be the same password that you set less than 24 hours ago.
    - Re-enter the password to confirm it. Make a note of this password.


8. Choose network access:
    - For this lab, accept the default, **Secure access from everywhere**.
    - If you want to restrict access to specified IP addresses and VCNs, select "Secure access from allowed IPs and VCNs only." You can control and restrict access to your Autonomous Database by setting network access control lists (ACLs). You can select from 4 IP notation types: IP Address, CIDR Block, Virtual Cloud Network, Virtual Cloud Network OCID).
    - If you want a private endpoint, to enable traffic only from the VCN you specify - and to block access to the database from all public IPs or VCNs, select "Private endpoint access only" in the Choose network access area.
    - If you select "Secure access from allowed IPs and VCNs only" or "Private endpoint access only", you can use the checkbox to require mutual TLS (mTLS) authentication to authenticate connections to your database. If you don't select this checkbox, TLS or mTLS can be used.

    ![Choose the network access.](./images/create-adb-network-access.png " ")

<if type="livelabs">
9. Choose a license type. For this lab, choose **Bring Your Own License (BYOL)**. The two license types are:
</if>
<if type="freetier">
9. Choose a license type. For this lab, choose **License Included**. The two license types are:
</if>

    - **Bring Your Own License (BYOL)** - Select this type when your organization has existing database licenses.
    - **License Included** - Select this type when you want to subscribe to new database software licenses and the database cloud service.

<if type="livelabs">
    ![Select Network Access](./images/create-adb-license-type.png " ")
</if>
<if type="freetier">
    ![Select Network Access](./images/create-adb-license-type.png " ")
</if>

10. Click **Create Autonomous Database**.

    ![Create Autonomous Database](./images/create-adb.png " ")

11.  Your instance will begin provisioning. In a few minutes, the state will turn from *Provisioning* to *Available*. At this point, your Autonomous Data Warehouse database is ready to use! Have a look at your instance's details here including its name, database version, OCPU count, and storage size.

<if type="livelabs">
    ![Show Autonomous Database](./adb-available-freetier.png)
</if>
<if type="freetier">
    ![Show Autonomous Database](images/adb-available-freetier.png)
</if>


Please *proceed to the next lab*.

## Learn more

Go to [the documentation](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/autonomous-workflow.html#GUID-5780368D-6D40-475C-8DEB-DBA14BA675C3) on the typical workflow for using Autonomous Data Warehouse.

## Acknowledgements

- **Author** - Nilay Panchal, Oracle Autonomous Database Product Management
- **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
- **Contributors** - Oracle LiveLabs QA Team (Jeffrey Malcolm Jr, Intern | Arabella Yao, Product Manager Intern)
- **Last Updated By/Date** - Ravi Chablani - March 2022, Kishore Katta - May 2022
