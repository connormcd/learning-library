# How do I use SQL install operations with a cloud code repository?
Duration: 5 minutes

## Use SQL Install Operations with a Cloud Code Repository

The DBMS\_CLOUD\_REPO SQL Install operations allow you to store and download SQL scripts from a Cloud Code Repository.

First, obtain a Cloud Code Repository handle to provide access a repository and ensure repository initialization.

You also need to create a repository before you work with SQL Install operations.

The scripts are intended as schema install scripts and not as generic SQL scripts:

* Scripts cannot contain SQL*Plus client specific commands.
* Scripts cannot contain bind variables or parameterized scripts.
* SQL statements must be terminated with a slash on a new line (/).
Scripts can contain DDL, DML PLSQL statements, but direct SELECT statements are not supported. Using SELECT within a PL/SQL block is supported.
* Any SQL statement that can be run using EXECUTE IMMEDIATE will work if it does not contain bind variables or defines.

Here are 3 commonly used operations:

1. To upload DDL metadata to a Cloud Code Repository:

```
<copy>
VAR repo clob
BEGIN
  DBMS_CLOUD_REPO.EXPORT_OBJECT(
        repo => :repo,
        object_type => 'PACKAGE',
        object_name => 'MYPACK',
        file_path   => 'mypack.sql'
  );
END;
/</copy>
```

2. To install SQL statements from a file:

```
<copy>
VAR repo clob
BEGIN
  DBMS_CLOUD_REPO.INSTALL_FILE(
        repo => :repo,
        file_path     => 'test3.sql',
        stop_on_error => FALSE
  );
END;
/
</copy>
```

3. To install SQL statements from a buffer:

```
<copy>
VAR repo clob
BEGIN
  DBMS_CLOUD_REPO.INSTALL_SQL(
        repo => :repo,
        content   => 'create table t1 (x varchar2(30))' || CHR(10) || '/',
        stop_on_error => FALSE
  );
END;
/
</copy>
```

## Learn More

* [Using and Managing a Cloud Code Repository with Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/cloud-code-reposiitory.html#GUID-EF09C553-B9E7-40F7-9C83-0C131B436603)
