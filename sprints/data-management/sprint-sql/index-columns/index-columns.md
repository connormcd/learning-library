# How can I index columns in the Oracle database?

Duration: 2 minutes

## Index columns in Oracle database

Typically we index columns for three major reasons:
- To enforce unique values within a column
- To improve data access performance
- To prevent lock escalation when updating rows of tables that use declarative referential integrity

Creating an index is easy. All you need to do is identify which column(s) you want to index and give it a name!

```
<copy>
create index index_name on table_name (column1_name, column2_name, … );
</copy>
```

When a table is created and a PRIMARY KEY is specified an index is automatically created to enforce the primary key constraint.

To see the indexes that already exist for a given table(s) you can run the following dictionary query.

```
<copy>
select table_name "Table", 
    index_name "Index", 
    column_name "Column", 
    column_position "Position"
from  user_ind_columns 
where table_name = 'table1_name' or 
    table_name = 'table2_name'
order by table_name, column_name, column_position;
</copy>
```

### Example

It is typically good form to index foreign keys, foreign keys are columns in a table that reference another table. For example, if there are two tables - EMPLOYEES and DEPARTMENTS table and the DEPTNO column in the EMPLOYEE table references the primary key of the DEPARTMENTS table. To index the depno column of your departments table and call it employee_dept\_no\_fk\_idx the SQL is:

```
create index employee_dept_no_fk_idx 
on employees (deptno)
```

We may also determine that the EMPLOYEE table will be frequently searched by the NAME column. To improve the performance searches and to ensure uniqueness we can create a unique index on the EMPLOYEE table NAME column.

```
create unique index employee_ename_idx
on employees (name)
```

Similarly, if you specify UNIQUE for a column when creating a column a unique index is also created.

Oracle provides many other indexing technologies including function based indexes which can index expressions, such as an upper function, text indexes which can index free form text, bitmapped indexes useful in data warehousing. You can also create indexed organized tables, you can use partition indexes and more. Sometimes it is best to have fewer indexes and take advantage of in memory capabilities. All of these topics are beyond the scope of this basic introduction.

## Learn More

* Explore more about [Creating Index](https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_5010.htm)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
