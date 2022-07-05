# INSTALL - MYSQL SHELL

## Introduction

2d) MySQL Shell: the new client
Objective: Execute MySQL Shell and explore the interface: 
•	help
•	settings
•	test an extension: reporting
•	command mode

Server: serverB

Estimated Time: -- minutes



### Objectives

In this lab, you will:
* Install MySQL Shell
* Use MySQL Shell with JASON
* Use MySQL Shell with SQL
* Use MySQL Shell with PYTHON

**Use ServerB for this lab**
**Note: to close the MySQL Shell you can the commands “\q” or “\exit”**

### Prerequisites (Optional)


This lab assumes you have:
* An Oracle account
* All previous labs successfully completed

* Lab standard  
    - ![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell> the command must be executed in the Operating System shell
    - ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql> the command must be executed in a client like MySQL, MySQL Workbench
    - ![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh> the command must be executed in MySQL shell
    

## Task 1: Install MySQL Shell
1.	Install Mysql Shell, a new client that can be used in devOps organizations (you’ll learn more about it during the course)

   **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>sudo yum install /workshop/linux/mysql-shell-commercial-8.0.25-1.1.el7.x86_64.rpm </copy>
    ```
2.	Launch MySQL Shell

   **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>mysqlsh</copy>
    ```
## Task 2: Use MySQL Shell with JSON
1.	Discover the command auto-completion feature, type \h and press TAB twice 

   **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL JS>** 

    ```
    <copy>\h [tab] [tab]</copy>
    ```
2.	Check the available options. Add the letter “e” to “\h” and press TAB again to see that the command will automatically complete for you. Press enter and explore the help menu

   **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL JS>** 

    ```
    <copy>\he [tab]</copy>
    ```
3.	Activate the command history autosave in MySQL shell
MySQL Shell comes with the option of automatically saving the history of command disabled by default. Therefore we need to check and to activate it.
	
	a.	Show settings and look for history.autoSave

   **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL JS>** 

    ```
    <copy>shell.options</copy>
    ```
	b.	activate autosave history

   **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL JS>** 

    ```
    <copy>\option --persist history.autoSave=1</copy>
    ```
4.	Close and reopen the session and in the new one use the arrow up key to verify that the data from previous session are available
   
   **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL JS>** 

    ```
    <copy>\exit</copy>
    ```

## Task 3: Use MySQL Shell with SQL
1.	MySQL Shell can be used as SQL client
	a.	Connect to the newly installed mysql-advanced instance. Enter the password when requested and press enter. When the prompt asks to save the password choose No and press Enter.
   		
	**![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL JS>** 

    ```
    <copy>\c admin@127.0.0.1:3307</copy>
    ```
	b.	Switch to SQL mode

    **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL JS>** 

    ```
    <copy>\q</copy>
    ```
2.	Now you can submit SQL commands

   **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL SQL>** 

    ```
    <copy>show databases;</copy>
    ```

   **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL SQL>** 

    ```
    <copy>SELECT * FROM world.city LIMIT 10;</copy>
    ```

3.	But MySQL Shell has also nice features. Here we see one of them: reporting.
If you want to execute a command continuously use the command “query” (default refresh time: 5 seconds). 
To exit from reporting press CTRL+C


   **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL SQL>** 

    ```
    <copy>watch query show processlist;</copy>
    ```

   **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL SQL>** 

    ```
    <copy>watch query --interval=2 show processlist;;</copy>
    ```

## Task 4: Use MySQL Shell with PYTHON
1.	Switch to Python command mode, then Javascript command mode, check how prompt change

	**![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL Py>** 

    ```
    <copy>\py</copy>
    ```   
	**![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL Py>** 

    ```
    <copy>\js</copy>
    ```
2.	Exit from MySQL Shell with “\q” or “\exit”

   **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) MySQL JS>** 

    ```
    <copy>\q</copy>
    ```
3.	Command line connection from MySQL Client and MySQL Shell are similar (just specify  “--sql”). Try these

   **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>mysql -uroot -p -h127.0.0.1 -P3307</copy>
    ```

   **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SHOW DATABASES;</copy>
    ```
   **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>exit</copy>
    ```
   **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>mysqlsh --sql -uroot -p -h127.0.0.1 -P3307</copy>
    ```
 
   **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SHOW DATABASES;</copy>
    ```
   **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>exit</copy>
    ```

4.	From now on, if you like, the labs may be completed with MySQL Shell instead of classic mysql client.


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
