## Introduction

### About this Workshop 

The purpose of this workshop is to introduce you to Oracle Data Integrator Web Edition. 

This workshop goes over the deployment process for ODI Web Edition and then gives you introductory skills for Data Transforms tool. Data Transforms is powered by Oracle Data Integrator (ODI) which is market leading data integration tool for more than a decade. Data Transforms tool hides the complexity of ODI and makes the data integration capability available for departmental users. This workshop uses only Autonomous Database as source and target for simplicity but the same tool can be used to extract data from hybrid data sources (including Fusion and Salesforce), load into various target destinations and transform as needed for any data integration project.

### Who Should Use This Workshop?

Everyone can benefit from doing the lab exercises in this workshop: technical experts (data warehouse architects to database administrators), business users who want to focus on extracting meaning and insight from their own data, along with data scientists who need to load and transform data in order to build machine learning models.


### Objectives

In this workshop, you will:

- Become familiar with the steps needed to deploy Oracle Data Integrator Web Edition on OCI
-  Learn basic skills for using Data Transforms tool in order to build data integration flows

## Task 1: Connecting to your Oracle Cloud Database

1. Log in to the Oracle Cloud at <a href="https://cloud.oracle.com">cloud.oracle.com</a>. Cloud Account Name is howarduniversity. Click "Next".
2. Click on "Direct Sign-In" and enter your Cloud Account email and password.

    ![](./images/direct-sign-in.png " ")

3. Once you are logged in, you are taken to the cloud services dashboard where you can see all the services available to you. Click the navigation menu in the upper left to show top level navigation choices.

    ![](./images/picture100-36.png " ")


4. Click **Autonomous Data Warehouse**.

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png " ")

5. From the Compartment drop down on the left side of the page, expand howarduniversity->spring2022->student1xx and select you student number.

    ![](./images/hu-compartment.png " ")

6. Click on the database you created in lab 1
   
    ![](./images/adb-compartment.png " ")

## Task 2: Create New Database Users

When you create a new data warehouse, you automatically get an account called ADMIN that is your super administrator user. In the real world, you will definitely want to keep your data warehouse data completely separate from the administration processes. Therefore, you will need to know how to create separate new users and grant them access to your data warehouse. This section will guide you through this process using the "New User" wizard within the SQL Worksheet (one of the built-in tools in Autonomous Data Warehouse).

For this task, we need to create one new user.

1. Navigate to the **Details** page of the Autonomous Database you provisioned in the "Provision an ADB Instance" lab. In this example, the database is named "ADW Finance Mart." Click the **Database Actions** button.

  ![ALT text is not available for this image](images/click-database-actions-button.png)

2. In the login form, enter ADMIN for the username and click **Next**. On the next form, enter the ADMIN password - which is the one you entered when creating your Autonomous Data Warehouse.

  ![ALT text is not available for this image](images/admin.png)

3. On the Database Actions launchpad page, under Administration, click the **Database Users** card.

  ![ALT text is not available for this image](images/database-users.png)

4.  You can see that your ADMIN user is listed as the current user.  On the right-hand side, click the "+ **Create User**" button.

  ![ALT text is not available for this image](images/create-user.png)

