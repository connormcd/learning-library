# Setup

## Introduction

In this lab, we will provision and setup the resources to execute microservices in your tenancy.  

Estimated Time: 25 minutes

Watch the video below for a quick walk through of the lab.

[](youtube:yqCbkHh9EVA)

### Objectives

* Clone the setup and microservices code
* Execute setup

## Task 1: Log in to the Oracle Cloud Console and Launch the Cloud Shell

1. If you haven't already, sign in to your account.

## Task 2: Select the Home Region

1. Be sure to select the **home region** of your tenancy.  Setup will only work in the home region.

  ![Oracle Cloud Infrastructure Home Region](images/home-region.png " ")

## Task 3: Create group and IAM policies
A user's permissions to access services comes from the groups to which they belong. The permissions for a group are defined by policies. Policies define what actions members of a group can perform, and in which compartments. Users can access services and perform operations based on the policies set for the groups of which they are members.

If you are not an administrator on your tenancy, you must insure that additional policies have been added to the group you are a member of or ask your admin to create a separate group for you with additional policies. This group will have IAM policies for creating and managing the resources within the compartment that will be created by workshop setup scripts.

Here are the steps for creating a new group and assigning security policy required for this workshop (only a user with the admin account will be able to perform the below steps):

1. Click the Navigation Menu in the upper left, navigate to Identity & Security and select Groups.

  ![Oracle Cloud Infrastructure Identity & Security Groups Screen](images/id-groups.png " ")

2. Click Create Group.

  ![Create Oracle Cloud Infrastructure Identity & Security Group Screen](images/create-group.png " ")

3. In the Create Group dialog box, enter the following:
 - **Name**: Enter a unique name for your group, such as "MicroservicesAdmin”. Note that the group name cannot contain spaces.
 - **Description**: Enter a description (for example, “New group for microservices workshop”).
 - Click **Create**.

  ![Create a New Group](images/new-group.png " ")

  ![Review a New Group](images/get-new-group.png " ")

 4. Now, create a security policy that gives the group permissions to execute the setup steps for this workshop, entering a name, such as "Microservices-Policies".

  ![Create a New Securiry Policy](images/create-policy.png " ")

   Using **Edit Policy Statement** option, add the below statements to the policy created above.

   ```
   <copy>
   Allow group MicroservicesAdmin to use cloud-shell in tenancy
   Allow group MicroservicesAdmin to manage users in tenancy
   Allow group MicroservicesAdmin to manage all-resources in tenancy

   Allow group MicroservicesAdmin to manage vaults in tenancy
   Allow group MicroservicesAdmin to manage buckets in tenancy
   Allow group MicroservicesAdmin to manage objects in tenancy

   </copy>
   ```

  ![Policy Statements](images/policy-statements.png " ")

5. And finally, make sure your user account has been added to the group created in step#2.

## Task 4: Check Your Tenancy Service Limits

If you have already used up some quota on your tenancy, perhaps while completing other workshops, there may be insufficient quota left to run this workshop. The most likely quota limits you may exceed are summarized in the following table.

| Service          | Scope  | Resource                                             | Available | Free Account Limit |
|------------------|:------:|------------------------------------------------------|:---------:|:------------------:|
| Compute          | AD-1   | Cores for Standard.E2 based VM and BM Instances      | **3**     | 6                  |
| Container Engine | Region | Cluster Count                                        | **1**     | 1                  |
| Database         | Region | Autonomous Transaction Processing Total Storage (TB) | **2**     | 2                  |
|                  | Region | Autonomous Transaction Processing OCPU Count         | **4**     | 8                  |
| LbaaS            | Region | 100Mbps Load Balancer Count                           | **3**     | 3                  |

Quota usage and limits can be check through the console: **Governance & Administration** -- **Governance** -- **Limits, Quotas and Usage**, For example:

  ![Oracle Cloud Infrastructure Service Limit Example](images/service-limit-example.png " ")

The Tenancy Explorer may be used to locate existing resources: **Governance & Administration** --> **Governance** --> **Tenancy Explorer**. Use the "Show resources in subcompartments" feature to locate all the resources in your tenancy:

  ![Oracle Cloud Infrastructure Show Subcompartments](images/show-subcompartments.png " ")

