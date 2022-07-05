# MYSQL BACKUP - ENTERPRISE BACKUP

## Introduction

6b) MySQL Enterprise Backup
Objective: explore how mysqlbackup works
Server: serverB

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: -- minutes

### Objectives

In this lab, you will:
* Install Enterprise Backup
* Use backup

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
- We work now with mysql-advanced instance. [ student###-serverB:3307 ]

**References:**
- https://dev.mysql.com/doc/mysql-enterprise-backup/8.0/en/mysqlbackup.tasks.html
- https://dev.mysql.com/doc/mysql-enterprise-backup/8.0/en/mysqlbackup.privileges.html

## Task 1: Install Enterprise Backup

1.	MySQL Enterprise Backup is now available inside MySQL Enterprise Distributions like a tool, so you don’t have to install it.

2.	Create directories to store backups

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo mkdir -p /backupdir/full</copy>
    ```
    b. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo mkdir /backupdir/compressed</copy>
    ```
    c. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo chown -R mysqluser:mysqlgrp /backupdir</copy>
    ```
    d. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo chmod 770 -R /backupdir</copy>
    ```
3.	Create a user in mysql-advanced with grants options for backup. To simplify user creations we have a script with minimal grants for this user (see the manual for additional privileges required for specific features like TTS, SBT integration, encrypted). You can also have a look on the privileges opening the file /workshop/support/mysqlbackup_user_grants.sql

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>mysql -uroot -p -h127.0.0.1 -P3307</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>CREATE USER 'mysqlbackup'@'%' IDENTIFIED BY 'Welcome1!';</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>source /workshop/support/mysqlbackup_user_grants.sql;</copy>
    ```
    d. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>exit</copy>
    ```
4.	Create a full backup (be careful with copy&paste!). 

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo /mysql/mysql-latest/bin/mysqlbackup --port=3307 --host=127.0.0.1 --protocol=tcp --user=mysqlbackup --password --backup-dir=/backupdir/full backup-and-apply-log</copy>
    ```
5.	Create a second backup with compression (be careful with copy&paste!)

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>sudo /mysql/mysql-latest/bin/mysqlbackup --port=3307 --host=127.0.0.1 --protocol=tcp --user=mysqlbackup --password --backup-dir=/backupdir/compressed --compress backup-and-apply-log</copy>
    ```
6.	Because these backups are created with sudo, change the permissions

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo chown -R mysqluser:mysqlgrp /backupdir/full</copy>
    ```
    b. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo chown -R mysqluser:mysqlgrp /backupdir/compressed</copy>
    ```
7.	Have a look of the content of the backup folders

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>cd /backupdir/full</copy>
    ```
    b. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>ls -l</copy>
    ```
    c. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>cd /backupdir/compressed/</copy>
    ```
    d. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>ls -l</copy>
    ```
8.	Check the size of the two backups, the one uncompressed and the one compressed

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>cd /backupdir</copy>
    ```
    b. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>du -sh *</copy>
    ```
## Task 2: Use backup
1.	Restore

    a.	Stop the server

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo systemctl stop mysqld-advanced	</copy>
    ```
    b.	(destroy time!) empty datadir and binary log dir

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo rm -rf /mysql/binlog/* /mysql/data/*</copy>
    ```
    c.	Restore the backup (be careful with copy&paste!)

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo /mysql/mysql-latest/bin/mysqlbackup --defaults-file=/mysql/etc/my.cnf --backup-dir=/backupdir/full/ --datadir=/mysql/data --log-bin=/mysql/binlog/binlog copy-back</copy>
    ```
    d.	Set ownership

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo chown -R mysqluser:mysqlgrp /mysql/data /mysql/binlog</copy>
    ```
    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo chmod -R 750 /mysql/data /mysql/binlog</copy>
    ```

    e.	Start the server

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo systemctl start mysqld-advanced</copy>
    ```
    a.	verify that content is still there

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>mysql -uroot -p -h127.0.0.1 -P3307</copy>
    ```
    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SHOW DATABASES;</copy>
    ```

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
