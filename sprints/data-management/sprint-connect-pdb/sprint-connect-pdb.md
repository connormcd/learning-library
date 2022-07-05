# How do I connect to a PDB?
Duration: 3 minutes

## Connect to a pluggable database (PDB)

Direct connections to pluggable databases must be made using a service. Each pluggable database automatically registers a service with the listener. This is how any application will connect to a pluggable database, as well as administrative connections.

```
SQL> -- EZCONNECT
SQL> CONN system/password@//localhost:1521/pdb1
Connected.
SQL>

SQL> -- tnsnames.ora
SQL> CONN system/password@pdb1
Connected.
SQL>
```
The connection using a TNS alias requires an entry in the "$ORACLE_HOME/network/admin/tnsnames.ora" file, such as the one shown below.

```
PDB1 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = ol6-121.localdomain)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = pdb1)
    )
  )
```


## Learn More

* [Connecting to a Pluggable Database (PDB)](https://oracle-base.com/articles/12c/multitenant-connecting-to-cdb-and-pdb-12cr1#pdb)
