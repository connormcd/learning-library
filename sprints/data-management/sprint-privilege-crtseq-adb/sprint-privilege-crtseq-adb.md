# How can I handle insufficient privileges error while creating a sequence in an autonomous database?
Duration: 2 minutes

You want to create a sequence in an autonomous database and you face this error:
ORA-01031: insufficient privileges 01031. 00000 - "insufficient privileges" *Cause: An attempt was made to perform a database operation without the necessary privileges. *Action: Ask your database administrator or designated security administrator to grant you the necessary privileges.

## Resolving insuffocient privileges error

The ORA-01031 states that the logged in DB user has insufficient privileges to perform the operation. Autonomous Databases come with a predefined database role named DWROLE. This role provides the common privileges for a database developer to perform real-time analytics.

* To grant DWROLE role, connect to the database as ADMIN user using any SQL client tool. For example, connect using Oracle SQL Developer.
* As the ADMIN user grant DWROLE.

```
<copy>
GRANT DWROLE TO <your_adb_user>;
</copy>
```
**Note**: Depending on the usage requirements you may also need to grant additional individual privileges to users.

## Learn More

* [Manage User Roles and Privileges on Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/manage-users-privileges.html#GUID-63669A4D-227E-4C0F-9794-1B2BC4106725)
