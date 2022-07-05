# How can I compress data in a table in the Oracle database?

Duration: 2 minutes

As your database grows in size to gigabytes or terabytes and beyond, consider using table compression. Table compression saves disk space and reduces memory use in the buffer cache. Table compression can also speed up query execution during reads. There is, however, a cost in CPU overhead for data loading and DML. Table compression is completely transparent to applications.

## Compress data in a table

You specify table compression with the COMPRESS clause of the CREATE TABLE statement. You can enable compression for an existing table by using this clause in an ALTER TABLE statement. In this case, the only data that is compressed is the data inserted or updated after compression is enabled. Similarly, you can disable table compression for an existing compressed table with the ALTER TABLE...NOCOMPRESS statement. In this case, all data the was already compressed remains compressed, and new data is inserted uncompressed.

To specify table compression with the COMPRESS clause, add the COMPRESS clause to the end of the table definition using the CREATE TABLE statement as shown below:

```
<copy>
CREATE TABLE table_name (
id            NUMBER(10)    NOT NULL,
description   VARCHAR2(100),
created_date  DATE,
created_by    VARCHAR2(50)
)
COMPRESS;
</copy>
```

Use the following syntax to enable compression for an existing table.

```
<copy>
alter table table_name compress;
</copy>
```

### Example

Table compression is especially useful in online analytical processing (OLAP) systems, where there are lengthy read-only operations, but can also be used in online transaction processing (OLTP) systems. For example, to enable compression for future data to 'employees' table, the query looks like this:

```
alter table EMPLOYEES compress for oltp;
```

## Learn More

* Explore more about [Basic and Standard Compression](https://docs.oracle.com/cd/E29633_01/CDMOG/GUID-456BBB62-CC3E-43A3-90FE-87C285E98338.htm)
* Learn more about [Table Compression](https://docs.oracle.com/cd/E11882_01/server.112/e41084/statements_7002.htm#i2128733)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
