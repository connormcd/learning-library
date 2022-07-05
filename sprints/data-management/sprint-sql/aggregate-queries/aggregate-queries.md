# How can I write aggregate queries on a table in the Oracle database?

Duration: 2 minutes

Aggregate functions return a single result row based on groups of rows, rather than on single rows. This sum and average functions takes as an argument any numeric data type or any nonnumeric data type that can be implicitly converted to a numeric data type. The function returns the same data type as the numeric data type of the argument.

## Aggregate queries on a table

1. **COUNT** returns the number of rows returned by the query. If you specify the asterisk (*), then this function returns all rows, including duplicates and nulls. COUNT never returns null.

    ```
    <copy>
    select count(*)
    from table_name;
    </copy>
    ```

2. **SUM** returns the sum of values of a column.

    ```
    <copy>
    select sum(column_name)
    from table_name;
    </copy>
    ```

3. **AVG** returns average value of a column.

    ```
    <copy>
    select avg(column_name)
    from table_name;
    </copy>
    ```

4. **MAX** returns maximum value of a column.

    ```
    <copy>
    select max(column_name)
    from table_name;
    </copy>
    ```

5. **MIN** returns minimum value of a column.

    ```
    <copy>
    select min(column_name)
    from table_name;
    </copy>
    ```

## Learn More

* Explore more about [Aggregate Functions](https://docs.oracle.com/database/121/SQLRF/functions003.htm#SQLRF20035)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
