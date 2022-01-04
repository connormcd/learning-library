# Using Real-Time SQL Monitoring as a SQL Developer

## Introduction

In this practice, you act in PDB1 as a SQL developer without any super-user privileges or roles. The SQL developer will use real-time SQL monitoring to analyze the performance of his or her SQL statements.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:
* Prepare your environment in Session 1
* Setup developer environment
* Prepare your environment in Session 2
* Generate SQL Monitoring Report

### Prerequisites

This lab assumes you have:
* Obtained and signed in to your `workshop-installed` compute instance.


### Task 1: Prepare Your Environment in Session 1

Open up terminal window for **Session 1**.

1.	Execute the /home/oracle/labs/PERF/RTMonitor.sh SQL script in Session1. The script completes the following operations:
  * Creates the MONI user and MONI_TEST table, and loads the table with thousands of rows
  * Creates a developer user.
  * Grants the developer user CREATE SESSION and SELECT on the MONI.MONI_TEST table.

  ```
  $ <copy>/home/oracle/19cnf/RTMonitor.sh</copy>
  …
  $
  ```

2. Set the Oracle environment variables. At the prompt, enter **CDB1**.

  ```
  $ <copy>. oraenv</copy>
  CDB1
  ```

3.	Check the privileges and roles granted to the SQLDEV user.
  ```
  $ <copy>sqlplus sys@PDB1 AS SYSDBA</copy>
  Enter password : password

  SQL> <copy>SELECT * FROM dba_sys_privs WHERE grantee = 'SQLDEV';</copy>

  GRANTEE PRIVILEGE      ADM COM INH
  ------- -------------- --- --- ---
  SQLDEV  CREATE SESSION NO  NO  NO

  SQL> <copy>SELECT owner, table_name, privilege
       FROM   dba_tab_privs WHERE grantee = 'SQLDEV';</copy>
    2
  OWNER   TABLE_NAME PRIVILEGE
  ------- ---------- ---------
  MONI    MONI_TEST  SELECT

  SQL> <copy>SELECT * FROM dba_role_privs WHERE grantee = 'SQLDEV';</copy>

  no rows selected

  SQL>

  ```

  Q1/ Is SQLDEV granted super-user privileges and roles such as those required in Oracle Database 18c to be able to use real-time SQL monitor?
  **<p>A1/ No. He is no t granted the SELECT CATALOG ROLE role.</p>**

### Task 2: Prepare Your Environment in Session 2

Open up new terminal window for **Session 2**.

1.	In Session2, connect as the SQLDEV developer in PDB1 and execute a long-running query
```
  $ <copy>sqlplus sqldev@PDB1</copy>
  Enter password: password

  SQL> <copy>SELECT count(*) FROM moni.moni_test t1, moni.moni_test t2
       WHERE  t1.c = t2.c AND t1.c = 1;</copy>
  …
```

### Task 3: Generate SQL Monitoring Report

1.	In Session1, connect as the SQLDEV developer to PDB1.
  ```
  SQL> <copy>CONNECT sqldev@PDB1</copy>
  Enter password: password
  Connected.
  SQL>
  ```

2. Get an overview of the long running queries.
```
    SQL> <copy>SELECT sql_id, status, sql_text FROM v$sql_monitor;</copy>
  SELECT sql_id, status, sql_text FROM v$sql_monitor
                                       *
  ERROR at line 1:
  ORA-00942: table or view does not exist

  SQL>
```

  Q1/ Traditionally, real-time SQL monitor is mainly used by DBAs because they are responsible for monitoring and tuning database performance. Real-time SQL monitor tracks and collects SQL and execution plan statistics in fixed views which are only accessible by users who have been granted the SELECT CATALOG ROLE role. A regular user, such as an application developer or a low-privileged user without the SELECT CATALOG ROLE role and SELECT privilege on the real-time SQL monitor fixed views, can write a SQL statement, execute it, see the SQL result set and its SQL plan using the explain plan command, but not its execution plan because it is stored in V$SQL_PLAN.

  Is the SQLDEV user granted the SELECT_CATALOG_ROLE role? Is the SQLDEV user granted the SELECT privilege on V$SQL_PLAN? Can the SQLDEV user use real-time SQL monitor to view the execution plan for his SQL statement execution?

  **A1/ No. The SQLDEV user is not granted the SELECT_CATALOG_ROLE role nor the SELECT privilege on the V$SQL_MONITOR view.**

