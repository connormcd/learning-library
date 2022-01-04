# Lab: Getting Started with OCI Data Science

## Introduction

This lab will guide you on provisioning an OCI Data Science environment.

Estimated lab time: 15 minutes (video 8 minutes, exercise +/- 80 minutes)

### Objectives

In this lab you will:
* Become familiar with the set up of the OCI Data Science service.

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account (see prerequisites in workshop menu)

## Task 1: Provision OCI Data Science

This guide shows how to use the Resource Manager to provision the service using Resource Manager. This process is mostly automated. However, if you prefer a step-by-step manual approach to control every aspect of the provisioning, please follow the following instructions instead: [manual provisioning steps](https://docs.cloud.oracle.com/en-us/iaas/data-science/data-science-tutorial/tutorial/get-started.htm#concept_tpd_33q_zkb).

1. Download the terraform configuration source

    Download [Terraform configuration source](https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/Y1AdqPkxQdFho1SEuMMO7W8DlMWAkr0FUwdnL-m3ysgXirfHz9IV48yyAkRARF-b/n/odca/b/datascienceworkshop/o/oci-ods-orm.zip) and store it on your local PC. Depending on the browser you might have to use Left/Right click to do this. Make sure the extension of the saved file is .zip

2. In your Oracle Cloud console, open the menu.
   ![](./images/openmenu.png)

3. Select Resource Manager -> Stacks.

   ![](./images/resourcemanager.png)

4. Click the "Create Stack" button.

   ![](./images/createstackbutton.png)

5. Select the configuration source you download earlier

    Select ".ZIP" and drag the file you downloaded to the box.

    ![](./images/select-zip.png)

6. Choose a compartment that you've created or use Root.

   ![](./images/newimage3.png)

7. Click "Next".

   ![](./images/newimage4.png)

8. Disable Project and Notebook creation

    In the section "Project and Notebook Configuration" *uncheck* the checkbox "Create a Project and Notebook Session" (we will create them using the console later).

    ![](./images/disable-ods-creation.png)

9. Make sure "Enable Vault Support" is disabled

   ![](./images/newimage6.png)

10. Make sure "Provision Functions and API Gateway" is disabled

   ![](./images/disablefunctions.png)

11. Click "Next".

   ![](./images/newimage7.png)

12. Click "Create".

   ![](./images/create.png)

13. Run the job

   Go to "Terraform Actions" and choose "Apply".

   ![](./images/applytf.png)

14. Click Apply once more to confirm the submission of the job.

   Provisioning should take about 5 minutes after which the status of the Job should become "Succeeded".

15. Create Oracle Data Science Project

    Open the OCI Data Science projects and choose "Create Project".

    ![](./images/open-ods.png)

    ![](./images/create-project-1.png)

    Choose a name and description and press "Create".

    ![](./images/create-project-2.png)

16. Provision an Oracle Data Science notebook

    ![](./images/create-notebook-1.png)

    - Select a name.
    - We recommend you choose VM.Standard2.8 (*not* VM.Standard.*E*2.8) as the shape. This is a high performance shape, which will be useful for tasks such as AutoML.
    - Set blockstorage to 50 GByte.
    - Select defaults for VCN and subnet. These should point to the resources that were created earlier by the resource manager.

    ![](./images/create-notebook-2.png)

    Finally click "Create". The process should finish after about 5 minutes and the status of the notebook will change to "Active".

## Task 2: Open the OCI Data Science notebook

1. Open the notebook that was provisioned

   The name of the notebook may be different than shown here in the screenshot.

   ![](./images/open-notebook.png)

   ![](./images/open-notebook2.png)

## Task 3: Install a Conda Package

   A Conda package is a collection of libraries, programs, components and metadata. It defines a reproducible set of libraries that are used in the data science environment. We are going to use the General Machine Learning for CPUs conda. The following commands will install this Conda.

   1. Open a terminal window by clicking on **File**, **New** and then **Terminal**.
   1. Run the command: `odsc conda install -s mlcpuv1`
   1. You will receive a prompt related to what version number you want. Press `Enter` to select the default.
   1. Wait for the conda package to be installed.

   This will take about 5 minutes.

## Task 4: Upload the Jupyter Notebook

1. Download the notebook and save it locally on your machine.

   The .ipynb notebook can be found at the below. 

   ![](files/ProphetForecasting.ipynb)

2. Upload the notebook

   Drag and drop the .ipynb file to the left hand side of the notebook session.

   ![](images/upload_notebook.png)

3. Select the installed kernel

   Open the .ipynb file, and select the kernel on the top right side of the page.

   ![](images/select_kernel.png)

   Select the kernel [conda env:mlcpuv1] from the drop down menu

   ![](images/select_kernel2.png)

4. Install fbprophet

   Next we will have to install the package fbprophet on the kernel. Fbprophet is a Python library that consists of useful time series forecasting tools.

   Run the first cell installs fbprophet and upgrades plotly and pandas libraries.

   ![](images/install2.png)

   ![](images/play.png)

5. Restart the Kernel

   In order for the tools in the mlxtend package to become available, you must restart the kernel.

   Select kernel in the drop down bar at the top of the page and then "Restart Kernel". Make sure to save everything first by selecting File -> Save Notebook.

   ![](images/restart2.png)

6. Import all the necessary libraries

   Run the second cell of the notebook that contains all the import statements. This will import the industry standard data science tools that we will use throughout the lab.

   ![](images/imports2.png)

[Proceed to the next section](#next).

## Acknowledgements
* **Authors** - Jeroen Kloosterman - Product Strategy Manager - Oracle Digital, Lyudmil Pelov - Senior Principal Product Manager - A-Team Cloud Solution Architects, Fredrick Bergstrand - Sales Engineer Analytics - Oracle Digital, Hans Viehmann - Group Manager - Spatial and Graph Product Management
* **Last Updated By/Date** - Jeroen Kloosterman, Oracle Digital, Jan 2021

