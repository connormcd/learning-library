# Creating New Environment Template

## Introduction

This lab walks you through the steps to create a new environment template from the previously downloaded PeopleSoft Image

Estimated Lab Time: 20 minutes

### Objectives
The purpose of this lab is to show you how to create a new environment template from a downloaded PeopleSoft Image in order to create a new PeopleSoft Environment.

In this lab, you will:
* Create a new environment template

Let's take a look at the Network Topology again, so we can understand what we are configuring.

We have already provisioned Cloud Manager in a private subnet (cm) and the Bastion in a private subnet (bastion). We created a template of 2 nodes:
* Linux Full Tier in private subnet (ft)
* PeopleSoft Client in private subnet (win)


![](./images/architecture13.png "")

### Prerequisites
- A PeopleSoft Cloud Manager Instance
- A downloaded PeopleSoft Image

## Task 1: Creating a New Environment Template and General Details

Navigate to Cloud Manager Dashboard -> **Environment Template**
    ![](./images/1dashtemp.png "")

Click **Add New Template** button.
    ![](./images/2addtemp.png "")

1. Fill out the General Settings as follows:
    - Name: **PUMFT**
    - Description **HCM 9.2 FT: Linux and Windows node**
    ![](./images/tempnamedescription.png "")

2. For Select PeopleSoft Image, click the **search icon**. Do NOT type anything. If your DPK was downloaded properly, it should appear in the Search Results. If you can't see it yet, please wait and refresh the page after awhile. Since we subscribed to the HCM channel in Lab 7, we see **PEOPLESOFT HCM UPDATE IMAGE 9.2.40 - NATIVE OS** 
    ![](./images/imagesearch.png "")
    ![](./images/hcmsearch.png "")

  Click **Next** when you have this:
    ![](./images/3tempname.png "")

## Task 2: Select Topology
1. Click the **search icon** and select **PUM Fulltier** for the topology
2. Expand **Custom Attributes** and select **PUM Fulltier** again from the drop down.
3. Click on **Edit Custom Attributes**
    ![](./images/5selecttopv2.png "")
4. Fill in the Region and Availability Domains as follows:
    * Region: **us-ashburn-1**
    * Primary Availability Domain: **________-AD-1** (Depends on the AD you selected. In this case, we are using Ashburn)
    * Default Compartment: **Demo**
    * Default Virtual Cloud Network: **PSFTVCN(Demo)** 
    ![](./images/regioninfo.png "")
5. Now, expand **Full Tier** > **General Settings**
    * Line 6- Database Name: **MYPUMDB**
    * Line 9- Database Operator Id: **PS**
    ![](./images/gensettings.png "")
6. Now, expand **Full Tier** > **Network Settings**
    * Compartment: **Demo**
    * Subnet For Primary Instance: **ft**
    ![](./images/ftnetwork.png "")
7. Now, expand **PeopleSoft Client** > **Network Settings**
    * Compartment: **Demo**
    * Subnet For Primary Instance: **win**
    ![](./images/winnetwork.png "")
8. Scroll back up and click on **Validate Network**
    ![](./images/10validatenetwork.png "")

  You should see something like this:
    ![](./images/11validationok.png "")

Click **Next**

## Task 3: Security and Policies

Now, we'll select the Zone and Role Names

1. Click the **search icon** for **Zone Name**
    ![](./images/12searchzone.png "")

  Select **Test**
    ![](./images/13searchtest.png "")

2. Click the **search icon** for **Role Name**
    ![](./images/14searchrole.png "")

  Expand the **Search Criteria** at the top, type in **PACL\_CAD**, and click **Search**
    ![](./images/15searchrole.png "")
  Select **PACL\_CAD**
    ![](./images/16searchrole.png "")

When you see this, click **Next**
  ![](./images/17next.png "")


## Task 4: Summary

Review the Environment Template and click **Submit**
    ![](./images/submit.png "")

You should now see your Environment Template here:
    ![](./images/finishedtemp.png "")


You may now **proceed to the next lab.**

## Acknowledgments

**Authors** 
* **Authors** - Megha Gajbhiye, Cloud Solutions Engineer; Sara Lipowsky, Cloud Engineer
* **Last Updated By/Date** - Sara Lipowsky, Cloud Engineer, January 2022

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/Migrate%20SaaS%20to%20OCI). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.