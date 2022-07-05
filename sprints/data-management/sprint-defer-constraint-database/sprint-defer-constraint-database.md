# How can I delay applying a foreign key constraint while updating thousands of rows in an Oracle database?
Duation: 2 minutes

You are updating thousands of row and your statements should result in a referentially consistent state at the end. However your statements do not come in a referential order. So you want to delay applying the foreign key constraint until all the rows are updated.

## Applying a foreign key constraint

You need to consider that whatever you do at the table level will apply to all sessions using that table. If you haven't got exclusive access to that table, you probably don't want to drop/recreate constraints, or disable/enable them. You also don't want to be in a position of rolling back a million inserts/updates. Rolling back can be SLOW.
You can take one of the following approaches:
* If this is new data to be added to the table, load into a temporary table. Then do a single INSERT from the temporary table into the destination table. As a single statement, Oracle will apply all the check constraints at the end.
* If you can't go through a temporary table (eg updates to existing data), before starting make the constraints deferrable initially immediate. Then, within your session,
```
<copy>
SET CONSTRAINT <constraint_name> DEFERRED;
</copy>
```
If there are more than one constraint,
```
<copy>
SET CONSTRAINTS <constraint1_name>, <constraint2_name> DEFERRED;
</copy>
```
You can then apply the changes and, when you commit, the constraints will be validated.

**Note:** You can use DML error logging to help identify any rows causing violations.

## Learn More

* [DML error logging](https://docs.oracle.com/en/database/oracle/oracle-database/21/arpls/DBMS_ERRLOG.html)
