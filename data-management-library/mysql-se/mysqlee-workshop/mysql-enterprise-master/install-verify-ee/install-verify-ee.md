# INSTALL - VERIFY MYSQL ENTERPRISE EDITION  

## Introduction

Goal:
    Verify the new MySQL Installation on Linux and import test databases

Objectives: 
- understand better how MySQL connection works
- install test databases for labs (world and employees)
- have a look on useful statements


Estimated Time: -- minutes

### Objectives

In this lab, you will:
* Discuss MySQL Connection 
* Connect to Port 3306
* Import Sample Databses
* Learn Useful SQL Statements

### Prerequisites

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed

* Lab standard  
    - ![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell> the command must be executed in the Operating System shell
    - ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql> the command must be executed in a client like MySQL, MySQL Workbench
    - ![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh> the command must be executed in MySQL shell
    
## Task 1: Discuss MySQL Connection 

Please note that now you have an instance on the server on port 3306. To connect to MySQL, always use the IP address, otherwise you may connect to wrong instance. Here we practice connecting to the right one (port 3310 is intentionally wrong). To help you understand “why” these check lines (not all are always available…)

- Current user:
- Connection:
- UNIX socket:
- TCP port:

## Task 2: 	Connect to Ports 3306 

1.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**

    ```
    <copy>mysql -u root -p --protocol=tcp</copy>
    ```
2.  **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>status</copy>
    ```
3.  **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**  

    ```
    <copy>exit</copy>
    ```
4.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>mysql -u root -p --protocol=tcp -P3306</copy>
    ```
5.  **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>status</copy>
    ```

6.  **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**

    ```
    <copy>exit</copy>
    ```
	
7.  **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**

    ```
    <copy>mysql -uroot -p -h localhost -P3310 --protocol=tcp </copy>
    ```


## Task 3: Remove MySQL Community Installation and Import Databses
1. Now that you understand how to connect, we can remove the MySQL Community installation

  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>sudo yum remove mysql-server</copy>

    ```
2.	Import the employees demo database that is in /workshop/databases folder.

  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>cd /workshop/databases/employees</copy>
    ```

  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>mysql -uroot -p -P3306 -h 127.0.0.1 < ./employees.sql</copy>
    ```
## Task 4: Learn Useful SQL Statements

1. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**

    ```
    <copy>mysql -uroot -p -h 127.0.0.1 -P 3306</copy>
    ```
2. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SHOW VARIABLES LIKE "%version%";</copy>
    ```

3. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT table&#95;name, engine FROM INFORMATION&#95;SCHEMA.TABLES WHERE engine <> 'InnoDB';</copy>
    ```
4. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT table&#95;name, engine FROM INFORMATION&#95;SCHEMA.TABLES WHERE engine = 'InnoDB';</copy>
    ```
5. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT table&#95;name, engine FROM INFORMATION&#95;SCHEMA.TABLES where engine = 'InnoDB' and table&#95;schema not in ('mysql','information&#95;schema', 'sys');</copy>
    ```
6. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**

    ```
    <copy>SELECT ENGINE, COUNT(*), SUM(DATA&#95;LENGTH)/ 1024 / 1024 AS 'Data MB', SUM(INDEX&#95;LENGTH)/1024 / 1024 AS 'Index MB' FROM information&#95;schema.TABLEs group by engine;</copy>
    ```
7. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**

    ```
    <copy>SELECT table&#95;schema AS 'Schema', SUM( data&#95;length ) / 1024 / 1024 AS 'Data MB', SUM( index&#95;length ) / 1024 / 1024 AS 'Index MB', SUM( data&#95;length + index&#95;length ) / 1024 / 1024 AS 'Sum' FROM information&#95;schema.tables GROUP BY table&#95;schema ;</copy>
    ```
9. The “\G” is like “;” with a different way to show results 

  **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SHOW GLOBAL VARIABLES\G</copy>
    ```
  **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**

    ```
    <copy>SHOW GLOBAL STATUS\G</copy>
    ```
  **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**

    ```
    <copy>SHOW FULL PROCESSLIST;</copy>
    ```
  **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**

    ```
    <copy>SHOW ENGINE INNODB STATUS\G</copy>
    ```

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Dale Dasker, MySQL Solution Engineering
* **Contributors** -  Perside Foster, MySQL Engineering
* **Last Updated By/Date** - <Dale Dasker, March 2022
