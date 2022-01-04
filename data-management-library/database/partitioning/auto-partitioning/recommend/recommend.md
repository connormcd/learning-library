# Execute Recommend Task

## Introduction

Use auto partitioning to evaluate the performance benefits of partitioning a candidate table.

Estimated Time: 20mins
 
### Objectives
- Use auto partitioning to *recommend* a partitioning method and confirm it will  yield performance benefits for our workload.

### Prerequisites
This lab assumes you have completed the following labs:

- Provision an ADB instance (19c, Always Free)
- Create non-partitioned table
- Validate the table

## Task 1: Call the Recommend API and Report Results

The *recommend\_partition\_method* procedure will perform an analysis of the workload queries and the table itself. From this information, a candidate partitioning scheme will be identified. Next, a partitioned copy of the table is built and the workload queries are re-tested on that. Finally, a summary report will be generated.

The time to complete the following proceure is dependent on the table size, the number of indexes, and the elapsed execution time for the captured workload (and auto partitioning may choose to use a subset of the workload rather than the whole thing). 

1. Run the following PL/SQL block. It will take approcimately 20 mins to complete (for a 5GB table and the workload we captured earlier).

    ````
    <copy>
     var rep clob
     set timing on
     set serveroutput on
     set long 1000000
     set pagesize 10000
     set linesize 200
 
     exec dbms_auto_partition.configure('AUTO_PARTITION_MODE','REPORT ONLY');
     
     declare
       r raw(100);
       cursor c1 is
            select partition_method, partition_key, report
            from   dba_auto_partition_recommendations
            where recommendation_id = r;

     begin
        :rep := null;
        r :=
           dbms_auto_partition.recommend_partition_method(
            table_owner    => 'ADMIN',
            table_name     => 'APART',
            report_type    => 'TEXT',
            report_section => 'ALL',
            report_level   => 'ALL');

     for c in c1
     loop
        dbms_output.put_line('=============================================');
        dbms_output.put_line('ID:     '||r);
        dbms_output.put_line('Method: '||c.partition_method);
        dbms_output.put_line('Key   : '||c.partition_key);
        dbms_output.put_line('=============================================');
        :rep := c.report;
     end loop;

     end;
     /

     select :rep from dual;
    </copy>
    ````

2. The PL/SQL block will output a message similar to this:

      `````
      =============================================
      ID:     D28FC3CF09DF1E1DE053D010000AF8F8
      Method: LIST(SYS_OP_INTERVAL_HIGH_BOUND("D", INTERVAL '2' MONTH, TIMESTAMP '2020-01-01 00:00:00')) AUTOMATIC 
      Key   : D
      =============================================
      `````

The partitioning method is not a standard range partition because it needs to account for NULL partition keys and it allows us to avoid creating a large number of partitions if, for example, column D is inserted/updated with a date value far into the future.

You may now **proceed to the next lab**.

## Acknowledgements
* **Author** - Nigel Bayliss, Dec 2021 
* **Last Updated By/Date** - Nigel Bayliss, Dec 2021