It may be necessary to delete some resources to make space to run the workshop.  Once you have sufficient space you may proceed to the next step.

## Task 5: Launch the Cloud Shell

Cloud Shell is a small virtual machine running a "bash" shell which you access through the  'Oracle Cloud Console. Cloud Shell comes with a pre-authenticated command line interface which is set to the  'Oracle Cloud Console' tenancy region. It also provides up-to-date tools and utilities.

1. Click the Cloud Shell icon in the top-right corner of the Console.

  ![Oracle Cloud Infrastructure Cloud Shell Opening](images/open-cloud-shell.png " ")

  > **Note:** Cloud Shell uses websockets to communicate between your browser and the service. If your browser has websockets disabled or uses a corporate proxy that has websockets disabled you will see an error message ("An unexpected error occurred") when attempting to start Cloud Shell from the console. You also can change the browser cookies settings for a specific site to allow the traffic from *.oracle.com

## Task 6: Create a Folder to Contain the Workshop Code

1. Create a directory to contain the workshop code. The directory name will also be used to create a compartment of the same name in your tenancy.  The directory name must have between 1 and 13 characters, contain only letters or numbers, and start with a letter.  Make sure that a compartment of the same name does not already exist in your tenancy or the setup will fail. For example:

   ```
   <copy>
   mkdir grabdish
   </copy>
   ```

  All the resources that are created by the setup will be created in this compartment.  This will allow you to quickly delete and cleanup afterwards.  

2. Change directory to the directory that you have created. The setup will fail if you do not complete this step. For example:

   ```
   <copy> 
   cd grabdish
   </copy>
   ```

## Task 7: Make a Clone of the Workshop Setup Script and Source Code

1. To work with the application code, you need to make a clone from the GitHub repository using the following command.  

   ```
   <copy>
   git clone -b 22.3.1 --single-branch https://github.com/oracle/microservices-datadriven.git
   </copy>
   ```

   You should now see the directory `microservices-datadriven` in the directory that you created.

## Task 8: Start the Setup

1. Execute the following sequence of commands to start the setup.  

   ```
   <copy>
   source microservices-datadriven/workshops/dcms-oci/source.env
   setup
   </copy>
   ```

   **Note:** Cloud shell may disconnect after a period of inactivity. If that happens, you can reconnect and then run the command to resume the setup.

   The setup process will typically take around 20 minutes to complete.  

2. The setup will ask you to confirm that there are no other un-terminated OKE clusters exist in your tenancy.

   ```
   <copy>
   You are limited to only one OKE cluster in this tenancy. This workshop will create one additional OKE cluster and so any other OKE clusters must be terminated.
   Please confirm that no other un-terminated OKE clusters exist in this tenancy and then hit [RETURN]?
   </copy>
   ```
  To confirm that there are no other un-terminated OKE clusters, click the Navigation Menu in the upper left of Oracle Cloud Console, navigate to Developer Services and click on Kubernetes Clusters (OKE).

  ![Oracle Cloud Infrastructure Developer Services Screen](images/dev-services-menu.png " ")

  ![Navigate to Oracle Cloud Infrastructure OKE Screen](images/get-oke-info.png " ")

  If there are any un-terminated OKE clusters, please delete them and continue with setup steps.

  ![Review Oracle Cloud Infrastructure Kubernetes Cluster Details](images/get-oke-details.png " ")

3. The setup will create the workshop resources in a compartment within your tenancy. You will be prompted to enter the compartment information.  You may choose to use an existing compartment or create a new one.

  To use an existing compartment, enter the OCID of the compartment.

  To create a new compartment, enter the name you would like to use.

  If you chose to create a new compartment, you will also be asked to enter the OCID of the parent compartment in which the new compartment is to be created.  Enter the parent compartment OCID or hit enter to use the root compartment of your tenancy.

  To get the OCID of an existing compartment, click on the Navigation Menu in the upper left of Cloud Console, navigate to **Identity & Security** and click on **Compartments**:

  ![Navigate to Oracle Cloud Infrastructure Compartments Screen](images/compartments.png " ")

  Click on the link in the **OCID column** of the compartment, and click **Copy**:

  ![Obtain Oracle Cloud Infrastructure Compartment OCID](images/compartment-ocid.png " ")

