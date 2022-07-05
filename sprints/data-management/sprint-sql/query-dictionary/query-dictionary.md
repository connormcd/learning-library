# How can I query the Oracle data dictionary?

Duration: 2 minutes

## Query Oracle data dictionary

**Views with the Prefix USER:** The views most likely to be of interest to typical database users are those with the prefix USER. For example, the following query returns all the objects contained in your schema:

```
<copy>
SELECT object_name, object_type FROM USER_OBJECTS;
</copy>
```

**Views with the Prefix ALL:** Views with the prefix ALL refer to the user's overall perspective of the database. These views return information about schema objects to which the user has access through public or explicit grants of privileges and roles, in addition to schema objects that the user owns. For example, the following query returns information about all the objects to which you have access:

```
<copy>
SELECT owner, object_name, object_type FROM ALL_OBJECTS;
</copy>
```

**Views with the Prefix DBA:** Views with the prefix DBA show a global view of the entire database. Synonyms are not created for these views, because DBA views should be queried only by administrators. Therefore, to query the DBA views, administrators must prefix the view name with its owner, SYS, as in the following:

```
<copy>
SELECT owner, object_name, object_type FROM SYS.DBA_OBJECTS;
</copy>
```

### Example

Table meta data is accessible from the Oracle data dictionary. The following queries show how you can query the data dictionary tables. For example, to query existing employees table:

```
select table_name, tablespace_name, status
from user_tables
where table_Name = 'EMPLOYEES';
```

```
select column_id, column_name , data_type
from user_tab_columns
where table_Name = 'EMPLOYEES'
order by column_id;
```

## Learn More

* [Explore more about the data dictionary](https://docs.oracle.com/cd/B19306_01/server.102/b14220/datadict.htm)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
