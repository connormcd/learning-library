# How do I drop a database user?
Duration: 1 minute

## Remove Users on Autonomous Database

A database user can be dropped by the following:

1. Connect as the ADMIN user using any SQL client tool.
2. Run the following SQL statement:
```
<copy>
DROP USER user_name CASCADE;
</copy>
```

## Learn More

* [How to Create Users, Grant Them Privileges, and Remove Them in Oracle Database](https://blogs.oracle.com/sql/post/how-to-create-users-grant-them-privileges-and-remove-them-in-oracle-database)
* [Managing User Authentication and Authorization](https://docs.oracle.com/en/database/oracle/oracle-database/21/dbseg/part_1.html)
