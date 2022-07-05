# How can I add columns to a table in the Oracle database?

Duration: 1 minute

## Add a column to a table

You can add additional columns after you have created your table using the **ALTER TABLE ... ADD ...** syntax.

```
<copy>
alter table table_name
add column_name column_datatype;
</copy>
```

### Example

For example, to add a new column called 'country_code' of datatype varchar2 to 'employees' table, the query looks like this:

```
alter table employees 
add country_code varchar2(2);
```

## Learn More

* Explore more about [Alter Table statement](https://docs.oracle.com/javadb/10.6.2.1/ref/rrefsqlj81859.html)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
