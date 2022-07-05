# Load and Prepare Data

## Introduction

In this lab, we will start from a newly created Oracle Autonomous Database instance and prepare it for the workshop.

 You will collect the connection details and create the users and passwords. Using them, you will load the data into Autonomous Database and prepare to use it in Oracle Machine Learning Notebooks.


Estimated Lab Time: 15 minutes

### Objectives
*	Create the OMLUSER user
* Load data into ADB



### Prerequisites
* Oracle Cloud Infrastructure (OCI) account
* Autonomous Database deployed in Oracle Cloud
* ADMIN user password for Autonomous database


## Task 1:  Create the OMLUSER user

* Connect to the Oracle Cloud Infrastructure (OCI) Console and go to the Autonomous Database home page.
* Click on the target Autonomous Database instance
![ADB-instance](images/prerequisites-screenshot-1.jpg)

* In the Autonomous Database instance, click on the Tools tab and click on the **Open Oracle ML User Administration**
![ADB-instance-home](images/prerequisites-screenshot-13.jpg)

* In the Oracle Machine Learning Database Administrator credentials page, enter the username: **ADMIN** and password.
![ADB-oml-admin](images/prerequisites-screenshot-14.jpg)

* In the Machine Learning User Administration, we see only the ADMIN user with the System Administrator role. Click on the Create button to create another user.
![ADB-oml-admin](images/prerequisites-screenshot-15.jpg)

* In the Create User page, please enter the following:

- Username: **OMLUSER**;
- Email Address: **An email address**;
- **Un-check**: Generate password and email the account details to user;
- Password: Chose a password. Throughout the workshop we are using **Welcome12345** as a password for OMLUSER;
- Confirm Password: **Retype the password**;


Click Create.
![ADB-oml-user](images/prerequisites-screenshot-16.jpg)

* Now, we have a new user named OMLUSER available.
![ADB-oml-user](images/prerequisites-screenshot-17.jpg)

  OMLUSER is also a database user, and for the moment, he doesn't have access to our data. The next step is to load our data in the OMLUSER schema.



## Task 2: Loading the data

* In the Autonomous Database instance detail page, click on the Database Actions button.
![ADB-instance-tools](images/prerequisites-screenshot-3.jpg)

* The Database Actions launchpad page is now open and connected by default with the ADMIN user. Here we have multiple tools available to easily manage and use the database, develop new applications or REST modules, or manage data inside the database.

 We will choose SQL option in the Development category.
![ADB-data-load](images/prerequisites-screenshot-6.jpg)

* Select the Data Loading tab in the middle part of the screen.
![ADB-data-load](images/prerequisites-screenshot-7.jpg)

* Download the [cust\_insur\_ltv.csv](https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/NIPrIgDVBKsOBi_xnF5_ZHWAnlilwwnUbrgQbUA24iupm6ryoNkvp_KZ9qywzpQE/n/oraclepartnersas/b/ADB_Stage/o/cust_insur_ltv.csv) and load it using Drag and drop on the delimited section.
![ADB-select-file](images/prerequisites-screenshot-X9.jpg)

* The file is parsed and a preview is displayed on the screen. Check the priview and click Next.
![ADB-load](images/prerequisites-screenshot-9.jpg)

* The Table Definition screen.
![ADB-load-settings](images/prerequisites-screenshot-10.jpg)

Here, you should update the following:
 - Change the target Schema to **OMLUSER**
 - Change the target Table Name to **CUSTOMER_INSURANCE**

You can keep the default table and mapping options.


Click Next.

* In the Review screen, click on Finish to start the data load.
![ADB-data-load](images/prerequisites-screenshot-11.jpg)

* The uploading data confirmation shows up.
![ADB-data-load](images/prerequisites-screenshot-X11.jpg)

* The data loading process takes less than a minute. When completed, please notice the entry on the Data Loading tab.
![ADB-data-load-completed](images/prerequisites-screenshot-12.jpg)

* When you click on the row, you will get a confirmation.
![ADB-data-load-completed](images/prerequisites-screenshot-X12.jpg)

* Click OK.


The next step is to use this data and create an AutoML model.

You may now [proceed to the next lab](#next).

## Acknowledgements
* **Authors** -  Andrei Manoliu, Milton Wan
* **Contiributors** - Rajeev Rumale, Mark Hornick, Sherry LaMonica
* **Last Updated By/Date** -  Andrei Manoliu, December 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
