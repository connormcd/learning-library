# How can I query a table in the Oracle database?

Duration: 2 minutes

## Query a table

To select data from a single table it is reasonably easy, simply use the *SELECT ... FROM ... WHERE ... ORDER BY ...* syntax.

Specifying the asterisk selects all columns from all tables, views, or materialized views listed in the FROM clause.

```
<copy>
select * from table_name;
</copy>
```

To select specific columns with a condition and display the result in a specific order:

```
<copy>
select column1_name, column2_name, .. 
from table_name
where condition
order by column1_name;
</copy>
```

### Example

For example, to query data from two related tables - departments and employees you can join the data:

```
select e.name employee,
        d.name department,
        e.job,
        d.location
from departments d, employees e
where d.deptno = e.deptno(+)
order by e.name;
```

Also, as an alternative to a join you can use an inline select to query data.

```
select e.name employee,
        (select name 
        from departments d 
        where d.deptno = e.deptno) department,
        e.job
from employees e
order by e.name;
```

## Learn More

* Explore more about [Selecting Table Data](https://docs.oracle.com/cd/E18283_01/appdev.112/e10766/tdddg_selecting.htm)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
