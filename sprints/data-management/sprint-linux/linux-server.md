# How do I connect to a PDB from a CDB?

Duration: 5 minutes

## Connect to different Oracle Databases

If you use an Oracle container database, you can login to the database using the steps that are below:

1. login to the database via SQL*Plus

    ```
    <copy> show pdbs; <copy/>
    ```

2. alter session set container to 

    ```
    <copy> container_db_name; <copy/>
    ```

## Learn More
* [Oracle Linux] (https://www.oracle.com/linux/)
* [Connecting to the Database] (https://docs.oracle.com/cd/E17781_01/server.112/e18804/connecting.htm#ADMQS127)