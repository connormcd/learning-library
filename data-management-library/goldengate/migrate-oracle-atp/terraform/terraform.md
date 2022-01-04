# Prepare the work environment

## Introduction

In this lab, we will show you how to prepare your work environment in Oracle Cloud Infrastructure. We will use cloud-shell which is a web-based terminal built into OCI console. To use the Cloud Shell machine, your tenancy administrator must grant your the required IAM (Identity and Access Management) policy.

This first lab is very important and where we will create all of our resources:

- Virtual Cloud Network
- Source Oracle database
- Target Autonomous database
- GoldenGate database registrations
- GoldenGate deployment

*Estimated time*: 15 minutes

### Objectives

-   Create SSH keys in a cloud-shell environment
-   Configure API keys for your cloud user
-	Modify bash profile to interact with terraform
-   Prepare our work environment and create our lab resources using a Terraform script.

If you are running this lab in your existing tenancy, **make sure** you have the following compute quotas and resources available to use:

1. ATP for Target database - 1 OCPU, 1 TB storage
2. Virtual Machine for Source Database - VM.StandardE2.1

For a technical overview of this lab step, please watch the following video:

### Prerequisites

* The following workshop requires an Oracle Public Cloud Account that will either be supplied by your instructor or can be obtained through **Getting Started** steps.
* A Cloud tenancy where you have the resources available to provision what is listed in the Architecture Overview.
* Oracle Cloud Infrastructure supports the following browsers and versions: Google Chrome 69 or later, Safari 12.1 or later, Firefox 62 or later.
* Your cloud account user must have the required IAM (Identity and Access Management) policy or admin user.
* Successfully logged in to your cloud tenancy, if not please [login](https://www.oracle.com/cloud/sign-in.html) to your cloud account.

## **Task 1**: Open Cloud-Shell

1. Let's prepare our work directory. We will use Cloud Shell, it is located at the top right corner of the OCI web console

	![](/images/0.prep-0.png)

## **Task 2**: Clone Lab Repository

1. Let's begin our lab. First, we'll make a copy of the lab repository and go to the cloned directory. In your cloud-shell web terminal, issue the below commands.

	```
	<copy>
	git clone https://github.com/hol-workshop/oci_gg_cloud_service.git

	cd oci_gg_cloud_service/

	</copy>
	```

	![](/images/1.git-0.png)

## **Task 3**: Generate SSH keys

1. Once the cloud shell environment is ready, issue the below 4 lines of commands. This will create the ssh key files and the api signing keys:

	```
	<copy>
	chmod +x generate_pemkeys.sh

	./generate_pemkeys.sh
	</copy>
	```

2. Copy the output of public _**pem**_ file content, make sure you select the correct output as it shown in the below image:

	![](/images/0.prep-1.png)

## **Task 4**: Add Public API keys

1. Click on the top right corner of your OCI web console and then click on your **profile name**.

	![](/images/0.prep-1-1.png)

2. Then navigate to the **API Keys** from the left pane and click on the **Add API Key** button. A small pop-up will appear and you need to choose the "Paste Public Key" radio button. Paste your **copied** public pem key there and click on the **Add** button.

	![](/images/0.prep-2.png)

2. A small confirmation will show after you added an API key. You need to copy **tenancy** and **region** values. Now in the cloud-shell, type the below command and modify **terraform.tfvars** file accordingly.

	```
	<copy>
	vi terraform.tfvars
	</copy>
	```

	> **Note:** This will open a new file, you have to press **i** key to enable editing, then "shift+insert" keys to paste copied parameter. When you are done editing press **esc** key and press **:wq** keys, then hit enter for save & quit.

	![](/images/0.prep-3.png)

## **Task 5**: Terraforming

1. It is now time to initialize terraform. Run the below command to download necessary terraform files from the OCI provider.

	```
	<copy>
	terraform init
	</copy>
	```

2. Plan and apply steps should not ask for any input from you. If it asks you to provide, for example; _**`compartment_ocid`**_ , then check previous **step 4**.

	```
	<copy>
	terraform plan

	terraform apply --auto-approve
	</copy>
	```

	After you ran the apply command, terraform will start installation of several virtual machines and an autonomous database. Be patient, it will approximately take 6 to 10 minutes, as it is now creating OCI GoldenGate, source and target databases, also registrations of them in GoldenGate deployment. During terraform script, if you see an error **Service limits exceeded** in output, please visit the Appendix section for instructions to correct the issue.

3. Make a copy of your output results in your notepad for later use.

	![](/images/1.git-1.png)

## **Appendix**: Troubleshooting

###	Issue #1 Service Limits Exceeded

If you see **Service Limits Exceeded** issues when running _**terraform apply**_ command, follow the steps below to resolve them.
When creating a stack, you must have the available quotas for your tenancy and your compartment.

Depending on the quota limit you have in your tenancy you can choose from any VM Standard Compute shapes, AMD shapes or Flex Shapes.

This lab uses the following compute types but not limited to:

- Virtual Machine for Source Database - **VM.StandardE2.1**

#### Fix for Issue #1

1. Click on the Hamburger menu, go to **Governance** -> **Limits, Quotas and Usage**
2. Select Compute
3. Click Scope to change Availability Domain
4. Look for "Standard2 based VM" and "Standard.E2 based VM", then check **Available** column numbers and sum  them up. All you need to have is at least **3** or more. If you have found correct available capacity, please go to OCI cloud-shell.
5. Go  work directory `oci_gg_cloud_service` folder in your cloud-shell and modify variables file with: **`vi vars.tf`**

	![](/images/fix_1.png)

6. Fix the above "VM.Standard2.2" value accordingly to your **Available** resources.
7. Go to **Step 5: Terraform**, and continue from substep **2**.

However, if you are unable to resolve it using above fix, please skip to the **Need Help** section to submit your issue via our support forum.

## Acknowledgements

* **Author** - Bilegt Bat-Ochir - Senior Solution Engineer
* **Contributors** - Tsengel Ikhbayar - GenO Lift Implementation
* **Last Updated By/Date** - Bilegt Bat-Ochir 18/09/2021
