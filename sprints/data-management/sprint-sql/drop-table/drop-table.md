# How can I drop a table in the Oracle database?

Duration: 1 minute

## Drop a table

You can drop tables using the SQL DROP command. Dropping a table will remove all of the rows and drop sub-objects including indexes and triggers.

```
<copy>
drop table table_name;
</copy>
```

### Example

For example, the following DROP statements will drop the employees tables. The optional cascade constraints clause will drop remove constraints thus allowing you to drop database tables in any order.

```
drop table employees cascade constraints;
```

## Learn More

* Explore more about [Drop Table](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_9003.htm)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
