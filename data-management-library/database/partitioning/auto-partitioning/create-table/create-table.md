# Create a Non-partitioned Table

## Introduction

For auto partitioning to kick in, a non-partitioned table must be at least 5GB in Always Free Autonomous Database environments or 64GB in non-free Autonomous Database (transaction processing or data warehousing).

Estimated Time: 15mins

### Objectives
- Create a 5GB non-partitioned table.

### Prerequisites
This lab assumes you have completed the following labs:

- Provision an ADB instance (19c, Always Free).

## Task 1: Build the Table

1. Build the candidate table (it should take 8-9mins).
    
       ````
       <copy>
       --
       -- We will run the example in the ADMIN user account
       --
       connect admin/<your database credentials>
       --
       -- Hints must be enabled for the INSERT statement
       --
       alter session set optimizer_ignore_hints = false;
       --
       -- Drop the APART table if it exists already
       --
       declare
              ORA_00942 exception; pragma Exception_Init(ORA_00942, -00942);
       begin
              execute immediate 'drop table APART purge';
              exception when ORA_00942 then null;
       end;
       /
       --
       -- Create the non-partitioned APART table
       --
       create table apart (
              a   number(10), 
              b   number(10), 
              c   number(10), 
              d   date, 
              pad varchar2(1000)) nologging;
       --
       -- Table data is compressed by default, so we will insert random data 
       -- to make compreession less effective. Our aim it to create
       -- a large table as quickly as possible.
       -- 
       insert /*+ APPEND */ into apart
       with
       r as ( select /*+ materialize */ dbms_random.string('x',500) str 
              from dual connect by level <= 2000 ),
       d as ( select /*+ materialize */ to_date('01-JAN-2020') + mod(rownum,365) dte 
              from dual connect by level <= 2500 ),
       m as ( select 1 
              from dual connect by level <= 3 )
       select /*+ leading(m d r) use_nl(d r) */
       rownum, rownum, rownum, dte, str
       from m,d,r;
       --
       -- Commit the transaction
       --
       commit;
       --
       -- Statistics are gathered during the insert, but we will nevertheless re-gather here 
       --
       exec dbms_stats.gather_table_stats(user,'apart')
       </copy>
       ````
    

## Task 2: Confirm the Table is at Least 5GB

1. Execute a query to view the table segment size in megabytes

       ````
       <copy>
       select sum(bytes)/(1024*1024) size_in_megabytes 
       from   user_segments
       where  segment_name = 'APART';
       </copy>
       ````

       `````
       SIZE_IN_MEGABYTES
       -----------------
              5504         (this value will vary slightly depending on level of compression)
       `````

You may now **proceed to the next lab**.

## Acknowledgements
* **Author** - Nigel Bayliss, Dec 2021 
* **Last Updated By/Date** - Nigel Bayliss, Dec 2021