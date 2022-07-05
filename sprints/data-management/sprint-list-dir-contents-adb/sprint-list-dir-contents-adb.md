# How do I list contents of directory in Autonomous Database?
Duration: 1 minutes

## List Contents of Directory in Autonomous Database

Use the function DBMS\_CLOUD.LIST\_FILES to list the contents of a directory.

For example, to list the contents of the staging directory, run the following query:
```
<copy>
SELECT * FROM DBMS_CLOUD.LIST_FILES('STAGING');
</copy>
```

## Learn More

* [Creating and Managing Directories on Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/list-directory-contents.html#GUID-852B0D98-336A-4A15-A11A-DEFF4B54E79B)
