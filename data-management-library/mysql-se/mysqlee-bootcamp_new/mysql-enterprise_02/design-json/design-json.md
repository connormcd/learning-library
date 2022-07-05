# DATABASE DESIGN - MYSQL JSON 

## Introduction

4b) MySQL JSON datatype 
Objective: practice with JSON

Server: serverB

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: -- minutes

### Objectives


In this lab, you will:
* Create Database and Table
* Load Table
* Retrieve Data
* Use Index

### Prerequisites 

This lab assumes you have:
* An Oracle account
* All previous labs successfully completed
* Lab standard  
    - ![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell> the command must be executed in the Operating System shell
    - ![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql> the command must be executed in a client like MySQL, MySQL Workbench
    - ![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh> the command must be executed in MySQL shell
    
**Server:** serverB

## Task 1: Create Database and Table

1. Create a database for JSON tests

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**

    ```
    <copy>CREATE DATABASE json_test;</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>USE json_test;</copy>
    ```
2.	Create a JSON table

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**  

    ```
    <copy>CREATE TABLE jtest (id bigint NOT NULL AUTO_INCREMENT, doc JSON, PRIMARY KEY (id));</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT * FROM jtest;</copy>
    ```
## Task 2: Load Table

1.	add data to this table

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>INSERT INTO jtest(doc) VALUE('{"A": "hello", "b": "test", "c": {"hello": 1}}');</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>INSERT INTO jtest(doc) VALUE('{"b": "hello"}'),('{"c": "help"}');</copy>
    ```
2.	Display table dada  

    **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**

    ```
    <copy>SELECT * FROM jtest;</copy>
    ```
## Task 3: Retrieve Data 

1.	Retrieve json documents with shortcut “->” 

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT json_extract (doc, "$.b") FROM jtest;</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>>** 

    ```
    <copy>SELECT doc->"$.b" FROM jtest;</copy>
    ```
2.	Retrieve json documents with shortcut “$.” 

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT json_extract (doc, "$.c") FROM jtest;</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT doc->"$.b" from jtest;</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT doc->>"$.b" from jtest;</copy>
    ```
## Task 4: Use Index
5.	Create Index on the virtual column

    a. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>**  

    ```
    <copy>alter table jtest add column gencol CHAR(7) AS (doc->"$.b");</copy>
    ```
    b. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>CREATE INDEX myvirtindex ON jtest(gencol);</copy>
    ```
    c. **![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) mysql>** 

    ```
    <copy>SELECT * FROM jtest;</copy>
    ```

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021