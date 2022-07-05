# SECURITY - DATA MASKING

## Introduction
3e) Data Masking and de-identification
Objective: Install and use data masking functionalities

Server: serverB

Estimated Lab Time: -- minutes

### Objectives

In this lab, you will:
* Objective 1
* Objective 2
* Objective 3

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
- Data masking has more functions than what we test in the lab. The full list of functions is here
- https://dev.mysql.com/doc/refman/5.7/en/data-masking-usage.html 

## Task 1: Install masking plugin

1. To install the data masking plugin, execute with statements 

    a.  **![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 
    ```
    <copy>mysql -uroot -p -h 127.0.0.1 -P 3307</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>INSTALL PLUGIN data_masking SONAME 'data_masking.so';</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SHOW PLUGINS;</copy>
    ```
2. Look for data_masking and check the status? Is it active?

## Task 2: Use masking functions

1. Install masking functions

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**
    ```
    <copy>CREATE FUNCTION gen_range RETURNS INTEGER SONAME 'data_masking.so';</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>CREATE FUNCTION gen_rnd_email RETURNS STRING SONAME 'data_masking.so';</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>CREATE FUNCTION gen_rnd_us_phone RETURNS STRING SONAME 'data_masking.so';</copy>
    ```
    d. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>CREATE FUNCTION mask_inner RETURNS STRING SONAME 'data_masking.so';</copy>
    ```
    e. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>CREATE FUNCTION mask_outer RETURNS STRING SONAME 'data_masking.so';</copy>
    ```
2. Use data masking functions

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT mask_inner(NAME, 1,1) FROM world.city limit 10;</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT mask_outer(NAME, 1,1) FROM world.city limit 10;</copy>
    ```

## Task 3: Discussion and use  Masking functions and random generators

1. Discuss differences between  mask&#95;inner  and  mask&#95;outer 

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT mask_inner(NAME, 1,1, '&') FROM world.city limit 1;</copy>
    ```
2. Use data masking random generators to these statements several times

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**  
    ```
    <copy>SELECT gen_range(1, 200);</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT gen_rnd_us_phone();</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 
    ```
    <copy>SELECT gen_rnd_email();</copy>
    ```

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021
