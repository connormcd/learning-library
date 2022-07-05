# How can I create triggers for a table in the Oracle database?

Duration: 2 minutes

Triggers are procedures that are stored in the database and are implicitly run, or fired, when something happens. Traditionally, triggers supported the execution of a procedural code, in Oracle procedural SQL is called a PL/SQL block. PL stands for procedural language. When an INSERT, UPDATE, or DELETE occurred on a table or view. Triggers support system and other data events on DATABASE and SCHEMA.

## Create triggers to a table

The trigger\_name must be unique for triggers in the schema. If the trigger is in the enabled state, the triggering\_event causes the database to execute the triggered\_action if the trigger\_restriction is either TRUE or omitted. The triggering\_event is associated with either a table, a view, a schema, or the database, and it is one of Data Manipulation Language (DML) Statement, Data Definition Language (DDL) Statement or Database operation (SERVERERROR, LOGON, LOGOFF, STARTUP, or SHUTDOWN). If the trigger is in the disabled state, the triggering\_event does not cause the database to execute the triggered_action, even if the trigger\_restriction is TRUE or omitted. By default, a trigger is created in the enabled state. You can disable an enabled trigger, and enable a disabled trigger.

```
<copy>
TRIGGER trigger_name
triggering_event
[ trigger_restriction ]
BEGIN
triggered_action;
END;
</copy>
```

Unlike a subprogram, a trigger cannot be invoked directly. A trigger is invoked only by its triggering event, which can be caused by any user or application. You might be unaware that a trigger is executing unless it causes an error that is not handled properly.

A simple trigger can fire at exactly one of these timing points:

* Before the triggering event executes (statement-level BEFORE trigger)
* After the triggering event executes (statement-level AFTER trigger)
* Before each row that the event affects (row-level BEFORE trigger)
* After each row that the event affects (row-level AFTER trigger)

### Example

Triggers are frequently used to automatically populate table primary keys, the trigger example below shows how to use trigger on DEPARTMENTS table to do just this. We will use a built in function to obtain a globally unique identifier or GUID.

```
create or replace trigger  DEPARTMENTS_BIU
    before insert or update on DEPARTMENTS
    for each row
begin
    if inserting and :new.deptno is null then
        :new.deptno := to_number(sys_guid(), 
        'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    end if;
end;
/
```

## Learn More

* Explore more about [Create Trigger Statement](https://docs.oracle.com/cd/E11882_01/appdev.112/e25519/create_trigger.htm#LNPLS01374)
* [Introduction to Oracle SQL Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=943)
* [SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/12.2/sqlrf/Introduction-to-Oracle-SQL.html#GUID-049B7AE8-11E1-4110-B3E4-D117907D77AC)
