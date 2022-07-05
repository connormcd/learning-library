# How do I use file operations with a cloud code repository?
Duration: 3 minutes

## Use File Operations with a Cloud Code Repository

The DBMS\_CLOUD\_REPO file operations allow you to create, get, list, update, or delete files in a Cloud Code Repository.

First, obtain a Cloud Code Repository handle to provide access a repository and ensure repository initialization.

Here are 5 commonly used file operations:

1. To get a file:

```
<copy>
SELECT DBMS_CLOUD_REPO.GET_FILE(repo => :repo, file_path => 'test1.sql')
</copy>
```

2. To create a file:

```
<copy>
VAR repo clob
BEGIN
  DBMS_CLOUD_REPO.PUT_FILE(
        repo => :repo,
        file_path => 'test1.sql',
        contents => UTL_RAW.cast_to_raw('create table t1 (x varchar2(30))' || CHR(10) || '/')
  );
END;
/
</copy>
```

3. To update a file:

```
<copy>
VAR repo clob
BEGIN
  DBMS_CLOUD_REPO.PUT_FILE(
        repo => :repo,
        file_path => 'test1.sql',
        contents => UTL_RAW.cast_to_raw('create table t2 (x varchar2(30))' || CHR(10) || '/')
  );
END;
/
</copy>
```

4. To list files:

```
<copy>
SELECT id, name, bytes, url FROM DBMS_CLOUD_REPO.LIST_FILES(repo => :repo);
</copy>
```

5. To delete a file:

```
<copy>
VAR repo clob
BEGIN
  DBMS_CLOUD_REPO.DELETE_FILE(
        repo => :repo,
        file_path => 'test1.sql'
  );
END;
/
</copy>
```

## Learn More

* [Using and Managing a Cloud Code Repository with Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/cloud-code-reposiitory.html#GUID-4E274751-8B04-4DA3-9343-D5F94F95207E)
