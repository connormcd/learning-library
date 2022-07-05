# Migrate PostgreSQL to Oracle Autonomous Database Workshop

## Introduction

In this workshop, we will migrate a PostgreSQL database to an Autonomous Database in Oracle Cloud Infrastructure. Purpose of this workshop we will use Oracle GoldenGate for the migration and designated resources in Oracle Cloud Infrastructure. This workshop consists of 5 labs. 

*Estimated total Workshop Time*: 1.5 hours

### About GoldenGate for PostgreSQL

Oracle GoldenGate on Marketplace contains pre-configured Oracle GoldenGate for Non-Oracle for PostgreSQL. We will use it for our extract data processes from a source PostgreSQL database.

### About GoldenGate Microservices

Oracle GoldenGate Microservices Architecture allows this premier replication tool to scale out to the cloud and provide a secure, flexible and scalable replication platform. It has an easy interface to manage both extracts and replicate processes from on-premises to cloud, also cloud to cloud. We will use Microservices to apply our extracted data in the target Autonomous Database.

### About Terraform 

Terraform is an open-source tool that allows you to manage programmatically, version, and persist infrastructure through the "infrastructure-as-code" model.
The Oracle Cloud Infrastructure (OCI) Terraform provider is a component that connects Terraform to the OCI services that you want to manage. We will use it as our infrastructure orchestration to deploy all necessary resources.

### Objectives

In this workshop you will :
* Explore Cloud-Shell, web-based terminal
* Benefit from OCI terraform provider
* Explore OCI compute service
* Migrate PostgreSQL database to Autonomous Transaction Processing database
* Explore Autonomous Database and its capabilities

**Architecture Overview**

- Virtual Cloud Network: we will create a VCN with a public sub-network and internet access to avoid complexity.
- Source PostgreSQL database: we will create a PostgreSQL database in a Virtual Machine, which acts as our source on-premise database.
- Target Autonomous database: we will provision Oracle Autonomous Database to act as our target database.
- GoldenGate for non-Oracle deployment: we will create a GoldenGate classic for PostgreSQL to extract data from the source and ships trail files to the cloud.
- GoldenGate Microservices deployment: we will create a Microservices environment for an Autonomous Database that applies trails from source to target autonomous database.

	![Architecture diagram of Goldengate deployment.](/images/architecture.png)

All of the above resources are going to be deployed in Oracle Cloud Infrastructure using Terraform. It is not necessary to have prior knowledge of Terraform scripting. All you need to do is follow every step exactly as described.

### Prerequisites

* The following workshop requires an Oracle Public Cloud Account that will either be supplied by your instructor or can be obtained through **Getting Started** steps.
* A Cloud tenancy where you have the available quotas to provision what mentioned in Architecture Overview.
* Oracle Cloud Infrastructure supports the following browsers and versions: Google Chrome 69 or later, Safari 12.1 or later, Firefox 62 or later.

*Note: If you have a **Free Trial** account, when your Free Trial expires your account will be converted to an **Always Free** account. You will not be able to conduct Free Tier workshops unless the Always Free environment is available. **[Click here for the Free Tier FAQ page.](https://www.oracle.com/cloud/free/faq.html)***

**This concludes the introduction. You may now proceed to the next step.**

## Learn More

* [Terraform OCI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraform.htm)
* [Oracle GoldenGate](https://docs.oracle.com/en/middleware/GoldenGate/core/19.1/oggmp/using-oracle-GoldenGate-microservices-oracle-cloud-marketplace.html)
* [Oracle Autonomous Database](https://docs.oracle.com/solutions/?q=autonomous&cType=reference-architectures&sort=date-desc&lang=en)

## Acknowledgements

* **Author** - Bilegt Bat-Ochir - Senior Solution Engineer
* **Contributors** - John Craig - Technology Strategy Program Manager, Patrick Agreiter - Senior Cloud Engineer
* **Last Updated By/Date** - Bilegt Bat-Ochir 04/04/2022