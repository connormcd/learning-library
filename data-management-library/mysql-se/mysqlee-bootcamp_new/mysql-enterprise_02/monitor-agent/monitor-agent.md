# MYSQL ENTERPRISE MONITOR - AGENT

## Introduction

5b) MySQL Enterprise Monitor - Install Agent
Objective: Install MySQL Enterprise Monitor Agent

Server: 
•	serverA for Enterprise Monitor
•	ServerB for Enterprise Agent

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: -- minutes

### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
* Concise Step Description
* Question Summary
* Use Agent
* OPTIONAL: add workload

### Prerequisites 

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
The Public IP Address is used on your Local Browser https://<public ip>:18443

- serverA Private IP address : 

Used during Agent configuration

- serverB Private IP address :  

This is used when you Add Instance as Remote Monitoring using agentless option

**References**
- https://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-install-tuning.html
- https://dbtut.com/index.php/2018/10/25/installation-of-mysql-enterprise-monitor/

![Image alt text](images/monitor-agent-1.png)


## Task 1: Concise Step Description

1.	On  serverB : Install the MEM agent and connect to your MEM server on MEMBER1


    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>cd /workshop/linux/agent</copy>
    ```
    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>sudo ./mysqlmonitoragent-8.0.25.1328-linux-x86-64bit-installer.bin </copy>
    ```
## Task 2: Question Summary 

Here is  a summary of the questions (from command installation in linux). Note Linux requires a manual first start

Language Selection

Please select the installation language
[1] English - English
[2] Japanese - 日本語
[3] Simplified Chinese - 简体中文
Please choose an option [1] : 1

Welcome to the MySQL Enterprise Monitor Agent Setup Wizard.

Installation directory


Please specify the directory where MySQL Enterprise Monitor Agent will be
installed


Installation directory [/opt/mysql/enterprise/agent]:


How will the agent connect to the database it is monitoring?


[1] TCP/IP
[2] Socket
Please choose an option [1] :

Monitoring Options

You can configure the Agent to monitor this host (file systems, CPU, RAM, etc.)
and then use the Monitor UI to furnish connection parameters for all current and
future running MySQL Instances. This can be automated or done manually for each
MySQL Instance discovered by the Agent. (Note: scanning for running MySQL
processes is not available on Windows, but you can manually add new connections
and parameters from the Monitor UI as well.)

Visit the following URL for more information:
http://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-qanal-using-feeding.html

Monitoring options:

[1] Host only: Configure the Agent to monitor this host and then use the Monitor UI to furnish connection parameters for current and future running MySQL Instances.
[2] Host and database: Configure the Agent to monitor this host and furnish connection parameters for a specific MySQL Instance now. This process may be scripted. Once installed, this Agent will also continuously look for new MySQL Instances to monitor as described above.
Please choose an option [2] : 1

Setup is now ready to begin installing MySQL Enterprise Monitor Agent on your
computer.

Do you want to continue? [Y/n]: Y


Please wait while Setup installs MySQL Enterprise Monitor Agent on your
computer.

 Installing
 0% ______________ 50% ______________ 100%
 #########################################


MySQL Enterprise Monitor Options

Hostname or IP address []: [private IP address student###-serverA]

Tomcat SSL Port [18443]:

The following are the username and password that the Agent will use to connect
to the Monitor. They were defined when you installed the Monitor. They can be
modified under Settings, Manage Users. Their role is defined as "agent".

Agent Username [agent]:

Agent Password : Welcome1!
Re-enter : Welcome1!

Monitored Database Configuration Options



Validate hostname, port, and Admin account privileges [Y/n]: n




Configure encryption settings for user accounts [y/N]: n




Configure less privileged user accounts [y/N]: n


Monitored Database Information

IMPORTANT: The Admin user account specified below requires special MySQL 
privileges.

Visit the following URL for more information:
http://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-agent-rights.html

MySQL hostname or IP address [localhost]:   

MySQL Port [3306]: 3307

Admin User []: admin

Admin Password : Welcome1!
Re-enter Password : Welcome1!
Monitor Group []: 

Configuration Report



MySQL Enterprise Monitor Agent (Version 8.0.16.1187)

The settings you specified are listed below.

Note that if you are using a Connector to collect Query Analyzer data,
you will need some of these settings to configure the Connector. See
the following for more information:
http://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-qanal-using-feeding.html

Installation directory: /opt/mysql/enterprise/agent

MySQL Enterprise Monitor UI:

Hostname or IP address: <the ip>
Tomcat Server Port: 18443
Use SSL: yes


Press [Enter] to continue:

Start MySQL Enterprise Monitor Agent

Info to start the MySQL Enterprise Monitor Agent

The MySQL Enterprise Monitor Agent was successfully installed. To start the
Agent please invoke:

/etc/init.d/mysql-monitor-agent start

Press [Enter] to continue:


Setup has finished installing MySQL Enterprise Monitor Agent on your computer.

View Agent Readme File [Y/n]: n

## Task 3: Use Agent

1.	Start the agent

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>sudo /etc/init.d/mysql-monitor-agent start</copy>
    ```
2.	Open your MySQL Monitor mysql-advanced connection (left menu Configuration\MySQL Instances) and change the “Monitor from” choosing your agent instead of the MEM Built-in Agent

3. Do you see statistics on NIS, disk etc.?



## Task 4: OPTIONAL: add workload
1.	Try to add some load on your server to watch graphics change

    a.	run the test tool “mysqlslap” (available in all MySQL Server installations):

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy> mysqlslap --user=admin --password --host=127.0.0.1 --port=3307 --concurrency=20 --iterations=5000 --number-int-cols=5 --number-char-cols=20 --auto-generate-sql --verbose</copy>
    ```
    b.	Check behavior in MEM, can you see the peaks?



## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
