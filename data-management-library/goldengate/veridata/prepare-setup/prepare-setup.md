# Prepare Setup

## Introduction
This lab will show you how to download the Oracle Resource Manager (ORM) stack zip file needed to setup the resource needed to run this workshop. This workshop requires a compute instance running the Oracle GoldenGate Veridata Marketplace image and a Virtual Cloud Network (VCN).

*Estimated Time:* 15 minutes

### Objectives
-   Download ORM stack
-   Configure an existing Virtual Cloud Network (VCN)

### Prerequisites
This lab assumes you have:
- An Oracle Free Tier or Paid Cloud account
- SSH Keys (optional)

## Task 1: Download Oracle Resource Manager (ORM) stack zip file
1.  Click on the link below to download the Resource Manager zip file you need to build your environment:

<if type="default">
    - [ggvd-mkplc-freetier.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/Vo75y6-hxT4jgMS5yzQdZs28frxcpv8Fg9BjCg3kJSJEsMRCtzWml25zJGwXcsfK/n/natdsecurity/b/stack/o/ggvd-mkplc-freetier.zip)
</if>
<if type="advanced">
    - [ggvd-mkplc-advanced.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/JHclbM43HVmaX_i7ZAo3m5qQGet_fIKOLQlMyoQW-SRIhrx141BzEQ_Z5I9yOwxz/n/natdsecurity/b/stack/o/ggvd-mkplc-advanced.zip)
</if>

<if type="tools">
    - [ggvd-mkplc-tools.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/LrY-ZJ7TOd_A5j7k85TN73MRwC9En1FJtqm7rKVTKQCIv-zy6h8qqOLUMRe-zuVx/n/natdsecurity/b/stack/o/ggvd-mkplc-tools.zip)
</if>

2.  Save in your downloads folder.

We strongly recommend using this stack to create a self-contained/dedicated VCN with your instance(s). Skip to *Step 3* to follow our recommendations. If you would rather use an exiting VCN then proceed to the next step as indicated below to update your existing VCN with the required Egress rules.

## Task 2: Adding Security Rules to an Existing VCN   
This workshop requires a certain number of ports to be available, a requirement that can be met by using the default ORM stack execution that creates a dedicated VCN. In order to use an existing VCN the following ports should be added to Egress rules

| Port           |Description                            |
| :------------- | :------------------------------------ |
| 22             | SSH                                   |
| 80             | Application (http)                    |
| 7001           | GoldenGate Administration Server (WLS)|
| 8830           | GoldenGate Veridata Server            |
| 6080           | noVNC Remote Desktop                  |

1.  Go to *Networking >> Virtual Cloud Networks*
2.  Choose your network
3.  Under **Resources**, select **Security Lists**.
4.  Click Default Security Lists under **Create Security**.
5.  Click **Add Ingress Rules**.
6.  Enter the following:  
    - Source CIDR: 0.0.0.0/0
    - Destination Port Range: *Refer to above table*
7.  Click **Add Ingress Rules**.

## Task 3: Setup Compute   
Using the details from the two steps above, proceed to the lab *Environment Setup* to setup your workshop environment using Oracle Resource Manager (ORM) and one of the following options:
-  Create Stack:  *Compute + Networking*
-  Create Stack:  *Compute only* with an existing VCN where security lists have been updated as per *Step 2* above

## Acknowledgements
* **Author** - Rene Fontcha, LiveLabs Platform Lead, NA Technology
* **Contributors** -  Anuradha Chepuri, Nisharahmed Soneji, Sukin Varghese
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, May 2022
