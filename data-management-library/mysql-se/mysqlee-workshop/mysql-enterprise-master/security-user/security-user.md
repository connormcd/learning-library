# SECURITY - MYSQL USERS

## Introduction

Users management
Objective: explore user creation and privileges on a Server 


*This lab walks you through creating some users which will be used to Audit.

Estimated Time: 10 minutes


### Objectives

In this lab, you will  do the followings:
- Connect to mysql-enterprise
- Create appuser 

### Prerequisites

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed

* Lab standard  
    - ![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell> the command must be executed in the Operating System shell
    - ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql> the command must be executed in a client like MySQL, MySQL Workbench
    - ![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh> the command must be executed in MySQL shell
    
**Notes:**
- Open a notepad file and  your linux Private IP on student###-serverA 

- serverA  PRIVATE ip: (client_ip)

## Task 1: Connect to mysql-enterprise om Server

1. Connect to your mysql-enterprise with administrative user

   **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>mysql -uroot -p -h 127.0.0.1 -P 3306</copy>
    ```

2. Create a new user and restrict the user to your “Server” IP

	a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>CREATE USER 'appuser1'@<client_ip> IDENTIFIED BY 'Welcome1!';</copy>
    ```

	b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>GRANT ALL PRIVILEGES ON employees.* TO 'appuser1'@<client_ip>;</copy>
    ```

	c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SHOW GRANTS FOR 'appuser1'@<client_ip>;</copy>
    ```
## Task 2: Connect to a second mysql-enterprise on Server
1. Open a new SSH connection on Server and from there connect to mysql-enterprise with appuser1

	a. connect to mysql-enterprise with appuser1
    
   **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>mysql -u appuser1 -p -h <server_ip> -P 3306</copy>
    ```
	b. Run a select on the tables e.g.

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>USE employees;</copy>
    ```

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT * FROM employees;</copy>
    ```

2. Switch to the administrative connection revoke privilege on city to appuser

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>REVOKE SELECT ON employees.* FROM 'appuser1'@<client_ip>;</copy>
    ```

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SHOW GRANTS FOR 'appuser1'@<client_ip>;</copy>
    ```
3. Repeat the select on appuser connection for the user. There is a difference?

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT * FROM employees;</copy>
    ```

## Task 3: Use appuser1 connection
1.	Close and reopen the appuser1 connection for the user, then repeat above commands. There is a difference? 

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>exit</copy>
    ```

	**![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>mysql -u appuser1 -p -h <server_ip> -P 3306</copy>
    ```
	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>USE employees;</copy>
    ```
    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT * FROM employees;</copy>
    ```
2.	Switch to the administrative connection revoke ‘USAGE’ privilege using and administrative connection and verify (tip: this privilege can’t be revoked…)

	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
	```
	<copy>REVOKE USAGE ON *.* FROM 'appuser1'@<client_ip>;</copy>
	```
	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
	```
	<copy>SHOW GRANTS FOR 'appuser1'@<client_ip>;</copy>
	```

3.	Using the administrative connection revoke all privileges using and administrative connection and verify

	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
	```
    <copy>REVOKE ALL PRIVILEGES ON *.* FROM 'appuser1'@<client_ip>;</copy>
    ```
	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
	```
    <copy>SHOW GRANTS FOR 'appuser1'@<client_ip>;</copy>
    ```   
4.	Close and reopen appuser session, do you see schemas?

## Task 4: Restore user privileges
1.	Using the administrative connection restore user privileges to reuse it in next labs

	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
    ```
    <copy>GRANT ALL PRIVILEGES ON employees.* TO 'appuser1'@<client_ip>;</copy>
    ```
2.	Using the administrative connection, what are your password settings?

	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SHOW VARIABLES LIKE 'validate_password%';</copy>
    ```
3.	Try to set unsecure passwords for appuser

	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>alter user 'appuser1'@<client_ip> identified by 'appuser';</copy>
    ```
	
	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>alter user 'appuser1'@<client_ip> identified by 'Welcome';</copy>
    ```

	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>alter user 'appuser1'@<client_ip>identified by 'We1!';</copy>
    ```

	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
    ```
    <copy>alter user 'appuser'@<client_ip> identified by 'Welcome1!'</copy>
    ```

## Task 5: Add additional users

1. Using the Administrative Connection, create a new user and restrict the user to your “Server” IP

	a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>CREATE USER 'appuser2'@<client_ip> IDENTIFIED BY 'Welcome1!';</copy>
    ```

	b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>GRANT ALL PRIVILEGES ON employees.* TO 'appuser2'@<client_ip>;</copy>
    ```

2. Using the Administrative Connection, create another new user and restrict the user to your “Server” IP

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>CREATE USER 'appuser3'@<client_ip> IDENTIFIED BY 'Welcome1!';</copy>
    ```

	b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>GRANT ALL PRIVILEGES ON employees.* TO 'appuser3'@<client_ip>;</copy>
    ```


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [CREATE USER](https://dev.mysql.com/doc/refman/8.0/en/create-user.html)
* [MySQL Access Control Lists](https://dev.mysql.com/doc/refman/8.0/en/access-control.html)

## Acknowledgements
* **Author** - Dale Dasker, MySQL Solution Engineering
* **Contributors** -  Perside Foster, MySQL Engineering
* **Last Updated By/Date** - <Dale Dasker, March 2022
