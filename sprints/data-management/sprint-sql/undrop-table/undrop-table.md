# How can I retrieve a dropped table in the Oracle database?

Duration: 1 minute

## Retrieve a dropped table

If the RECYCLEBIN initialization parameter is set to ON (the default in 10g), then dropping this table will place it in the recycle bin. To see if you can un-drop a table run the following data dictionary query:

```
<copy>
select object_name, 
    original_name, 
    type, 
    can_undrop, 
    can_purge
from recyclebin;
</copy>
```

To retrieve tables we use the flashback command:

```
<copy>
FLASHBACK TABLE TABLE_NAME TO BEFORE DROP;
</copy>
```

### Example

For example, to retrieve employees table after checking the recycle bin:

```
flashback table EMPLOYEES to before drop;
select count(*) employees
from employees;
```

## Learn More

* Explore more about [Recovering a Dropped Table Using Oracle Flashback Drop](https://docs.oracle.com/database/121/ADMQS/GUID-5A842A1B-4A32-46D1-9269-3F51244BBEB9.htm#ADMQS0944)
* Learn more about [Recovering a Dropped Table](https://docs.oracle.com/en/database/oracle/oracle-database/tutorial-rec-flashback/index.html?opt-release-19c?learningpath=true&appuser=nobody&appsession=9331452079823&contentid=26524&activityname=Recover%20a%20Dropped%20Table%20Using%20Oracle%20Flashback%20Drop&eventid=6362)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
