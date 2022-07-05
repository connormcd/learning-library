# Set up Oracle Linux compute image

## Introduction
This lab will show you how to setup a Oracle Cloud network (VCN) and a compute instance running Oracle Linux using Oracle Resource Manager.

Estimated Time:  15 minutes

### About Terraform and Oracle Cloud Resource Manager
Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently.  Oracle offers sample solutions to help you quickly create common Oracle cloud components.

Resource Manager is an Oracle Cloud Infrastructure service that allows you to automate the process of provisioning your Oracle Cloud Infrastructure resources. Using Terraform, Resource Manager helps you install, configure, and manage resources through the "infrastructure-as-code" model. To learn more about OCI Resource Manager, preview the video below.

[OCI Resource Manager](youtube:udJdVCz5HYs)

### Objectives
In this lab, you will:
* Setup a VCN (Virtual Compute Network) using Resource Manager
* Setup a compute instance using Resource Manager
* Log in to your compute instance

### Prerequisites

This lab assumes you have:
- An Oracle Free Tier or Paid Cloud account
- Lab: Generate SSH Keys

## Task 1: Setup VCN Stack
If you already have a VCN created, skip this step and proceed to *STEP 3*.

1.  Login to your Oracle Cloud account

2.  Click the **Create a Stack** tile on the homepage.  Or, click the **Navigation Menu** in the upper left, navigate to **Developer Services**, select **Stacks** and click **Create Stack**.

	![Stacks](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/developer-resmgr-stacks.png " ")

3.  Choose **Template** and click on **Select Template**.

    ![Select Template](images/select-template.png " ")

4. In the Browse Templates window, select **Default VCN** and click the **Select Template** button.
   ![Default VCN](images/default-vcn.png " ")

5.  Enter the name for your VCN:  **livelabsvcn**. Choose your compartment and click **Next**.
   ![Name and compartment](images/name-compartment.png " ")

6. Inspect and then accept all default values in the Configure Variables screen and click **Next**.
   ![Accept all default values](images/configure-variables.png " ")

7.  Review your selections and click **Create**
   ![Create](images/create-vcn.png " ")

## Task 2: Run VCN Stack Apply Job
Now that your stack has been created, you will run an *apply* job to create the actual VCN

1. Click **Apply** on the Stack Details page
![Apply](images/apply-vcn.png " ")

2. Inspect the apply job, accept all defaults and click **Apply**
![Apply job](images/apply-job-vcn.png " ")

3. The VCN will immediately begin creation.
![VCN creating](images/vcn-creating.png " ")

4. Once the apply job is complete, inspect the results.
![Apply job complete](images/apply-job-complete.png " ")

5. Scroll down the log.  You will notice that 6 objects were created:  A VCN, subnet, internet gateway, default security list, route table and dhcp options, each with their own Oracle Cloud ID (ocid).  We will focus on the subnet.  You will need this subnet information to create your compute instance
![Log](images/log.png " ")

6. Copy the first subnet id to a notepad and save for the next step.  If you would like to further inspect the VCN, complete steps#7-12.  Otherwise skip to the next section.
![First subnet](images/first-subnet.png " ")

7.  Click the **Navigation Menu** in the upper left, navigate to **Networking**, and select **Virtual Cloud Networks**.
    ![VCN](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/networking-vcn.png " ")

8.  The VCN you created should be listed.  Click the VCN you just created.
![My VCN](images/my-vcn.png " ")

9.  On the VCN homepage notice the 3 subnets that were created.  Each subnet is tied to an Availability Domain.  Click on the subnet that matches AD-1.
![Three subnets](images/three-subnets.png " ")

10.  Inspect the subnet homepage, find the OCID (Oracle Cloud ID).  Click **Copy**
![Subnet OCID](images/subnet-ocid.png " ")

11. Copy the subnet ID to a notepad.
![Copy OCID](images/copy-ocid.png " ")

## Task 3: Set up Compute Stack
1.  Click the **Create a Stack** tile on the homepage.  Or, click the **Navigation Menu** in the upper left, navigate to **Developer Services**, select **Stacks** and click **Create Stack**.
	![Stacks](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/developer-resmgr-stacks.png " ")

2.  Choose **Template** and click on **Select Template**.
    ![Select Template](images/select-template.png " ")

3.  In the Browse Templates window, select **Compute Instance** and click the **Select Template** button.
    ![Compute Instance](images/ln-compute.png " ")

4.  Enter the name for your Compute Stack:  **livelabslinux**. Choose your compartment and click **Next**.
   ![Compute name](images/livelabslinux.png " ")

5. Fill in the following values for your new compute instance.
   	- Compute Instance Display Name: Choose a name for your instance
  	 - Choose the VCN you created in the previous step
  	 - Choose a subnet from the drop down

   ![Configuration](images/configuration.png " ")

