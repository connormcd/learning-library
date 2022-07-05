# MYSQL ENTERPRISE MONITOR - MANAGER

## Introduction

5a) MySQL Enterprise Monitor - Install Service Manager
Objective: Install MySQL Enterprise Monitor Service Manager

Server: 
•	serverA for Enterprise Monitor
•	ServerB for Enterprise Agent


*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: -- minutes

### Objectives

In this lab, you will:
* MySQL Enterprise Monitor Service Manager Install
* Installer questions summary
* MySQL Monitor Status

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is necessary to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed
* Lab standard  
    - ![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell> the command must be executed in the Operating System shell
    - ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql> the command must be executed in a client like MySQL, MySQL Workbench
    - ![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh> the command must be executed in MySQL shell
    
**Server:** 
- serverA for Enterprise Monitor
- ServerB for Enterprise Agent


**Note:**
- Note down the IP address here.  
- serverA Public IP address : 
- The Public IP Address is used on your Local Browser 
    
    https://<public ip>:18443)

- serverB Private IP address : 

This is used when you Add Instance as Remote Monitoring using agentless option

- References
- https://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-install-tuning.html
- https://dbtut.com/index.php/2018/10/25/installation-of-mysql-enterprise-monitor/

 ![Image alt text](images/monitor-managment-1.png)

## Task 1: MySQL Enterprise Monitor Service Manager Install

1.	On serverA: Install the MySQL Enterprise Monitor Service Manager on your Linux instance

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>cd /workshop/linux/monitor</copy>
    ```
    b. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>exit</copy>
    ```
    c. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** sudo ./mysqlmonitor-8.0.25.1328-linux-x86_64-installer.bin 

    ```
    <copy>exit</copy>
    ```

## Task 2: Installer questions summary 

(Except for the Password Entry [ using Welcome1! ], all other INPUTs are DEFAULT – Just hit <ENTER>)
Language Selection

Please select the installation language
[1] English - English
[2] Japanese - 日本語
[3] Simplified Chinese - 简体中文
Please choose an option [1] : 1
Info: During the installation process you will be asked to enter usernames and
passwords for various pieces of the Enterprise Monitor. Please be sure to make
note of these in a secure location so you can recover them in case they are
forgotten.

Press [Enter] to continue:

Welcome to the setup wizard for the MySQL Enterprise Monitor


Please specify the directory where the MySQL Enterprise Monitor will be
installed

Installation directory [/opt/mysql/enterprise/monitor]:

Select Requirements

Select Requirements

Please indicate the scope of monitoring this installation will initially encompass so we can configure memory usage accordingly. NOTE: This setting may have a big impact on overall performance. The manual contains instructions for updating the configuration later, if needed. This installation will monitor a:

System Size

[1] Small system: 1 to 5 MySQL Servers monitored from a laptop computer or low-end server with no more than 4 GB of RAM
[2] Medium system: Up to 100 MySQL Servers monitored from a medium-size but shared server with 4 GB to 8 GB of RAM
[3] Large system: More than 100 MySQL Servers monitored from a high-end server dedicated to MEM with more than 8 GB RAM
Please choose an option [2] : 1


Tomcat Server Options

Please specify the following parameters for the bundled Tomcat Server

Tomcat Server Port [18080]:

Tomcat SSL Port [18443]:


Service Manager User Account

You are installing as root, but it's not good practice for the Service Manager
to run under the root user account. Please specify the name of a user account
to use for the Service Manager below. Note that this user account will be
created for you if it doesn't already exist.

User Account [mysqlmem]:


Database Installation

Please select which database configuration you wish to use

[1] I wish to use the bundled MySQL database
[2] I wish to use an existing MySQL database *
Please choose an option [1] :

* We will validate the version of your existing MySQL database server during the
installation. See documentation for minimum version requirements.

* Important: If your existing MySQL database server already has another MySQL
Enterprise Monitor repository in it that you want to keep active, be sure to
specify a unique name in the "MySQL Database Name" field on the next screen.



Visit the following URL for more information:

http://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-install-server.html


Repository Configuration

Please specify the following parameters for the bundled MySQL server

Repository Username [service_manager]:

Password : Welcome1!
Re-enter : Welcome1!
MySQL Database Port [13306]:

MySQL Database Name [mem]:


Setup is now ready to install MySQL Enterprise Monitor on your computer.

Do you want to continue? [Y/n]: Y


Please wait while Setup installs MySQL Enterprise Monitor on your computer.

 Installing
 0% ______________ 50% ______________ 100%
 #########################################


Completed installing files



Setup has completed installing the MySQL Enterprise Monitor files on your
computer

Uninstalling the MySQL Enterprise Monitor files can be done by invoking:
/opt/mysql/enterprise/monitor/uninstall

To complete the installation, launch the MySQL Enterprise Monitor UI and
complete the initial setup. Refer to the readme file for additional information
and a list of known issues.


Press [Enter] to continue:


Completed installing files

WARNING: To improve security, all communication with the Service Manager uses
SSL. Because only a basic self-signed security certificate is included when the
Service Manager is installed, it is likely that your browser will display a
warning about an untrusted connection. Please either install your own
certificate or add a security exception for the Service Manager URL to your
browser. See the documentation for more information.

http://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-ssl-installation.html
Press [Enter] to continue:


Setup has finished installing MySQL Enterprise Monitor on your computer.

View Readme File [Y/n]: n

Info: To configure the MySQL Enterprise Monitor please visit the following page:
https://localhost:18443
Press [Enter] to continue:

## Task 3: MySQL Monitor Status

1.	On serverA: Check the status of the MySQL Monitor

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**

    ```
    <copy> sudo /opt/mysql/enterprise/monitor/mysqlmonitorctl.sh status</copy>
    ```
2.	On serverA: After the successful installation connect to the newly installed service with a web browser on the address from your laptop (please use thee public IP and be patient, startup may require few minutes depending on VM resources)
https://<public_ip_of_serverA>:18443

 ![Image alt text](images/monitor-managment-1.png)

3. Fill then Admin user and Agent user settings
Admin user : admin	-	Admin password: Welcome1!
Agent user : agent	-	Agent password: Welcome1!

4. Click ‘Complete Setup’ button

 
5. Choose your time zone and keep “English” for locale
![Image alt text](images/monitor-managment-3.png)

7. Now you are logged in, start exploring the interface

8. Connect your MEM to use mysql-advanced in agentless mode [ on student###-serverB:3307 ]
a.	On left side menu expand “Configuration” and select “Mysql Instances”. 
Click button “Add MySQL Instance” and fill

Monitor From: MEM Built-in Agent
Instance Address: student###-serverB (or private IP)
Port: 3307
Admin User: admin
Admin password: Welcome1!
Auto-Create Less Privileged Users: No

9. Do you see statistics on NIC, disk etc? You should not (!)

10. Check the monitoring status on the top right [Dolphin Logo]

11. How many server (Hosts) are you monitoring? How many MySQL Instances (Monitored, not Monitored etc.) are there? # Do not add this/these servers yet!
 

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
