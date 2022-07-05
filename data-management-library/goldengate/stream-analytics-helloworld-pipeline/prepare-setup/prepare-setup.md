# Prepare Setup

## Introduction
This lab provides steps to download the Oracle Resource Manager (ORM) stack zip file that is needed to setup the resource for this workshop. This workshop requires a compute instance and a Virtual Cloud Network (VCN).

*Estimated Lab Time*: 15 minutes

### Objectives
-   Download ORM stack
-   Configure an existing Virtual Cloud Network (VCN)

### Prerequisites
This lab assumes you have:
- An Oracle Free Tier or Paid Cloud account

## Task 1: Download Oracle Resource Manager (ORM) stack zip file
1.  Click the link below, to download the Resource Manager zip file, needed to build your environment:

    - [ggsa-uag-mkplc-freetier.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/ZuOLyGBxqG7SIXz7MWbFTl2SQaal3-QKChVeRU7vZrw7oWr8s4KsHKoxlr3Bv5_q/n/natdsecurity/b/stack/o/ggsa-uag-mkplc-freetier.zip)

2.  Save in your downloads folder.

This workshop requires a certain number of ports to be available:
- To create a dedicated VCN, use the default ORM stack execution. It is recommended to use this stack to create a dedicated VCN with your instance(s). See *Task 3*
- To use an existing VCN, See *Task 2*.

## Task 2: Add Security Rules to an Existing VCN   
 To use an existing VCN, add the following ports to Ingress rules

| Port           |Description                            |Protocol
| :------------- | :------------------------------------ | :-----------
| 22             | SSH                                   | TCP
| 443            | GGSA Console (https)                  | TCP
| 6080           | noVNC Remote Desktop                  | TCP

1.  Go to Networking >> Virtual Cloud Networks
2.  Choose your network
3.  Under Resources, select Security Lists
4.  Click Default Security Lists under Create Security List
5.  Click Add Ingress Rules
6.  Enter the following:  
    - Source CIDR: 0.0.0.0/0
    - Destination Port Range: *Refer to above table*
7.  Click Add Ingress Rules

## Task 3: Setup Compute   
Using the details from the two steps above, proceed to the lab *Environment Setup* to setup your workshop environment using Oracle Resource Manager (ORM) and one of the following options:
  -  Create Stack:  *Compute + Networking*
  -  Create Stack:  *Compute only* with an existing VCN where security lists have been updated as per *Task 2* above


You may now [proceed to the next lab](#next).

## Acknowledgements

* **Author** - Pratibha Manjunath, Rene Fontcha
* **Contributors** - Sumathi Nelapati, Principal Member Technical Staff
* **Last Updated By/Date** - Pratibha Manjunath , December 2021
