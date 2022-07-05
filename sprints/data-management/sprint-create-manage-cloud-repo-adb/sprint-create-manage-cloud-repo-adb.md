# How do I create, update, delete, and list cloud repositories?
Duration: 3 minutes

## Create and Manage a Cloud Code Repository

The DBMS\_CLOUD\_REPO management routines allow you to manage a Cloud Code Repository by creating, listing, updating, or deleting a repository.

First, obtain a Cloud Code Repository handle to provide access a repository and ensure repository initialization.

To initialize a Cloud Code Repository:

1. To create a repository:

```
<copy>
VAR repo clob
BEGIN
  DBMS_CLOUD_REPO.CREATE_REPOSITORY(
        repo => :repo,
        description => 'test repo'
  );
END;
/
</copy>
```

2. To update a repository:

```
<copy>
VAR repo clob
DEFINE repo_name='test_repo';
BEGIN
  DBMS_CLOUD_REPO.UPDATE_REPOSITORY(
        repo => :repo,
        new_name => '&repo_name' || '_new'
  );
END;
/
</copy>
```

3. To list repositories:

```
<copy>
col id format a30
col name format a10
col description format a15
select id, name, bytes, private, description from
  DBMS_CLOUD_REPO.LIST_REPOSITORIES(:repo);
</copy>
```

4. To delete a repository:

```
<copy>
VAR repo clob
BEGIN
  DBMS_CLOUD_REPO.DELETE_REPOSITORY(
        repo => :repo
  );
END;
/
</copy>
```

## Learn More

* [Using and Managing a Cloud Code Repository with Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/cloud-code-reposiitory.html#GUID-05124DBD-7474-446D-8CED-7E272EAE3584)
