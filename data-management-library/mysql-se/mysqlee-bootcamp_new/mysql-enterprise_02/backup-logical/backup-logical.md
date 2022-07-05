# MYSQL BACKUP - LOGICAL BACKUP (MYSQLDUMP)

## Introduction

6a) MySQL logical backup (mysqldump)
Objective: explore how mysqldump works
Server: serverB

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: -- minutes

### Objectives

In this lab, you will:
* Create Dump
* Delete current employees database
* Restore Dump

### Prerequisites 

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed
* Lab standard  
    - ![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell> the command must be executed in the Operating System shell
    - ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql> the command must be executed in a client like MySQL, MySQL Workbench
    - ![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh> the command must be executed in MySQL shell
    
**Server:** serverB

**Notes:**
- We work now with mysql-advanced instance.
- Reference:
- https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html


## Task 1: Create Dump

1.	Create the export folder

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo mkdir -p /mysql/exports</copy>
    ```
    b. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo chown mysqluser:mysqlgrp /mysql/exports/</copy>
    ```
    c. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo chmod 770 /mysql/exports/</copy>
    ```
2.	Export all the data with mysqldump

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>mysqldump -uroot -p -h127.0.0.1 -P3307 --single-transaction --events --routines --flush-logs --all-databases > /mysql/exports/full.sql</copy>
    ```
3.	Review the content of the file /mysql/exports/full.sql

4.	Export employees database

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>mysqldump -uroot -p -h127.0.0.1 -P3307 --single-transaction --set-gtid-purged=OFF employees > /mysql/exports/employees.sql</copy>
    ```
## Task 2: 	Delete current employees database
1.	Drop employees database

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>mysql -uroot -p -h127.0.0.1 -P3307</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>DROP DATABASE employees;</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>show databases;</copy>
    ```
## Task 3: 	Restore Dump
1.	Import the employees database

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**  
    ```
    <copy>CREATE DATABASE employees;</copy>
    ```
    b.**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
    ```
    <copy>exit</copy>
    ```
    c. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>mysql -uroot -p -h127.0.0.1 -P3307 employees < /mysql/exports/employees.sql</copy>
    ```
2.	Confirm database employees exist

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>mysql -uroot -p -h127.0.0.1 -P3307</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>show tables in employees;</copy>
    ```
## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
