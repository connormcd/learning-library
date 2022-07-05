# How can I grant common privileges to individual database users?
Duration: 2 minute

## Granting privilges

You can grant common privileges to a database user using the following commands:

1. Allow user to connect to database:

    ```
    <copy>
    grant create session to <username>;
    </copy>
    ```

2. Allow user to create a table:

    ```
    <copy>
    grant create table to <username>;
    </copy>
    ```

3. Give user tablespace quota:

    ```
    <copy>
    alter user <username> quota unlimited on users;
    </copy>
    ```

Please note: There are a lot more options when it comes to granting privileges and one should always apply the [Principle of the least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege).



## Learn More

* [How to Create Users, Grant Them Privileges, and Remove Them in Oracle Database](https://blogs.oracle.com/sql/post/how-to-create-users-grant-them-privileges-and-remove-them-in-oracle-database)
* [Managing User Authentication and Authorization](https://docs.oracle.com/en/database/oracle/oracle-database/21/dbseg/part_1.html)