4. The setup will ask for you to enter your user's OCID.  

  Be sure to provide the user OCID and not the user name or tenancy OCID. The user OCID will look something like:

   `ocid1.user.oc1..aaaaaaaanu5dhxbl4oiasdfasdfasdfasdf4mjhbta`

  > **Note:** Notice the format of "ocid1.user" prefix.

  Locate your menu bar in the Cloud Console and click the person icon at the far upper right. From the drop-down menu, select your user's name. Note, sometimes the name link is missing in which case select the **User Settings** link. Do not select the **Tenancy** link.

  ![Obtain Oracle Cloud Infrastructure User OCID](images/get-user-ocid.png " ")

  Click Show to see the details and then click Copy to copy the user OCID to the clipboard, paste in the copied data in console.

  ![Oracle Cloud Infrastructure User OCID Example](images/example-user-ocid.png " ")

5. The setup will automatically upload an Auth Token to your tenancy so that docker can log in to the Oracle Cloud Infrastructure Registry. If there is no space for a new Auth Token, the setup will ask you to remove an existing token to make room. This is done through the Oracle Cloud Console.

  Locate your menu bar and click the person icon at the far upper right. From the drop-down menu, select your user's name.

  ![![Obtain Oracle Cloud Infrastructure User Name]](images/get-user-ocid.png " ")

  On the User Details console, click Auth Tokens under Resources.

  ![Review Oracle Cloud Infrastructure User Auth Token Screen](images/auth-token.png " ")

  On the Auth Tokens screen, highlight the existing token(s) and delete by clicking Delete from the drop-down menu.

  ![Delete Oracle Cloud Infrastructure User Auth Token](images/delete-auth-token.png " ")

6. The setup will ask you to enter an admin password for the databases. For simplicity, the same password will be used for both the order and inventory databases. Database passwords must be 12 to 30 characters and contain at least one uppercase letter, one lowercase letter, and one number. The password cannot contain the double quote (") character or the word "admin".

7. The setup will also ask you to enter a UI password that will be used to enter the microservice frontend user interface. Make a note of the password as you will need it later.  The UI password must be 8 to 30 characters.

## Task 9: Monitor the Setup

The setup will provision the following resources in your tenancy:

| Resources              | Oracle Cloud Console Navigation                                               |
|------------------------|-------------------------------------------------------------------------------|
| Object Storage Buckets | Storage -- Object Storage -- Buckets                                        |
| Databases (2)          | Oracle Database -- Autonomous Database -- Autonomous Transaction Processing   |
| OKE Cluster            | Developer Services -- Containers -- Kubernetes Clusters (OKE)                 |
| Registry Repositories  | Developer Services -- Containers -- Container Registry                        |

1. You should monitor the setup progress from a different browser window or tab.  It is best not to use the original browser window or not to refresh it as this may disturb the setup or you might lose your shell session. Most browsers have a "duplicate" feature that will allow you to quickly created a second window or tab.

  ![Duplicate Browser](images/duplicate-browser-tab.png " ")

2. From the new browser window or tab, navigate around the console to view the resources within the new compartment. The table includes the console navigation for each resource. For example, here we show the database resources:

  ![Database Resources](images/db-example.png " ")

  >**Note:** Cloud Shell sessions have a maximum length of 24 hours, and time out after 20 minutes of inactivity.

## Task 10: Complete the Setup

1. The setup will provide a summary of the setup status as it proceeds. Once everything has completed you will see the message: **SETUP COMPLETED**.

2. While the background setup jobs are running you can monitor their progress with the following command.

   ```
   <copy>
   ps -ef
   </copy>
   ```

3. You can monitor log files located in the $GRABDISH_LOG directory.

   ```
   <copy>
   ls -al $GRABDISH_LOG
   </copy>
   ```

  Once the setup has completed you are ready to [move on to Lab 2](#next).

  > **Note:** Builds may continue to run even after the setup has completed. 
  
4. The status of the builds can be monitored with this command:

   ```
   <copy>
   status
   </copy>
   ```

You may now proceed to the next lab.

## Acknowledgements

* **Authors** - Paul Parkinson, Developer Evangelist; Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata; Irina Granat, Consulting Member of Technical Staff, Oracle MAA and Exadata
* **Adapted for Cloud by** - Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Richard Exley, April 2021
