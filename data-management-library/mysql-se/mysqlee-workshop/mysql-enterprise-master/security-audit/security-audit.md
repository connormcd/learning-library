# SECURITY - MYSQL ENTERPRISE AUDIT

## Introduction
MySQL Enterprise Audit
Objective: Auditing in action…

Estimated Lab Time: 20 minutes

### Objectives

In this lab, you will:
* Setup Audit Log
* Use Audit


### Prerequisites


This lab assumes you have:
* An Oracle account
* All previous labs successfully completed

* Lab standard  
    - ![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell> the command must be executed in the Operating System shell
    - ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql> the command must be executed in a client like MySQL, MySQL Workbench
    - ![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh> the command must be executed in MySQL shell
    
**Notes:**
- Audit can be activated and configured without stop the instance. In the lab we edit my.cnf to see how to do it in this way

## Task 1: Setup Audit Log

1. Enable Audit Log on mysql-enterprise (remember: you can’t install on mysql-gpl).  Audit is an Enterprise plugin.

    a. Edit the my.cnf setting in /mysql/etc/my.cnf

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>sudo nano /mysql/etc/my.cnf</copy>
    ```
    b. Change the line “plugin-load=thread_pool.so” to load the plugin

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>plugin-load=thread_pool.so;audit_log.so</copy>
    ```
    c. below the previous add these lines to make sure that the audit plugin can't be unloaded and that the file is automatically rotated at 20 MB
    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**

    ```
    <copy>audit_log=FORCE_PLUS_PERMANENT</copy>
    ```
    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>audit_log_rotate_on_size=20971520</copy>
    ```
    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>audit_log_format=JSON</copy>
    ```
    
    d. Restart MySQL (you can configure audit without restart the server, but here we show how to set the configuration file)

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>mysqladmin -uroot -p -h 127.0.0.1 -P3306 shutdown</copy>
    ```
     **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>sudo /mysql/mysql-latest/bin/mysqld --defaults-file=/mysql/etc/my.cnf $MYSQLD_OPTS &</copy>
    ```

     e. Load Audit functions

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>mysql -uroot -p -h 127.0.0.1 -P 3306 < /workshop/audit_log_filter_linux_install.sql</copy>
    ```

    f. Using the Administrative Connection, create a Audit Filter for all activity and all users

	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT audit_log_filter_set_filter('log_all', '{ "filter": { "log": true } }');</copy>
    ```

	**![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT audit_log_filter_set_user('%', 'log_all');</copy>
    ```

     g. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>exit</copy>
    ```

     h. Monitor the output of the audit.log file:

    **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>tail -f /mysql/data/audit.log</copy>
    ```


## Task 2: Use Audit 

1. Login to mysql-enterprise with the user “appuser1”, then submit some commands

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>mysql -u appuser1 -p -h 127.0.0.1 -P 3306</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
    ```
    <copy>USE employees;</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT * FROM employees limit 25;</copy>
    ```
    d. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT emp_no,salary FROM employees.salaries WHERE salary > 90000;</copy>
    ```

   
2. Let's setup Audit to only log connections. Using the Administrative Connection, create a Audit Filter for all connections 

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SET @f = '{ "filter": { "class": { "name": "connection" } } }';</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT audit_log_filter_set_filter('log_conn_events', @f);</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT audit_log_filter_set_user('%', 'log_conn_events');</copy>
    ```


3.  Login to mysql-enterprise with the user “appuser1”, then submit some commands

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>mysql -u appuser1 -p -h 127.0.0.1 -P 3306</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
    ```
    <copy>USE employees;</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT * FROM employees limit 25;</copy>
    ```
    d. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT emp_no,salary FROM employees.salaries WHERE salary > 90000;</copy>
    ```


4. Let's setup Audit to only log unique users. Using the Administrative Connection, create a Audit Filter for appuser1 

    a. Remove previous filter:

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT audit_log_filter_remove_filter('log_conn_events ');</copy>
    ```
    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT audit_log_filter_flush();</copy>
    ```

    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT audit_log_filter_set_filter('log_all', '{ "filter": { "log": true } }');</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT audit_log_filter_set_user('appuser1@<client IP>', 'log_all');</copy>
    ```


5.  Login to mysql-enterprise with the user “appuser1”, then submit some commands

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>mysql -u appuser1 -p -h<server IP> -P 3306</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
    ```
    <copy>USE employees;</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT * FROM employees limit 25;</copy>
    ```
    d. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT emp_no,salary FROM employees.salaries WHERE salary > 90000;</copy>
    ```


6.  Login to mysql-enterprise with the user “appuser2”, then submit some commands

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>mysql -u appuser2 -p -h127.0.0.1 -P 3306</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
    ```
    <copy>USE employees;</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT * FROM employees limit 25;</copy>
    ```
    d. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT emp_no,salary FROM employees.salaries WHERE salary > 90000;</copy>
    ```


7. Let's setup Audit to only log access to salaries tables. Using the Administrative Connection, create a Audit Filter for salaries 

    a. Remove previous filter:

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT audit_log_filter_remove_filter('log_all ');</copy>
    ```
    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT audit_log_filter_flush();</copy>
    ```

    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SET @f='
 {
    "filter": {
       "class": 
         {
          "name": "table_access",
          "event": 
            {
              "name": [ "insert", "update", "delete" ],
              "log": { "field": { "name": "table_name.str", "value": "salaries" }}
            }
         }
     }
}';</copy>


   c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT audit_log_filter_set_filter('salary_insert', @f);</copy>
    ```
   d. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT audit_log_filter_set_user('%', 'salary_insert');</copy>
    ```


8. Login as 'appuser1' and run a query against the salaries table;

    a. **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>**
    ```
    <copy>mysql -u appuser1 -p -h127.0.0.1 -P 3306</copy>
    ```

    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
    ```
    <copy>USE employees;</copy>
    ```

    a. Run updates on salaries table

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>UPDATE employees.salaries SET salary = 74234 WHERE emp_no = 10001;</copy>
    ```



9. Some Administrative commands for checking Audit filters and users.  Log in using the Administrative Connection,

   a. Check existing filters:

   **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT * FROM mysql.audit_log_filter;</copy>
    ```
   b. Check Users being Audited:
   
   **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT * FROM mysql.audit_log_user;</copy>
    ```
   c. Global Audit log disable

   **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SET GLOBAL audit_log_disable = true;</copy>
    ```


10. You can check the documentation about other Log filters & policies

## Learn More

* [Writing Audit Filters](https://dev.mysql.com/doc/refman/8.0/en/audit-log-filtering.html)
* [Audit Filter Definitions](https://dev.mysql.com/doc/refman/8.0/en/audit-log-filter-definitions.html)

## Acknowledgements
* **Author** - Dale Dasker, MySQL Solution Engineering
* **Contributors** -  
* **Last Updated By/Date** - <Dale Dasker, March 2022
