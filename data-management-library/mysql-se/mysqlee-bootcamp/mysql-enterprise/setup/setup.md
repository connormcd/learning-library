# SETUP

## Introduction

1) Client Setup
Objective: Connect Notebook to the Oracle Network and the Oracle Cloud Infrastructure (OCI)

In this lab you will Download lab materials, plus connect Notebook to the Oracle Network and the Oracle Cloud Infrastructure (OCI)

Estimated Lab Time: -- minutes

### Objectives
In this lab, you will:
* Download lab materials
* Setup SSH client
* Record Server inforamtiom

### Prerequisites

*In compliance with Oracle security policies, I acknowledge I will not load actual confidential customer data or Personally Identifiable Information (PII) into my demo environment*

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed

## Task 1: Download Lab Material and SSH client
1. lectures pdf
2. lab guide
3. SSH keys to connect labs (it’s the same key in two different formats)
    * id_rsa in native openssl format. Use it with Workbench
    * id_rsa.ppk in putty format for windows. Use it only with putty
4. If you have not yet installed an SSH client on your laptop, please install one
    e.g. (windows) https://www.putty.org/

## Task 2: Record Lab Server info on Notepad

**student###-serverA:**
  - Hostname:  
  - Hostname FQDN:  
  - Public IP:   (e.g. 130.61.56.195) 
  - Private IP: (e.g. 10.0.11.18)

**student###-serverB:**
  - Hostname:
  - Hostname FQDN:
  - Public IP:  (e.g. 130.61.56.196) 
  - Private IP: (e.g. 10.0.11.19)

## Task 3: Review Misc Lab Information
1. Document standard 
    - When in the manual you read **shell>** the command must be executed in the Operating System shell.
    - When in the manual you read **mysql>** the command must be executed in a client like MySQL, MySQL Shell, MySQL Workbench, etc. We recommend students to use MySQL Shell to practice with it.
    - When in the manual you read MySQL **mysql>** the command must be executed in MySQL shell.

2. Lab standard  
    - ![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell> the command must be executed in the Operating System shell
    - ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql> the command must be executed in a client like MySQL, MySQL Workbench
    - ![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh> the command must be executed in MySQL shell

3.	The software used for the labs is located on a local /workshop folder within each server.

4.	Tip: set the keep alive for SSH connection to 60 seconds, to keep session open during lectures

5.	Linux opc user has limited privileges. To work with administrative privileges, use "sudo" like 
![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell> sudo su - root

## Task 4: Setup Lab Server and Connection

1.	Server description
    **ServerA** is installed with graphical server and it will be used to
    - install MySQL Workbench, a graphical tool that we use to manage serverB instances
    - (last lab) install a MySQL Enterprise 8.0 used as third node of InnoDB Cluster
    **ServerB** it will be used for to install
    - a MySQL Community 8.0
    - a MySQL Enterprise 8.0, used in most of the labs
    - (last labs) install a MySQL Enterprise 8.0 used in replication and InnoDB Cluster lab

2.	Sever Connections example
![Image alt text](images/setup-connections.png)

3.	Test the connection to your Linux machines from your laptop using these parameters
    - a. SSH connection
    - b. SSH key file named “id_rsa” or " 
    - c. username “opc”
    - d. no password
    - e. Public IP address of your assigned Linux VM (serverA, serverB)


4. Examples of connections: 

  *Linux:* use “id_rsa” key file

  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>ssh -i id_rsa opc@public_ip </copy>
    ```
  *Windows:* use “id_rsa.ppk” key file

    1. Open putty
    2. Insert the public IP of your server and a mnemonic session name
    ![Image alt text](images/putty-1.png)

    3. Choose "Connection  SSH  Auth" and provide the id_rsa.ppk path
    ![Image alt text](images/putty-2.png)

    4. Select "Connection  Data" and insert "opc" in "Auto-login username"
    ![Image alt text](images/putty-3.png)

    5. e)	Choose Connection and insert "60" in "Seconds between keepalives
    ![Image alt text](images/putty-4.png)

    6. Return to "Session" and click save
    ![Image alt text](images/putty-5.png)

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