3. Generate the SQL monitor report from the command line, run the REPORT_SQL_MONITOR function in the DBMS_SQLTUNE package.

```
        SQL> <copy>VARIABLE my_rept CLOB</copy>
    SQL> <copy>BEGIN
            :my_rept :=DBMS_SQLTUNE.REPORT_SQL_MONITOR();
    END;</copy>
    /  2    3    4

    PL/SQL procedure successfully completed.

    SQL> <copy>SET LINESIZE 78</copy>
    SQL> <copy>PRINT :my_rept</copy>

    MY_REPT
    ----------------------------------------------------------------
    SQL Monitoring Report

    SQL Text
    ------------------------------
    SELECT count(*) FROM moni.moni_test t1, moni.moni_test t2 WHERE t1.c = t2.c AND t1.c = 1

    Global Information
    ------------------------------
     Status              :  EXECUTING
     Instance ID         :  1
     Session             :  SQLDEV (30:25679)
     SQL ID              :  9fqxj0xpnt222
     SQL Execution ID    :  16777217
     Execution Started   :  01/07/2019 13:29:22
     First Refresh Time  :  01/07/2019 13:29:31
     Last Refresh Time   :  01/07/2019 13:30:02
     Duration            :  43s
     Module/Action       :  SQL*Plus/-
     Service             :  pdb1
     Program             :  sqlplus@edvmr1p0 (TNS V1-V3)

    Global Stats
    ===================================================================
    | Elapsed |   Cpu   |    IO    |  Other   | Buffer | Read | Read  |

    | Time(s) | Time(s) | Waits(s) | Waits(s) |  Gets  | Reqs | Bytes |
    ===================================================================
    |     411 |     388 |     0.00 |       23 |    502 |   18 |   3MB |
    ===================================================================

    SQL Plan Monitoring Details (Plan Hash Value=183808681)
    ================================================================================
    ================================================================================
    | Id   |        Operation         |       Name       |  Rows   | Cost |   Time
      | Start  | Execs |   Rows   | Read | Read  | Mem  | Activity | Activity Detail
     |
    |      |                          |                  | (Estim) |      | Active(s
    ) | Active |       | (Actual) | Reqs | Bytes |      |   (%)    |   (# samples)
     |
    ================================================================================
    ================================================================================
    |    0 | SELECT STATEMENT         |                  |         |      |       35
    4 |     +9 |     1 |        0 |      |       |    . |          |
     |
    |    1 |   SORT AGGREGATE         |                  |       1 |      |       35
    4 |     +9 |     1 |        0 |      |       |    . |          |
     |
    | -> 2 |    HASH JOIN             |                  |     39G | 193K |       41
    3 |     +2 |     1 |       4G |      |       | 15MB |   100.00 | Cpu (413)
     |
    |    3 |     INDEX FAST FULL SCAN | MONI_TEST_C_INDX |    198K |  114 |
    1 |     +9 |     1 |     200K |   18 |   3MB |    . |          |
     |
    | -> 4 |     INDEX FAST FULL SCAN | MONI_TEST_C_INDX |    198K |  114 |       40
    4 |     +9 |     1 |    48640 |      |       |    . |          |
     |
    ================================================================================

    SQL>

    SQL> <copy>EXIT</copy>
    $

```

4.	In Session2, interrupt the long-running query.
  ```
  CTRL C

  SQL> SELECT count(*) FROM moni.moni_test t1, moni.moni_test t2
                            *
  ERROR at line 1:
  ORA-01013: user requested cancel of current operation

  SQL> <copy>EXIT</copy>
  $
```

  ## Learn More

- [19c New Feature:Real-time SQL Monitoring for Developers](https://support.oracle.com/knowledge/Oracle%20Database%20Products/2480461_1.html#SCOPE)

## Acknowledgements

- **Author**- Dominique Jeunot, Consulting User Assistance Developer
- **Last Updated By/Date** - Subbu Iyer, Austin Specialists Hub, December 2021