5. The **Create User** form will appear on the right-hand side of your browser window. Use the settings below to complete the form:

 - User Name: **QTEAM**
 - Password: make up your own suitably strong password.

    > **Note:** Rules for User Passwords - Autonomous Data Warehouse requires strong passwords. User passwords must meet the following default password complexity rules:

    - Password must be between 12 and 30 characters long

    - Must include at least one uppercase letter, one lowercase letter, and one numeric character

    - Limit passwords to a maximum of 30 characters

    - Cannot contain the username

    - Cannot be one of the last four passwords used for the same username

    - Cannot contain the double quote (") character

    There is more information available in the documentation about password rules and how to create your own password rules. See here: [Create Users on Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/manage-users-create.html#GUID-B5846072-995B-4B81-BDCB-AF530BC42847)

  - Leave the Graph button turned off.
  - Toggle the **Web Access** button to **On** and expand **Web access advanced features**.
  - Leave the **Authorization required** toggle button as on/blue.
  - Accept the default alias which is automatically set to qteam - this allows the user access to our new data warehouse using the Database Actions tools.
  - Select **UNLIMITED** from the drop down menu for Quota on tablespace DATA
  - Leave the **Password Expired** toggle button as off (note this controls whether the user will be prompted to change their password when they next login).
  - Leave the **Account is Locked** toggle button as off. 

  Next you will examine the form.

6. When you examine the form, it should look like this:

  ![ALT text is not available for this image](images/create-user-dialog.png)

7.  Click on the **Granted Roles** banner at the top of the form and add the role **DWROLE** by checking the box in the first column.

  ![ALT text is not available for this image](images/dwrole.png)

  Notice that two additional roles have already been automatically assigned: **CONNECT** and **RESOURCE**.  

8.  Finally, click the **Create User** button at the bottom of the form.

**Login as User QTEAM**

Now you need to switch to working as the user QTEAM, so you can start the next lab on data loading.

1. Find the card for the user QTEAM and click on the box with the upward pointing arrow at the bottom of the card.

  ![ALT text is not available for this image](images/click-qteam.png)

2. Enter the username QTEAM and the password you defined in Task 1 when you created this user.

  ![ALT text is not available for this image](images/qteam-login.png)

3. This will launch the Database Actions Launchpad page.

  ![ALT text is not available for this image](images/database-actions-launchpad.png)


Now you have connected to your Autonomous Data Warehouse with your new user. You are ready to go to the next lab!

## Task 3: Loading Data

### Introduction

This task will load sample data in Autonomous Database for use with Task 5 (Using Data Transforms).

### Objectives

In this lab, you will:

- Load Data from Oracle Object Store to Autonomous Database

**Load Data from Oracle Object Store to Autonomous Database**

We need to load the `Movie_Sales_2020.csv` file which is stored in an Object Storage public bucket. We will set up connection to Oracle Object Store and load the file.

1. In Autonomous Database, navigate to **Data Load**.

    ![ALT text is not available for this image](images/3021450317.jpg)

2. On the Data Load main page, click the **Cloud Locations** card to define a new connection to your object store.

    ![ALT text is not available for this image](images/3021448539.png)

3. Click the **Add Cloud Storage** button on the upper right and define a Cloud Storage location as follows:

    | **Field** | **Value** | **Notes** |
    | --- | --- | --- |
    | Name | MOVIE_SALES | Lower case names not currently supported  |
    | Description |Movie Sales |  |
    | URI + Bucket | [https://objectstorage.uk-london-1.oraclecloud.com/n/adwc4pm/b/MovieStream/o/](https://objectstorage.uk-london-1.oraclecloud.com/n/adwc4pm/b/MovieStream/o/) |  |
    | Credential | No credential | Radio Button |

    ![ALT text is not available for this image](images/3021448429.png)

When you have completed these details, press **Create**.

4. Navigate back to the Data Load main page and press the two cards for **Load Data** from **Cloud Storage** and press **Next**. 

    ![ALT text is not available for this image](images/3021448425.png)

5. Locate the file `Movie_Sales_2020.csv` on the left of the screen. Drag this file on to the canvas on the right. 

    ![ALT text is not available for this image](images/3021448428.png)

6. As before, edit the properties of the data load job by pressing the pencil button. 

    ![ALT text is not available for this image](images/3021448427.png)

7. Review the information on the properties sheet. When you are satisfied, press the green arrow button to start the data load job. 

    ![ALT text is not available for this image](images/3021448426.png)

**Inspect the Data** 

1. Navigate to the Data Load main page and press the **Explore** card.

![ALT text is not available for this image](images/data_explore_01.jpg)


2. You'll now see the table MOVIE\_SALES\_2020 has been loaded into our Autonomous Data Warehouse. Click on this table and then click **Source Statistics** on the panel to the left of the screen. You can think of this as a UI on top of the statistics that drive the optimizer of Oracle Database. In this case this data presents a nice simple way to characterize the data we've just loaded. 

    ![ALT text is not available for this image](images/data_explore_02.jpg)

### Conclusion

In this section we've covered the following topics:

- Loading a CSV file from Object Store to Autonomous Database using the Data Load tool
- Reviewing the data and statistics

## Task 4: Deploying ODI Web Edition

### Introduction

Oracle Data Integrator (ODI) is Oracle's industry-leading, enterprise-class data integration tool. It features an extract-load-transform (ELT) architecture, which delivers very high performance, scalability and reliability because it uses the target database to execute transformations. Why do an **E** and an **L** if all you want to do is a **T**? That's the problem with legacy ETL tools with server-based architectures that require data to be extracted for processing (transformation) and reloaded afterwards. ODI Web Edition brings this power and pedigree to a wider user base through the Data Transforms tool, which provides a simple drag and drop low-code environment for creating data integration projects.

ODI Web Edition needs to be deployed from OCI Marketplace before we can use Data Transforms. In this lab we will go through the steps to create an  ODI Web Edition instance.

### Objectives

In this task, you will:

- Create an ODI Web Edition instance

- Register it with Autonomous Database so that Data Transforms can be launched from the Database Tools page

### Prerequisites

To complete this task, you need to have the following:

- Autonomous Database, which will host repository for ODI Web Edition

- SSH Key

- OCI privileges (work with your tenancy administrator)

    - Available resource in OCI to create VCN, Stack and Compute instance

    - Privilege to create VCN

    - Privilege to create OCI dynamic group and policies

- Privilege to create an OCI compartment or access to a compartment

- Knowledge of basic concepts of OCI console navigation 

**Create OCI Policies for ODI Web Edition Deployment**

1. **NOTE:** If you have already been provided a compartment then skip this step. For the remaining steps, replace compartment name `odi` with your assigned compartment name. Create a compartment `odi` where ODI Web Edition related artifacts will be created. Make sure you have a privilege to create a compartment or request your administrator to give you a compartment. Use this compartment for the rest of the lab. Navigate to **Identity & Security > Compartments** and create a compartment. 

    ![ALT text is not available for this image](images/3018124962.jpg)

2. **NOTE:** If you have already been provided a compartment then skip this step. Create a compartment named `odi`. If you already have access to a compartment provided by your administrator then skip creation. You should also copy the OCID of your compartment since it is needed in the next step.

    ![ALT text is not available for this image](images/3018124982.jpg)

3. Navigate to **Identity & Security > Dynamic Groups**.

    ![ALT text is not available for this image](images/3018125018.jpg)

4. Create a dynamic group `odi`; to include matching rules for instances in a specified compartment. Replace the OCID of your compartment in the example. For example:

    ALL {[instance.compartment.id](http://instance.compartment.id) = 'ocid1.compartment.oc1..aaaaaaaabgr34tpuanpvq6xfb667nsmy2jz45zj6dexojhxdsv4mjayem3cq'}

    ![ALT text is not available for this image](images/3018124858.jpg)

5. Navigate to **Identity & Security > Policies**.

    ![ALT text is not available for this image](images/3018125033.jpg)

6. Select your compartment under **List Scope** and click **Create Policy**.

    ![ALT text is not available for this image](images/3018125047.jpg)

7. Create a policy named `odi_policies`.

    ![ALT text is not available for this image](images/3018125065.jpg)

8. Click on `odi_policies` to add policies. Use the manual editor.

    Set policy at your compartment level. All ADW/ATP instances in the compartment where the ODI instance is created will be accessed during deployment. Copy and paste the policies below in the editor window and click **Create**.

    **NOTE:** If you are working on a different compartment then replace `odi` with your compartment name.

    Set up the following policy:

    Allow dynamic-group odi_group to inspect autonomous-database-family in compartment odi

    Allow dynamic-group odi_group to read autonomous-database-family in compartment odi

    Allow dynamic-group odi_group to inspect compartments in compartment odi

    **Note:** If you want ODI web to be able to access autonomous databases in other compartments in your tenancy, you will need to set additional policy statements at the root level of your tenancy. In this case, all ADW/ATP instances from the tenancy where ODI instance is created will be accessed during deployment.

    Allow dynamic-group odi_group to inspect autonomous-database-family in tenancy

    Allow dynamic-group odi_group to read autonomous-database-family in tenancy

    Allow dynamic-group odi_group to inspect compartments in tenancy

    ![ALT text is not available for this image](images/3018125118.jpg)

**Deploy ODI Web Edition**

1. Starting from the OCI console, navigate to the OCI Marketplace, as follows (and as shown in the screenshot below):

    - Be sure that you are working in the same OCI Region as your Autonomous Database. (In the example below, that is US West (Phoenix))

    - From the Hamburger menu at the top left, select Marketplace, then **All Applications**

    - Under **Filters** on the left, specify:
        - Publisher: Oracle
        - Category: Data Integration
        - Price: Free

    - Of the cards that match these criteria, select **Data Integrator: Web Edition**

    ![ALT text is not available for this image](images/3018104742.png)

2. In the details screen that appears, you should review and (if suitable) accept the Oracle Terms of Use. Then press **Launch Stack**. 

    ![ALT text is not available for this image](images/3018104743.png)

3. What follows is a simple fill-in-the-blanks dialog to configure the OCI software stack appropriately. In the **Stack Information** section, provide a name and description for this software stack. You can ignore the target compartment in this dialog, but it's important to specify this appropriately in the next dialog. 

    ![ALT text is not available for this image](images/3018104744.png)

4. The **Configure Variables** section is a rather long form, broken up here into three separate screenshots. 

    **Important**: In the **General Settings** section, be sure to specify the same TARGET COMPARTMENT as you used to deploy your Autonomous Database.

    ![ALT text is not available for this image](images/3018104745.png)

5. In the **Oracle Data Transforms Instance Settings** section, enter your own OCI Public key into the field SSH PUBLIC KEY. You'll also need to specify a password for ORACLE DATA TRANSFORMS VNC PASSWORD. 

    ![ALT text is not available for this image](images/3018104746.png)

6. In the **New Oracle Data Transforms Metadata Repository** section, pick the name of your Autonomous Database from the pick list at the top. (This pick list is populated with names of Autonomous Databases in the same Compartment as you're using here. This is why it was important to pick the Target Compartment carefully in the **General Settings** section above.)

    **Important**: Be sure to check the box next to REGISTER ORACLE DATA TRANSFORMS WITH THE AUTONOMOUS DATABASE, DATABASE ACTIONS PAGE. This is what puts the Data Transforms card on your Database Actions page.

    **Important**: Carefully type the passwords. Autonomous Database Admin password is not verified at this stage and deployment may fail if you type in incorrect password. For new passwords (VNC, SUPERVISOR and SCHEMA), follow the passwords guidelines. It is better to write these passwords in an editor and do copy and paste here. This will make sure that passwords are correctly entered.

    ![ALT text is not available for this image](images/3018104747.png)

7. Next comes the **Review** section. Be sure to check the values specified here, so that the stack is deployed successfully. Go back and make any corrections necessary. When you're satisfied, press **Create**. 

    ![ALT text is not available for this image](images/3018104748.png)

    **Important**:  Data Transforms is still not ready to use at this stage. Deployment of the ODI components in your Autonomous Database will take 10-15 minutes. 

    Because of the time required to set up Data Transforms completely, this is an ideal time to take a 10 min break from the workshop. We suggest a walk, a nice meal, or perhaps a coffee break. 

8. During Phase 1 (deployment of OCI components), you'll see a dialog similar to this:

    ![ALT text is not available for this image](images/3018104749.png)

9. When the OCI components of the stack are successfully deployed, the status icon will turn green, as follows:

    **NOTE:** This can take several minutes to finish.

    ![ALT text is not available for this image](images/3018104750.png)In this window, you can view the progress of the stack deployment log, if you're interested. 

    **NOTE:** After the stack is successfully deployed, your compute instance is created. However, ODI deployment script is running in the background  to do the following:

    - **Installing ODI Web Edition software**

    - **Creating repository in ADW**

    - **Starting ODI agents**

  **All the above steps take around 10-15 minutes to finish. You can come back after 15 minutes and check for Data Transforms using direct URL as shown in Step 3. If it is not ready then give it another 5 minutes.**

  **In order to check the progress of the deployment script, one need to login to VNC viewer to the compute instance and check the log file. This is beyond the scope of this workshop. To keep steps simple, we simply wait for 10-15 minutes and launch the Data Transforms tool.**

**Launch The Data Transforms Tool**

Data Transforms tool can be launched by two methods:

- Direct URL from a browser

- Data Transforms card in Autonomous Database tools page.


1. In order to find the URL we need to access the application properties in OCI stack created in previous step. In the OCI Control plane, from the hamburger menu select **Resource Manager – Stacks**, as follows:

    ![ALT text is not available for this image](images/3018104751.png)

2. In the screen that appears, click on the name of the stack.

    ![ALT text is not available for this image](images/3018104752.png)

3. Then click on the tab for **Application Information**:

    ![ALT text is not available for this image](images/3018104783.png)

4. The page that appears provides both private and public URLs for accessing **Oracle Data Integrator - Web Edition** directly.  

    ![ALT text is not available for this image](images/3018104789.png)

5. We need to perform few administration steps before we can successfully launch Data Transforms form Autonomous Database Actions menu. Click on the Data Transforms URL in previous step to launch Data Transform. Login with SUPERVISOR user and your password.

    ![ALT text is not available for this image](images/lab04-task03-05.jpg)

6. Click Administration and click Continue.

    ![ALT text is not available for this image](images/lab04-task03-06.jpg)

7. This is where Database user is mapped to Data Transforms user. There is a default map for ADMIN user to SUPERVISOR. Click + and add QTEAM user mapping to SUPERVISOR. Enter Database URL (as shown) and click Save. After this you will be able to launch Data Transforms from Autonomous Database Actions page.

    ![ALT text is not available for this image](images/lab04-task03-07.jpg)


8. You can also launch **Data Transforms** from Autonomous Database. You'll see a card for a fully pre-configured connection to your Autonomous Database. Click the **DATA TRANSFORMS** card.

    ![ALT text is not available for this image](images/3018124770.png)

9. You will see the login screen for the Data Transforms tool. Specify username **SUPERVISOR** and the password that you provided in the ODI Web Edition deployment. Click **Connect**.

    ![ALT text is not available for this image](images/3018123500.png)Follow the next lab for using Data Transforms to create a data flow.

### Conclusion

In this section we've covered the following topics:

- Deploying ODI Web Edition compute instance from OCI Marketplace

- Register Data Transforms tool to Autonomous Database Tools page

- Launch Data Transforms tool

## Task 5: Using Data Transforms

### Introduction

Data Transforms tool provides a simple drag and drop low-code environment for creating data integration projects. It is powered by **Oracle Data Integrator**. Oracle Data Integrator (ODI) is Oracle's industry-leading, enterprise-class data integration tool. It features an extract-load-transform (ELT) architecture, which delivers very high performance, scalability and reliability because it uses the target database to execute transformations. Why do an &quot;E&quot; and an &quot;L&quot; if all you want to do is a &quot;T&quot;? That's the problem with legacy ETL tools with server-based architectures that require data to be extracted for processing (transformation) and reloaded afterwards.

Data Transforms tool uses Autonomous Database as the data transformation engine and leverages database features for complex transformation processing. At the same time, it has hybrid connectivity to many sources and targets from which data can be extracted and loaded to. 

This task shows you how to use Data Transforms using a simple data source that has been loaded earlier. After this users can explore other connectivity options and more complex transformations as needed.

### Objectives

In this lab, you will:

- Learn basic navigation in Data Transforms

- Connect to Autonomous Database and import definitions of tables

- Create a simple data flow and execute the flow

- Inspect the executed job

- Create a workflow and schedule the job

**Launch Data Transforms and Connect to Autonomous Database**

1. Launch **Data Transforms** from either direct URL or from the Data Transforms card in Autonomous Database. Specify username **SUPERVISOR** and the password that you provided in the ODI installation. Click **Connect**.

    ![ALT text is not available for this image](images/lab05-task01-01.jpg)

2. In the Data Transforms main page, click on **Connections** on the left of the screen. You'll see that a default connection has already been configured. It may look similar to the screenshot below (possibly with a somewhat obscure name). Click on the card for this connection. 

    **NOTE:** If you don't see your Autonomous Database here then it means the ODI deployment script could not scan your database due to some privilege or policy issues. In that case, we will manually add a new connection to your database. Skip to step 5.

    ![ALT text is not available for this image](images/lab05-task01-02.jpg)

3. Override the default values of the fields indicated below with the following values:

    - Name - MovieStream

    - User - QTEAM

    - Password - (the password you specified for user QTEAM)

    ![ALT text is not available for this image](images/lab05-task01-03.jpg)

4. Review the connection details in the panel to the right, and press **Test Connection**.

    All being well, you'll get a message to confirm that the connection test has succeeded, similar to this. If not, verify and correct your entries and try again.

    ![ALT text is not available for this image](images/lab05-task01-04.jpg)

5. **NOTE:** Skip to step 8 if your Autonomous Database connection was automatically created in previous steps. We will manually create a connection to your Autonomous Database if it was not there. **You need to download wallet file for you autonomous Database to your local laptop. Come back to this step after you have downloaded the wallet file.**

    Click on **Create Connection**.

    ![ALT text is not available for this image](images/lab05-task01-05.jpg)

6. Enter the name for the connection &quot;MovieStream&quot;, click on Oracle in **Connection Type** and click **Next**.

    ![ALT text is not available for this image](images/lab05-task01-06.jpg)

7. Enable **Use Credential File**. Drag and drop the **Wallet File**. Select a **Service** (```your_db_name```_low) and enter your **user** and **password**.

    Click **Test** and after successful connection click **Create** to create the connection to your Autonomous Database.

    ![ALT text is not available for this image](images/lab05-task01-07.jpg)

8. Notifications for many important operations are logged while you use Data Transforms. To view these notifications, click on the bell at the top of the screen, and you'll see a summary of these, which may look like this.

    ![ALT text is not available for this image](images/lab05-task01-08.jpg)

9. Now we need to import the definitions of the tables in QTEAM's schema. Click on **Data Entities** (on the left of the screen) and then **Import Data Entities**. 

    ![ALT text is not available for this image](images/lab05-task01-09.jpg)

10. The following dialog appears. Identify the connection and schema from which to load metadata and press **Start**. You will get the notification for the import job. It will take few minutes for the job to finish.

    ![ALT text is not available for this image](images/lab05-task01-10.jpg)

11. You'll see a list of all five tables imported so far (wait for few minutes for the import job to finish and refresh if you don't see it). Type **movie** into the filter on the left of the screen to reduce the list of tables displayed to just one table: `MOVIE_SALES_2020`. Click the three dots to the right of the table's entry on the list and select **Preview**. 

    ![ALT text is not available for this image](images/lab05-task01-11.jpg)

12. As expected, we see again here the data errors that we identified at the end of the Data Load section of the workshop: We have data for all of 2020, whereas the the task assigned to the departmental analyst is to analyze only the data from Q2. We see that some of the values for DAY are upper case, while others are in title case. (This is not an uncommon situation where there are incremental loads of data into source systems, and is likely what has happened here. In general we need to be able to accommodate and correct these data errors, which is why it's invaluable to have a Data Transform capability built into Autonomous Data Warehouse.) Again, our mission here is to correct these errors.

    ![ALT text is not available for this image](images/lab05-task01-12.jpg)

You may already have noticed that the look-and-feel of the data previewer is consistent both here in the Data Transforms tool and in the Data Load tool that we used in the previous section of the workshop. Autonomous Database tools are integrated across the suite, with consistent user experience to minimize learning curve.

Close the preview pane by pressing the **X** on the upper right of the screen.

**Create Data Flow**

1. Click **Projects** (on the left of the screen, and then click **Create Data Flow.**

    ![ALT text is not available for this image](images/lab05-task02-01.jpg) 

2. In the Data Transforms tool, Data Flows are organized within projects. As we have neither yet, the dialog that appears allows us to define both in a single step. Specify the following values in the dialog, as shown below, and click **Create**.

    - **Name:** MovieStream_Q2FY2020
    - **Create new Project:** Radio button selected
    - **Project Name:** MovieStream
    - **Description: **Extract & fix data for Q2 FY2020

    ![ALT text is not available for this image](images/lab05-task02-02.jpg) 

3. This will open the Data Flow Details screen, which looks like this:

    ![ALT text is not available for this image](images/lab05-task02-03.jpg) 

4. This screen is divided into four sections, as shown in the annotations here:

    ![ALT text is not available for this image](images/lab05-task02-04.jpg) 

    In the next few steps, we're going to define a data flow as follows:

      - Apply a filter to table `MOVIE_SALES_2020` to remove data for the months outside Q2.

      - Fix the inconsistencies in the case of the DAY column.

      - Push the resulting data to a new table MOVIE\_SALES\_2020**Q2**. 

      Here goes!


5. We'll begin to build our first Data Flow with the following steps:

    - In the **Data Entities** pane, click the refresh button (circular arrows) at the top.

    - Expand the QTEAM schema to see the list of tables.

    - From the list that appears, click on table `MOVIE_SALES_2020`.

    - Drag `MOVIE_SALES_2020` to the **canvas**. (Pro tip: select the table name in one click-and-release, and drag it to the canvas in a second mouse gesture.)

    - From the **Tool Palette**, click on the **DATA TRANSFORM** tab if it is not already highlighted.

    - Drag the **Filter** tool to the canvas.

    - Click on the bubble for the Filter tool to select it.

    - In the **Properties** pane, specify a name for the filter: **Q2_Only**

    - On the **Canvas**, click on the bubble for the table `MOVIE_SALES_2020`.

    - Notice that the stub of an arrow appears to the right of `MOVIE_SALES_2020`. Grab this with your mouse and drag-and-drop it to connect it to the filter. 

    ![ALT text is not available for this image](images/lab05-task02-05.jpg) 

6. After completing these steps, select the filter bubble on the canvas. The screen should look like this:

    ![ALT text is not available for this image](images/lab05-task02-06.jpg) 

7. Now we need to define the properties of the filter. With the filter bubble selected, click the filter condition (circle) and then click the edit button (pencil), as shown below.

    ![ALT text is not available for this image](images/lab05-task02-07.jpg) 

8. In the expression editor that appears, complete the filter conditions. As shown below, with the drag-and-drop editor:

    - Expand the table definition

    - Drag column `MONTH` to the Expression canvas

    - Add the expression:

    `in ('April','May','June')`

    ![ALT text is not available for this image](images/lab05-task02-08.jpg) 

9. The next step is to fix the data problem with column `MOVIE_SALES_2020.DAY`. Do this as follows, as illustrated below:

    - In the **Tools Palette**, click on the **DATA PREPARATION** tab. 

    - Drag the **Data Cleanse** tool on to the **Canvas**.

    - Click on the `Q2_Only` filter bubble on the canvas and drag the arrow stub from that to the Data Cleanse tool.

    - Click on the Data Cleanse tool on the Canvas to select it.

    - Specify a meaningful name (&quot;Fix\_AllCap\_Days&quot;) and description (&quot;Convert all values in column DAY to Title Case.&quot;)

    ![ALT text is not available for this image](images/lab05-task02-09.jpg) 

10. Press the expand button to the upper right

    ![ALT text is not available for this image](images/lab05-task02-10.jpg) 

11. Click the **Attributes** tab towards the center of the Properties pane that appears. 

    ![ALT text is not available for this image](images/lab05-task02-11.jpg) 

12. We need to cleanse the data in column MOVIE\_SALES\_2020.DAY, by removing leading and trailing white space, and converting to title case. Select the appropriate options as shown below. 

    ![ALT text is not available for this image](images/lab05-task02-12.jpg) 

13. When you've finished, press the collapse button (opposing diagonal arrows) in the upper right. 

    ![ALT text is not available for this image](images/lab05-task02-13.jpg) 

14. Finally, we create a table into which to load the data after it has been filtered and cleansed. 

    Select the Data Cleanse bubble *Fix\_AllCap\_Days*, and then click the grid-like table icon to the upper right of the bubble.

    ![ALT text is not available for this image](images/lab05-task02-14.jpg) 

15. The **create table** dialog that appears, as shown below. Specify the table name as MOVIE\_SALES\_2020**Q2**. (Note the suffix **Q2**.) Accept the default alias, and press **Save**. 

    ![ALT text is not available for this image](images/lab05-task02-15.jpg) 

16. Drag the `MOVIE_SALES_2020Q2` bubble a little to the right, as shown, and in the properties pane press the Expand button as shown below.

    ![ALT text is not available for this image](images/lab05-task02-16.jpg) 

17. There are various tabs in the expanded properties pane. This is the Attributes view.

    ![ALT text is not available for this image](images/lab05-task02-17.jpg) 

18. Click on the Column Mapping tab, which looks like this:

    ![ALT text is not available for this image](images/lab05-task02-18.jpg) 

19. Since we haven't run this Data Flow yet, the table doesn't exist, so there is nothing to see in Preview. We'll return to this a little later in this exercise. 

    For now, press **Options**, which brings up the following dialog. Be sure that **Create target table** is set to **True**, because the table doesn't exist yet. 

    ![ALT text is not available for this image](images/lab05-task02-19.jpg) 

20. Press collapse (two diagonally opposing arrows in the upper right of the Properties pane)

    ![ALT text is not available for this image](images/lab05-task02-20.jpg) 

This takes us back to the main Data Flow screen, in which we can see our completed Data Flow.

21. Run the Data Flow

    What remains to be done is:

    - Press Save (floppy disk icon).

    - Press Run (green play icon).

    ![ALT text is not available for this image](images/lab05-task02-21.jpg) 

**RECAP – Basic Steps**

In the previous steps we have:

- Imported Data Entities

- Defined a Data Flow, including:

    - Filtered out months not in Q2

    - Converted all values for column MOVIE\_SALES\_2020.DAY to Title Case

    - Created table MOVIE\_SALES\_2020**Q2** for the now-corrected data set

- Run the Data Flow

Having completed these steps we now have a table MOVIE\_SALES\_2020**Q2**, with data for just April, May &amp; June. The days have all be changed to title case.

**Inspect Job Details**

#### Driver or Mechanic?
*We love thrilling car races. Fans can often be sorted into two groups: the drivers and the mechanics. The drivers want to strap in behind the wheel, rev the engine and burn some rubber. The mechanics want to get under the hood and tinker with the gears and the carburetor. Here's the point at which you can self-select as a driver or a mechanic.*

  ![ALT text is not available for this image](images/lab05-task03-00driver-or-mechanic.jpg)


##### **Driver**

The next several steps in this section are optional, and explore the Data Transforms tool in more depth. If you are not interested in these topics at this stage, Press **OK**. Table MOVIE\_STREAM\_2020Q2 will have been successfully created, with just the data you need, nicely cleansed. Who cares what code got executed to achieve this? The whole point of Data Transforms is for it to be easy to use by people who don't need to be developers! If that's how you feel about life, we applaud your serenity and sense of priorities. you now skip ahead to the **RECAP** section at the end. Varroooommmm!

##### **Mechanic**

Hello! If you've read this far, you've self-identified as curious (at best), or, perhaps even a skeptic! We have a &quot;big tent&quot; philosophy and that's just fine with us, too. Actually, we're quite keen to show off all the stuff that's going on behind the scenes while the user is enjoying playing with a nice drag-and-drop UI. The next few sections go into some depth on these topics. If you're mechanically-minded, roll up the sleeves of your overalls and press the link to the Job that was just created, as indicated above. 

1. Going A Little Deeper Into The Transformation Process

    To click on the link to the Job is take the *red pill*: We're well and truly on our way to the Oracle, where we'll learn what's really happening behind the scenes. 

    You'll have landed on a page that looks like this. Notice that the job has been implemented in this instance as two steps:

    - Create target table

    - Insert new rows

    Click on the link for step 3, as shown below.

   ![ALT text is not available for this image](images/lab05-task03-01.jpg)

2. A panel will pop up on the right of the screen with details for this step. Click on the **Target Connection** tab at the top to see the execution details for *Step 2*. You'll notice how the individual steps of the Data Flow were implemented:

    - Filter Q2_2020 is implemented by a predicate in the WHERE clause:MONTH IN ('April','May','June')

    - Data Cleanse operation Fix\_AllCap\_Days is implemented with the string operation INITCAP(TRIM(MOVIE\_SALES\_2020.DAY))

   ![ALT text is not available for this image](images/lab05-task03-02.jpg)

3. Now, for those *Blue Pill* types, these are pearls before swine, but we *Red Pillers* can spend a moment to admire how these operations are implemented in SQL in Autonomous Database.

    When you're satisfied, press **Close**. Then, press **Jobs** in the breadcrumb at the upper left of the screen to return to the Data Transforms main page. 

   ![ALT text is not available for this image](images/lab05-task03-03.jpg)

**Create Workflow**

Good engineering practice is to build and thoroughly test (with both positive and negative cases) components of functionality. These components can then be combined into larger modules. The Data Transforms tool supports this best practice, with Data Flows representing the elemental components, and Workflows the assembly of these components into larger modules. In this exercise we'll simulate this approach. We begin by creating two additional Data Flows in project *MovieStream*:

  - Error_Handling – a unified error handling module

  - Nightly_Batch – an incremental load of data from the last day of operations

1. Following the procedures we've already covered (under *Lab 5 - Using Data Transforms / Create Data Flow*) create the definition for these two Data Flows. Note that for the purposes of this workshop it is sufficient merely to create the Data Flow headers. These additional flows are only for illustrations and don't do anything. In practice there will be real data flows that you may want to include in a workflow.

  ![ALT text is not available for this image](images/lab05-task04-01.jpg)

2. Having defined these two new Data Flows, click the Workflows tab on the left of the screen, then press **Create Workflow**.

  ![ALT text is not available for this image](images/lab05-task04-02.jpg)

3. Give the Workflow the name &quot;*MovieStream_Incremental&quot;* , and press  **Create** . 

  Note: Workflow names must be single words, so the underscore between *MovieStream* and *Incremental* is very important here. 

  ![ALT text is not available for this image](images/lab05-task04-03.jpg)

4. We now arrive at the Workflow page. This has a similar layout to the Data Flow page, with Resources to the left, a Tool Palette at the top, Properties pane to the right and a Canvas in the middle. 

  Expand the DefaultFolder on the left and drag the three Data Flows on to the canvas as shown below:

  ![ALT text is not available for this image](images/lab05-task04-04.jpg)

  In this workflow we're going to define the processing logic as follows:

    - Data Flow *Nightly\_Batch* executes first

    - If *Nightly\_Batch* succeeds, execute *Movie\_Stream\_Q2FY2020*

    - If *Nightly\_Batch* fails, execute *Error\_Handling*

    - If *Movie\_Stream\_Q2FY2020* fails, execute *Error\_Handling*

  It's actually easier to see it on the screen than it is to type it out in prose!

5. Create success condition

    - Click on the green **ok** arrow in the tool palette. (This is for the success condition.)

    - Click on the bubble for Data Flow *Nightly\_Batch*.

    - Drag the arrow stub from *Nightly\_Batch* to *Movie\_Stream\_Q2FY2020*.

  ![ALT text is not available for this image](images/lab05-task04-05.jpg)

6. Create failure condition

    - Click on the red **nok** arrow in the tool palette. (This is for the failure condition.)

    - Click on the bubble for Data Flow *Nightly\_Batch*.

    - Drag the arrow stub from *Nightly\_Batch* to *Error\_Handling*.

  ![ALT text is not available for this image](images/lab05-task04-06.jpg)

7. Complete the Workflows

    Repeat these steps to complete the workflow as follows, being sure to press the **Save** button (disk image) when you're finished:

  ![ALT text is not available for this image](images/lab05-task04-07.jpg)

    After completing the definition of the Workflow, navigate back to the Data Transforms main page by pressing **Projects** in the breadcrumb at the upper left of the screen.

**Create Schedules**

The typical process for development with Data Transforms will be first to develop and test Data Flows individually. These will then be assembled into Workflows, which are then tested in turn. During development and testing, the validation of these Data Flows and Workflows will initially by executed on demand. As they move into production, they typically transition to &quot;lights out&quot; operations, being executed automatically against a schedule. The definition of these schedules is the topic of this section. 

1. Press the **Schedules** tab to the left of the screen, then press Create Schedule.

    ![ALT text is not available for this image](images/lab05-task05-01.jpg)

2. From the pick list next to Resource, you'll notice that schedules can be defined either for Data Flows or Workflows. The procedure is very similar for both cases. In this workflow, we'll define a schedule for a Workflow, so select that.

    Give a name to the schedule: "My_Schedule."

    ![ALT text is not available for this image](images/lab05-task05-02.jpg)

3. In the pick list for Resource Name, select the Workflow we just created *MovieStream_Incremental*

    ![ALT text is not available for this image](images/lab05-task05-03.jpg)

4. Specify the regular day and time at which this Workflow is to be executed. In the screenshot below, we're scheduling it for 2am on Wednesday mornings.

    ![ALT text is not available for this image](images/lab05-task05-04.jpg)

5. Press **Save** and return to the **Schedules** main page.

    ![ALT text is not available for this image](images/lab05-task05-05.jpg)

### Conclusion

In this lab we’ve covered simple to some relatively advanced features of the Data Load tool, but we have to be honest: it’s all still pretty easy. These topics were:

<ul style="text-decoration: none;">

- Data flow - A data flow is process of transforming data from various sources and loading into target tables

- Jobs – Each time a Data Flow or a Workflow executes, it is recorded as a Job

- Workflows – A workflow is an assembly of a number of Data Flows

- Schedules – Data Flows and Workflows can either be executed on demand, or on automated schedule
