# How can I update data in a table in the Oracle database?

Duration: 1 minute

## Update data in a table

You can use SQL to update values in your table, to do this we will use the update clause. To selectively update rows in a table, where clause is needed with a condition else all the rows in the table will be updated.

```
<copy>
UPDATE table-Name
SET column1-name = value1, column2-name = value2
WHERE condition;
</copy>
```

### Example

For example, the query below will update all rows of the employee table and set the value of country_code column to US.

```
update employees
set country_code = 'US';
```

Or, you can also selectively update just a specific row like this:

```
update employees
set commission = 2000
where  name = 'Sam Smith';
```

## Learn More

* Explore more about [Update Statement](https://docs.oracle.com/javadb/10.8.3.0/ref/rrefsqlj26498.html)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
