# How can I insert data into a table in the Oracle database?

Duration: 1 minute

## Insert data into a table

The INSERT statement adds one or more new rows of data to a database table.

Insert values to all the columns in the same order as columns in the table:

```
<copy>
INSERT INTO table_name
VALUES (value1, value2, value3, ...);
</copy>
```

To add values to specific columns, specify the column names and values to be inserted in order:

```
<copy>
INSERT INTO table_name (column1_name, column2_name, column3_name, ...)
VALUES (value1, value2, value3. ...);
</copy>
```

### Example

For example, to insert new values into name and location columns in an existing departments table:

```
insert into departments (name, location) 
values ('Finance','New York');
```

## Learn More

* Explore more about [Insert Statement](https://docs.oracle.com/cd/B12037_01/appdev.101/b10807/13_elems025.htm)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
