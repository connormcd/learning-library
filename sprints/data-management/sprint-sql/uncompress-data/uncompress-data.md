# How can I disable table compression in the Oracle database?

Duration: 1 minute

## Disable table compression

You can disable table compression for an existing compressed table with the ALTER TABLE...NOCOMPRESS statement.

```
<copy>
ALTER TABLE table_name NOCOMPRESS;
</copy>
```

To view the status, run the below select query

```
<copy>
SELECT compression, compress_for
FROM   user_tables
WHERE  table_name = 'table_name';
</copy>
```

For example, to disable compression for future data of employees table use the following syntax.

```
alter table EMPLOYEES nocompress for oltp;
```

## Learn More

* Explore more about [Table Compression](https://docs.oracle.com/cd/E11882_01/server.112/e41084/statements_7002.htm#i2128733)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
