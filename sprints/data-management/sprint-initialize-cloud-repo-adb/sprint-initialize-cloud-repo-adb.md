# How do I initialize a cloud code repository?
Duration: 5 minutes

## Initialize Cloud Code Repository

The DBMS\_CLOUD\_REPO initialization routines initialize a Cloud Code Repository. After you obtain a Cloud Code Repository handle, you use the handle to access the Cloud Code Repository.

To initialize a Cloud Code Repository:

1. Create a credential to access the Cloud Code Repository.
2. Depending on the repository, GitHub, Azure Repos, or AWS CodeCommit, call DBMS\_CLOUD\_REPO.INIT\_REPO with the parameters for the particular repository to obtain a repository handle.

The following example provide a sample for Github initialization. Please see the documentation under the 'Learn More' section to find examples of Azure Repos and AWS CodeCommit initialization.

GitHub Initialization:

```
<copy>
DEFINE repo_name='test_repo';
DEFINE cred_name='GITHUB_CRED';
VAR repo clob
BEGIN
  :repo := DBMS_CLOUD_REPO.INIT_REPO(
                params => JSON_OBJECT('provider' value 'github',
                                      'repo_name' value '&repo_name',
                                      'credential_name' value '&cred_name',
                                      'owner'           value '<myuser>')
          );
END;
/
</copy>
```

## Learn More

* [Using and Managing a Cloud Code Repository with Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/cloud-code-reposiitory.html#GUID-79C39182-C398-45B6-AD79-D406AAB63F5B)
