# How do I connect to the Database from the Internet?

Duration: 5 minutes

## Database connection from Internet

Although Oracle does not recommend connecting to your database from the Internet, you can connect to a database service by using a public IP address if port 1521 is open to the public for ingress.

To use this method, you run the following command using the public IP address instead of the hostname or SCAN in the connection string:

```
<copy> sqlplus system/< password>@< public_IP>:1521/< service_name>.< DB_domain> <copy/>

```

## Learn More
* [Connecting to a Database System] (https://docs.oracle.com/en-us/iaas/Content/Database/Tasks/connectingDB.htm)