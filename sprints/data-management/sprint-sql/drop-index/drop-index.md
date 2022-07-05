# How can I drop the index in the Oracle database?

Duration: 1 minute

## Drop index in Oracle database

You use the DROP INDEX statement to remove an index or domain index from the database.

When you drop a global partitioned index, a range-partitioned index, or a hash-partitioned index, all the index partitions are also dropped. If you drop a composite-partitioned index, then all the index partitions and subpartitions are also dropped.

In addition, when you drop a domain index:
* Oracle Database invokes the appropriate routine.
* If any statistics are associated with the domain index, then Oracle Database disassociates the statistics types with the FORCE clause and removes the user-defined statistics collected with the statistics type.

Dropping an index is easy. In the below syntax, you specify the name of the index that you want to drop in place of the index\_name.

```
<copy>
drop index index_name on table_name;
</copy>
```

### Example

For example, to drop the index named employee\_dept\_no\_fk\_idx on the employees table:

```
<copy>
drop index employee_dept_no_fk_idx on employees;
</copy>
```

## Learn More

* Explore more about [Dropping Index](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/DROP-INDEX.html#GUID-F60F75DF-2866-4F93-BB7F-8FCE64BF67B6)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
