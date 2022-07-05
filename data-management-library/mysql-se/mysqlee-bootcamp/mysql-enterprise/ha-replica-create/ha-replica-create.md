# HIGH AVAILABILITY - MYSQL REPLICATION: CREATE REPLICA

## Introduction

7b) MySQL Replication: create replica

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: -- minutes

### About <Product/Technology>
Enter background information here about the technology/feature or product used in this lab - no need to repeat what you covered in the introduction. Keep this section fairly concise. If you find yourself needing more than to sections/paragraphs, please utilize the "Learn More" section.

### Objectives

In this lab, you will:
- Create Replica
- Use Replica

### Prerequisites

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed
* Lab standard  
    - ![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell> the command must be executed in the Operating System shell
    - ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql> the command must be executed in a client like MySQL, MySQL Workbench
    - ![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh> the command must be executed in MySQL shell
    
**Server:** serverB (source) and serverA (slave)

**NOTE:** 
- MySQL 8.0 replication requires SSL. To make it works like MySQL 5.7 and practice for the exam we force the usage of old native password authentication in my.cnf
- Some commands must run inside the source, other on slave: please read carefully the instructions

## Task 1: Create Replica

1.	Please remember that servers communicate use the PRIVATE IPs

Source Private IP Address (MAIN)  student###-serverB :	 

Replica Private IP Address (REPLICA) student###-serverA :	

2.	ServerB (source): Make the replica a copy of the source in a shared folder to easily restore on the replica:

    a. Inside /workshop/backups there is a folder for each student server. Search yours

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell-source>**  

    ```
    <copy>ls -l /workshop/backups</copy>
    ```
    b. take a full backup of the source using MySQL Enterprise Backup in your folder:

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell-source>** 

    ```
    <copy>sudo /mysql/mysql-latest/bin/mysqlbackup --port=3307 --host=127.0.0.1 --protocol=tcp --user=admin --password --backup-dir=/workshop/backups/$(hostname) backup-and-apply-log</copy>
    ```   

3.	ServerA (replica): We now create the my.cnf, restore the backup create and configure the replica

    a. It’s mandatory that each server in a replication topology have a unique server id. There is a copy of the my.cnf ready to be used. It’s a duplicate of the one used for mysql-advanced instance, with a different server&#95; id

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell-replica>**

    ```
    <copy>sudo cp /workshop/support/my.cnf.replica /mysql/etc/my.cnf </copy>
    ```
    ```
    <copy>exit</copy>
    ```
    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell-replica>** 
    ```
    <copy>sudo chown mysqluser:mysqlgrp /mysql/etc/my.cnf</copy>
    ```
    b. restore the backup from share folder (please change the red part with your folder name)

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell-replica>** 
    ```
    <copy>sudo /mysql/mysql-latest/bin/mysqlbackup --defaults-file=/mysql/etc/my.cnf --backup-dir=/workshop/backups/student###-serverb --datadir=/mysql/data --log-bin=/mysql/binlog/binlog copy-back</copy>
    ```
    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell-replica>** 
    ```
    <copy>sudo chown -R mysqluser:mysqlgrp /mysql</copy>
    ```
    c. start the new replica instance it and verify that it works.

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell-replica>** 
    ```
    <copy>sudo systemctl start mysqld-advanced</copy>
    ```
    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell-replica>** 
    ```
    <copy>mysql -uroot -p -h127.0.0.1 -P3307</copy>
    ```
    **mysql-replica>** 
    ```
    <copy>SHOW DATABASES;</copy>
    ```
4.	ServerB (source): For the matter of the exam we create here a user using MySQL 5.7

    a. **shell-source>** mysql -uroot -p -h127.0.0.1 -P3307
    ```
    <copy>exit</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-source>** 
    ```
    <copy>CREATE USER 'repl'@'%' IDENTIFIED WITH mysql_native_password BY 'Welcome1!';</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-source>** 
    ```
    <copy>GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';</copy>
    ```
## Task 2: Use Replica

1.	ServerA (replica): Time to connect and start the replica 

    a.	Configure the replica connection. PLEASE INSERT YOUR CORRECT SOURCE IP!
    
    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-replica>** 
    ```
    <copy>change master to master_host='<private_IP_of_student###-serverB>', master_port=3307, master_user='repl', master_password='Welcome1!', master_auto_position=1;</copy>
    ```
    b.	start the replica threads

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-replica>** 
    ```
    <copy>exit</copy>
    ```
    c.	Verify replica status, e.g. that IO&#95; Thread and SQL&#95; Thread are started searching the value with the following command (in case of problems check error log)

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-replica>** 
    ```
    <copy>SHOW SLAVE STATUS\G</copy>
    ```
2.	ServerB (source): Let’s verify the replicated data. Connect to source and make some changes

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-source>** 
    ```
    <copy>CREATE DATABASE newdb;</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-source>** 
    ```
    <copy>USE newdb;</copy>
    ```
    c.**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-source>**    
    ```
    <copy>CREATE TABLE t1 (c1 int primary key);</copy>
    ```
    d. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-source>** 
    ```
    <copy>INSERT INTO t1 VALUES(1);</copy>
    ```
    e. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-source>** 
    ```
    <copy>INSERT INTO t1 VALUES(2);</copy>
    ```
    f. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-source>** 
    ```
    <copy>DROP DATABASE employees;</copy>
    ```
3.	ServerA (replica): Verify that the new database and table is on the replica, to do so connect to replica and submit
    
    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-replica>** 
    ```
    <copy>SHOW DATABASES;</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql-replica>** 
    ```
    <copy>SELECT * FROM newdb.t1;</copy>
    ```
 



## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
