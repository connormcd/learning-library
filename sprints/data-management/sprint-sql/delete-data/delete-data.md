# How can I delete data in a table in the Oracle database?

Duration: 1 minute

## Delete data in a table

You can delete one or more rows from a table using the DELETE syntax.

To delete all rows in the table:

```
<copy>
delete from table_name;
</copy>
```

To delete a specific row:

```
<copy>
delete from table_name 
where condition;
</copy>
````

## Learn More

* Explore more about [Delete Statement](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_8005.htm)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
