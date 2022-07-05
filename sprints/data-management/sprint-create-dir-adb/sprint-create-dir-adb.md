# How do I create a directory in Autonomous Database?
Duration: 2 minutes

## Create Directory in Autonomous Database

To create directories use the database CREATE DIRECTORY command. Using CREATE DIRECTORY you specify the path as a relative path for the new directory.

The following example creates a database directory named staging and creates the file system directory stage:
```
<copy>
CREATE DIRECTORY staging AS 'stage';
</copy>
```

You can also create subdirectories. For example, the following command creates the database directory object sales_staging and the file system directory stage/sales:
```
<copy>
CREATE DIRECTORY sales_staging AS 'stage/sales';
</copy>
```


## Learn More

* [Creating and Managing Directories on Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/create-directory.html#GUID-4DE91325-5D60-49E8-8D82-159AAA8994D2)
