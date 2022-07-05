# How can I disable triggers for a table in the Oracle database?

Duration: 2 minutes

Triggers are procedures that are stored in the database and are implicitly run, or fired, when something happens. Traditionally, triggers supported the execution of a procedural code, in Oracle procedural SQL is called a PL/SQL block. PL stands for procedural language. When an INSERT, UPDATE, or DELETE occurred on a table or view. Triggers support system and other data events on DATABASE and SCHEMA.

## Disable triggers to a table

You may consider temporarily disabling a trigger if one of the following conditions is true:
* An object that the trigger references is not available.
* You must perform a large data load and want it to proceed quickly without firing triggers.
* You are loading data into the table to which the trigger applies.

You disable a trigger using the ALTER TRIGGER statement with the DISABLE option. In the below syntax, you specify the name of the trigger that you want to disable in place of the trigger\_name.

```
<copy>
ALTER TRIGGER trigger_name DISABLE;
</copy>
```

You can disable all triggers associated with a table at the same time using the ALTER TABLE statement with the DISABLE ALL TRIGGERS option.

```
<copy>
ALTER TABLE table_name
DISABLE ALL TRIGGERS;
</copy>
```

### Example

For example, to disable the trigger DEPARTMENTS_BIU of the DEPARTMENTS table, you use the following statement:

```
ALTER TRIGGER DEPARTMENTS_BIU DISABLE;
```

For example, to disable all triggers defined for the inventory table, enter the following statement:

```
ALTER TABLE DEPARTMENTS
DISABLE ALL TRIGGERS;
```

## Learn More

* Explore more about [Enabling and Disabling Triggers](https://docs.oracle.com/cd/E18283_01/server.112/e17120/general004.htm)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
