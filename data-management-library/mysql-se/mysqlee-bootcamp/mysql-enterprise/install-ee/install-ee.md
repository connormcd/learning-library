# INSTALL - MYSQL ENTERPRISE EDITION

## Introduction

2b) Detailed Installation of MySQL on Linux
Objective: Tarball Installation of MySQL 8 Enterprise on Linux


Tarball Installation of MySQL 8 Enterprise on Linux

Estimated Time: -- minutes

### Objectives

In this lab, you will:
* Install MySQL Enterprise Edition
* Start and test MySQL Enterpriese Edition Install


### Prerequisites

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed

    **Use ServerB for this lab** 
    - we call this instance mysql-advanced
    - This is the most used instance in the labs
    - In the last labs we use it as source for replication and primary node for InnoDB Cluster HA

* Lab standard  
    - ![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell> the command must be executed in the Operating System shell
    - ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql> the command must be executed in a client like MySQL, MySQL Workbench
    - ![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh> the command must be executed in MySQL shell
    
## Task 1: Install MySQL Enterprise Edition

1.	Usually to run mysql  the user “mysql” is used, but because it is already available we show here how create a new one.
2. Create a new user/group for your MySQL service (mysqluser/mysqlgrp) and a add ‘mysqlgrp’ group to opc to help labs execution. 

3.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo groupadd mysqlgrp</copy>
    ```
  
4.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo useradd -r -g mysqlgrp -s /bin/false mysqluser</copy>
    ```
  
5.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>sudo usermod -a -G mysqlgrp opc</copy>
    ```
6. Close and reopen shell session or use “newgrp” command as below

7.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>newgrp - mysqlgrp</copy>
    ```


8.	Create new directory structure:

9.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo mkdir /mysql/ /mysql/etc /mysql/data</copy>
    ```

10. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo mkdir /mysql/log /mysql/temp /mysql/binlog</copy>
    ```

11.	Extract the tarball in your /mysql folder

12. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>cd /mysql/</copy>
    ```

13. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>sudo tar xvf /workshop/linux/mysql-commercial-8.0.25-el7-x86&#95;64.tar.gz</copy>
    ```

14.	Create a symbolic link to mysql binary installation

15. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo ln -s mysql-commercial-8.0.25-el7-x86&#95;64 mysql-latest</copy>
    ```

16.	Create a new configuration file my.cnf inside /mysql/etc
To help you we created one with some variables, please copy it

17. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo cp /workshop/support/my.cnf.first /mysql/etc/my.cnf</copy>
    ```

18.	For security reasons change ownership and permissions

19. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo chown -R mysqluser:mysqlgrp /mysql</copy>
    ```

20. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo chmod -R 750 /mysql</copy>
    ```

21. The following permission is for the Lab purpose so that opc account can make changes and copy files to overwrite the content

22. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo chmod -R 770 /mysql/etc</copy>
    ```

23.	initialize your database

24. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**

    ```
    <copy>sudo /mysql/mysql-latest/bin/mysqld --defaults-file=/mysql/etc/my.cnf --initialize --user=mysqluser</copy>
    ```
## Task 2: Start and test MySQL Enterpriese Edition Install

1.	Start your new mysql instance

2.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo /mysql/mysql-latest/bin/mysqld --defaults-file=/mysql/etc/my.cnf --user=mysqluser &</copy>
    ```

3.	Verify that process is running

4.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>eps -ef | grep mysqld</copy>
    ```

5.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>netstat -an | grep 3307</copy>
    ```


6.	Another way is searching the message “ready for connections” in error log as one of the last

7.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>grep -i ready /mysql/log/err&#95;log.log</copy>
    ```

8.	Retrieve root password for first login

9.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>grep -i 'temporary password' /mysql/log/err&#95;log.log</copy>
    ```

10.	Before version 5.7 it was recommended to run the mysql&#95;secure&#95;installation script. From version 5.7 all these settings are by default, but the script can be used also to setup the validate&#95;password plugin (used later). Now execute mysql&#95;secure&#95;installation

11. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>/mysql/mysql-latest/bin/mysql&#95;secure&#95;installation -P3307 -h127.0.0.1 </copy>
    ```

    **use the following  values**
    - root password: retrieved from previous step
    - new password: Welcome1!
    - setup VALIDATE PASSWORD component: Y
    - password validation policy: 2
    - Change the password for root: N
    - Remove anonymous users: Y
    - Disallow root login remotely: N
    - Remove test database: Y
    - Reload privilege tables now: Y

12.	Login to you mysql-advanced installation and check the status (you will be asked to change password). You can use the community mysql or the one provided with enterprise package

13. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>mysql -uroot -p -h 127.0.0.1 -P 3307</copy>
    ```

14. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>status</copy>
    ```

15.	Shutdown the service

16. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>exit</copy>
    ```

17. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>/mysql/mysql-latest/bin/mysqladmin -uroot -h127.0.0.1 -p -P3307 shutdown</copy>
    ```

18.	Configure automatic startup and shutdown with system.
    - Add a systemd service unit configuration file with details about the MySQL service. 
    - The file is named mysqld.service and is placed in /usr/lib/systemd/system. We created one for you (See addendum for the content)

19. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>sudo cp /workshop/support/mysqld-advanced.service /usr/lib/systemd/system/</copy>
    ```
20. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo chmod 644 /usr/lib/systemd/system/mysqld-advanced.service</copy>
    ```

21. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo systemctl enable mysqld-advanced.service</copy>
    ```
22.	Test start, stop and restart

23. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo systemctl start mysqld-advanced</copy>
    ```

24. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo systemctl status mysqld-advanced</copy>
    ```

25. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo systemctl stop mysqld-advanced</copy>
    ```

26. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>sudo systemctl status mysqld-advanced</copy>
    ```
27. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>sudo systemctl restart mysqld-advanced</copy>
    ```

28. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>sudo systemctl status mysqld-advanced</copy>
    ```

29.	Create a new administrative user called 'admin' with remote access and full privileges

30. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>mysql -uroot -p -h 127.0.0.1 -P 3307</copy>
    ```

31. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>CREATE USER 'admin'@'%' IDENTIFIED BY 'Welcome1!';</copy>
    ```

32. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;</copy>
    ```

33.	In the configuration file was specified to load the commercial Thread Pool Plugin, check if it’s loaded and active:

34. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>select * from information&#95;schema.plugins where plugin&#95;name like 'thread%';</copy>
    ```

35. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
 
    ```
    <copy>select * from information&#95;schema.plugins where plugin&#95;name like 'thread%'\G</copy>
    ```
36.	Add the mysql bin folder to the bash profile

37. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>exit</copy>
    ```

38. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>nano /home/opc/.bash&#95;profile</copy>
    ```

39. At to the PATH variable “/mysql/mysql-latest/bin:” 

    after $PATH You’ll have something like

    PATH=$PATH:/mysql/mysql-latest/bin:$HOME/.local/bin:$HOME/bin

40. Save the changes, log out and log in again from the ssh for the changes to take effect on the user profile. 


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
