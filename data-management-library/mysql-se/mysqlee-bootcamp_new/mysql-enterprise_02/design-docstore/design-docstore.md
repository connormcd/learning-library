# DATABASE DESIGN - MYSQL DOCUMENT STORE

## Introduction

4c) MySQL Document Store
Objective: Understanding the functioning of MySQL Document Store and practicing some CRUD operations.

Server: serverB

*Describe the lab in one or two sentences, for example:* This lab walks you through the steps to ...

Estimated Lab Time: -- minutes

### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
* *Use Xprotocol and use collection
* Work with 1ndexes

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
- Please note that we use the port for Xdev (33070) instead of usual classic protocol port (3307)


## Task 1: Use Xprotocol and use collection

1. Please connect to MySQL Database via X Protocol

	**![#00cc00](https://via.placeholder.com/15/00cc00/000000?text=+) shell>** 

    ```
    <copy>mysqlsh -uroot -h127.0.0.1 -P33070 -p</copy>
    ```
2. Create and use a test schema. (We use javascript mode, but python is available also)
	
	a. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>session.createSchema('test')</copy>
    ```
	b. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>\use test</copy>
    ```
3. Now create and populate a small collection
	
	c. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>db.createCollection('posts');</copy>
    ```
	d. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>db.posts.add({"title":"MySQL 8.0 rocks", "text":"My first post!", "code": "42"})</copy>
    ```
	e. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>db.posts.add({"title":"Polyglot database", "text":"Developing both SQL and NoSQL applications"})</copy>
    ```
4. Checking the built-in JSON validation
	
	**![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>db.posts.add("This is not a valid JSON document")</copy>
    ```
5. Inspect the posts collection you have just created 
	
	**![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>db.posts.find()</copy>
    ```
6. What can you notice? Did the system add something to content by itself?
	
	**![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>db.posts.find().limit(1)</copy>
    ```
7.  Modify existing elements of the collection
	
	a. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 
     ```
    <copy> db.posts.modify("title = 'MySQL 8.0 rocks'").set("title", " MySQL 8.0 rocks!!!")</copy>
    ```
    b. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 
    ```
    <copy>exit</copy>
    ```
	c. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 
    ```
    <copy>db.posts.find()</copy>
    ```
    d. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 
    ```
    <copy>exit</copy>
    ```
## Task 2: Work with 1ndexes

1. Check that that a collection is just a table with 2 columns: Index and JSON Document
	
	a. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>session.sql("desc posts")</copy>
    ```
	b. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>session.sql("show create table posts")</copy>
    ```
	c. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>session.sql("select * from posts")</copy>
    ```
2. Therefore, it is possible to add indexes on specific JSON elements of the collection

	a. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>db.posts.createIndex('myIndex', {fields: [{field: "$.title", type: "TEXT(20)"}]} )</copy>
    ```
	b. **![#ff9933](https://via.placeholder.com/15/ff9933/000000?text=+) mysqlsh>** 

    ```
    <copy>session.sql("show create table posts")</copy>
    ```

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Perside Foster, MySQL Engineering
* **Contributors** -  Marco Carlessi, MySQL Engineering
* **Last Updated By/Date** - <Perside Foster, October 2021