# HIGH AVAILABILITY - MYSQL REPLICATION: PREPARE REPLICA SERVER

## Introduction

7a) MySQL Replication: prepare replica server

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: -- minutes

### About <Product/Technology> (Optional)
Enter background information here about the technology/feature or product used in this lab - no need to repeat what you covered in the introduction. Keep this section fairly concise. If you find yourself needing more than to sections/paragraphs, please utilize the "Learn More" section.

### Objectives

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

### Prerequisites

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed
* Lab standard  
    - ![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell> the command must be executed in the Operating System shell
    - ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql> the command must be executed in a client like MySQL, MySQL Workbench
    - ![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh> the command must be executed in MySQL shell
    
**Server:** serverA (slave)

**NOTE:** 
- ServerA doesn't have binaries installed, so first part of the lab installs them. This is the same to first installation of mysql-advanced on serverB
- MySQL 8.0 replication requires SSL. To make it works like MySQL 5.7 and practice for the exam we force the usage of old native password authentication in my.cnf
- Some commands must run inside the source, other on slave: please read carefully the instructions


## Task 1: Prepare Replica

1.	Connect to serverA and execute the script to create a new user/group, folders structure and install binaries (be careful with copy&paste)

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>/workshop/support/lab7a-MySQL_Replication___Prepare_replica_server.sh</copy>
    ```
2.	Close the SSH connection and open a new one to let opc user have the new group.


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - Perside Foster, October 2021