6.  Scroll down, provide the following values for your compute instance and click **Next**.
  	 - Check the **Assign Public IP**
        >**Note:** This is VERY IMPORTANT, you will not be able to login to your instance without this

  	 - Paste the public key you created in the earlier lab
   ![Assign Public IP and paste SSH public key](images/public-ip-ssh-key.png " ")

7.   Review your selections and click **Create**
   ![Image alt text](images/create-compute.png " ")

## Task 4: Run Compute Stack Apply Job
Now that your stack has been created, you will run an *apply* job to create the actual compute instance

1. Click **Apply** on the Stack Details page.

2. Inspect the apply job, accept all defaults and click **Apply**

3. The compute instance will immediately begin creation.
![VCN creating](images/vcn-creating.png " ")

4. Once the apply job is complete, inspect the results.
![Inspect log](images/compute-log.png " ")

5. You will notice that 3 objects were created.  Your instance has a private IP address and a public IP address.  Copy the public IP address, you will need it to connect to your instance.

6. Click the **Navigation Menu** in the upper left, navigate to **Compute**, and select **Instances**.
	![Compute Instances](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/compute-instances.png " ")

7.  The compute instance you created should be listed. Note the public IP address.
![Compute public IP](images/compute-public-ip.png " ")

## Task 5: Connect to Your Instance

There are multiple ways to connect to your cloud instance.  Choose the way to connect to your cloud instance that matches the SSH Key you generated.  *(i.e If you created your SSH Keys in cloud shell, choose cloud shell)*

- Oracle Cloud Shell
- MAC or Windows CYCGWIN Emulator
- Windows Using Putty

### Oracle Cloud Shell

1.  Go to **Compute** -> **Instance** and select the instance you created (make sure you choose the correct compartment).
	![Instances](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/compute-instances.png " ")

2.  On the instance homepage, find the Public IP address for your instance.
    ![Public IP](./images/public-ip.png " ")

3. To re-start the Oracle Cloud shell, go to your Cloud console and click the cloud shell icon to the right of the region.
	![Cloud Shell](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/cloud-shell.png " ")

    >**Note:** Make sure you are in the region you were assigned.

    ![Cloud Shell](./images/cloudshell.png " ")

4.  Enter the command below to login to your instance.
    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````

    >**Note:** The angle brackets <> should not appear in your code.

    ![SSH to compute instance](./images/ssh-compute.png " ")

5.  When prompted, answer **yes** to continue connecting.

You may now **proceed to the next lab**.

### MAC or Windows CYGWIN Emulator
1.  Go to **Compute** -> **Instances** and select the instance you created (make sure you choose the correct compartment).
	![Instances](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/compute-instances.png " ")

2.  On the instance homepage, find the Public IP address for your instance.
    ![Public IP](./images/public-ip.png " ")

3.  Open up a terminal (MAC) or cygwin emulator as the opc user.  Enter yes when prompted.

    ````
    ssh -i ~/.ssh/<sshkeyname> opc@<Your Compute Instance Public IP Address>
    ````
    ![SSH into instance](./images/ssh-first-time.png " ")

    >**Note:** The angle brackets <> should not appear in your code.

You may now **proceed to the next lab**.

### Windows using PuTTY

1.  Open the PuTTY utility from the Windows start menu and create a new connection. In the dialog box, enter the IP address of your OCI Compute Instance. This can be obtained from the **OCI Console > Compute > Instances > Instance Details** screen.

2.  Enter a name for the session and click **Save**.

    ![Session name](./images/putty-setup.png " ")

3. Click **Connection** > **Data** in the left navigation pane and set the **Auto-login username** to **root**.

4. Click **Connection** > **SSH** > **Auth** in the left navigation pane and configure the SSH private key to use by clicking **Browse** under *Private key file for authentication*.

5. Navigate to the location where you saved your SSH private key file, select the file, and click Open.
    >**Note:**  You cannot connect while on VPN or in the Oracle office on clear-corporate (choose clear-internet).

    ![Open private SSH key](./images/putty-auth.png " ")

6. The file path for the SSH private key file now displays in the *Private key file for authentication* field.

7. Click **Session** in the left navigation pane, then click Save in the Load, save or delete a stored session STEP.

8. Click **Open** to begin your session with the instance.

Congratulations! You now have a fully functional Linux instance running on Oracle Cloud Compute.

You may now **proceed to the next lab**.

## Acknowledgements
- **Author** - LiveLabs Team, DB Product Management
- **Contributors** - Jaden McElvey, Anoosha Pilli, Sanjay Narvekar, David Start, Arabella Yao
- **Last Updated By/Date** - Arabella Yao, May 2022