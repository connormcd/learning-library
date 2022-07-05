# Apply Oracle Database 19c New Features: Wait for In-Memory Objects to be Populated

## About this Workshop

This workshop shows you how to allow applications to take advantage of the complete population of tables into the In-Memory Column Store (IMCS).

Oracle Database 19c introduces the ```DBMS_INMEMORY_ADMIN.POPULATE_WAIT``` function, which will return a value that indicates the status of an eligible object's population.

The possible return values are:

    * 0: All in-memory segments are fully populated.
    * 1: Not all in-memory segments are fully populated due to IMCS lack of space.
    * 2: There are no segments to populate.
    * 3: The IMCS size is configured to 0.

You can write a wrapper package that invokes the function at startup. Based on the value returned, the package can start the application's services, send messages to the application tier, or even open the database if it was opened in restricted mode.

Estimated Workshop Time: 30 minutes

### Objectives

In this workshop, you will learn how to:
* Configure the IMCS and create In-Memory Tables.
* Check the status of In-Memory Table population.
* Return status codes for In-Memory Segments
* Display meaningful messages returned by the function.

### Prerequisites

This lab assumes you have:
* An Oracle account
* Oracle Database 19c installed
* A database, either non-CDB or CDB with a PDB
* The [im_tables.sh](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/im_tables.sh) shell script. Download the shell script to the labs directory created on your server ```/home/oracle/labs```
* The [inmemory_size.sql](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/inmemory_size.sql) SQL script. Download the SQL script to the labs directory created on your server ```/home/oracle/labs```.
* The [create_im_tables.sql](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/create_im_tables.sql) SQL script. Download the SQL script to the labs directory created on your server ```/home/oracle/labs```.
* The [load_im_tables.sql](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/load_im_tables.sql) SQL script. Download the SQL script to the labs directory created on your server ```/home/oracle/labs```.
* The [create_pdb1.sql](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/create_pdb1.sql) SQL script. Download the SQL script to the labs directory created on your server ```/home/oracle/labs```.
* The [create_oe_user.sql](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/create_oe_user.sql) SQL script. Download the SQL script to the labs directory created on your server ```/home/oracle/labs```.
* The [alter_oe_user.sql](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/alter_oe.sql) SQL script. Download the SQL script to the labs directory created on your server ```/home/oracle/labs```.
* The [startup.sql](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/startup.sql) SQL script. Download the SQL script to the labs directory created on your server ```/home/oracle/labs```.
* The [shutdown.sql](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/shutdown.sql) SQL script. Download the SQL script to the labs directory created on your server ```/home/oracle/labs```.
* The [control_customer.ctl](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/control_customer.ctl), [control_date.ctl](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/control_date.ctl), [control_lineorder.ctl](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/control_lineorder.ctl), [control_lineorder2.ctl](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/control_lineorder2.ctl), [control_part.ctl](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/control_part.ctl), and [control_supplier.ctl](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/control_supplier.ctl) SQL\*Loader control files. Download the control files to the labs directory created on your server ```/home/oracle/labs```.
* The [customer.tbl](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/customer.tbl), [date.tbl](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/date.tbl), [lineorder.tbl](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/lineorder.tbl), [lineorder2.tbl](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/lineorder2.tbl), [part.tbl](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/part.tbl), and [supplier.tbl](https://docs.oracle.com/en/database/oracle/oracle-database/19/tutorial-wait-inmemory-objects-population/files/supplier.tbl) SQL\*Loader control files. Download these data files to the labs directory created on your server ```/home/oracle/labs```.

## Task 1: Configure the IMCS and Create the In-Memory Tables

1. Execute the ```/home/oracle/labs/im_tables.sh``` shell script to set the IMCS size to 800 MB and create the in-memory tables: ```OE.CUSTOMER```, ```OE.LINEORDER```, ```OE.DATE```, ```OE.SUPPLIER```, and ```OE.PART```. Update the users and keystore passwords in the shell and SQL scripts as necessary.

	<code><copy>/home/oracle/labs/im_tables.sh</copy></code>

2. Verify that the IMCS is set to 800 MB.

  <code><copy>sqlplus / AS SYSDBA</copy></code>

	<code><copy>SHOW PARAMETER INMEMORY_SIZE</code>

	<pre><code>NAME                    TYPE        VALUE
 ----------------------- ----------- --------------------
 inmemory_size           big integer 800M</code></pre>										

3. Display the population stats of the in-memory tables.

 	<pre><code><copy>SELECT segment_name, bytes, inmemory_size, bytes_not_populated, populate_status
  FROM   v$im_segments; </copy>

  2
  no rows selected</code></pre></copy>

## Task 2: Wait for In-Memory Segments to be populated

1. In another session, session2, log in as ```SYSTEM``` in ```PDB1```. Execute the function to get information about the status of the population of in-memory tables at the percentage of 100.

	<pre><code><copy>sqlplus system@PDB1</copy>
Enter password: <i>password</i></pre></code>

	After some time, the code returned from the function is 1, which means that the in-memory objects are not fully populated into the In-Memory Column Store because of the lack of space in the IMCS.

2. Quit session2.

	<pre><code><copy>EXIT</pre></code></copy>

3. Verify this assumption on session1.

	<pre><code><copy>CONNECT system@PDB1</copy>
  Enter password: <i>password</i></pre></code>

	<pre><code><copy>SELECT segment_name, bytes, inmemory_size, bytes_not_populated, populate_status FROM	v$im_segments;</pre></code></copy>

	Read the result from the result1 text file.

4. In session1, increase the IMCS size to 1 GB and the SGA_TARGET to 1.5 GB.

	<pre><code><copy>CONNECT / AS SYSDBA</pre></code>

	<pre><code><copy>ALTER SYSTEM SET inmemory_size=1G SCOPE=SPFILE;</pre></code></copy>

	<pre><code><copy>ALTER SYSTEM SET sga_target=1500M SCOPE=SPFILE;</pre></code></copy>

5. Restart the instance and database.

	<pre><code><copy>SHUTDOWN IMMEDIATE</pre></code></copy>

	<pre><code><copy>STARTUP</copy></pre></code>

6. If necessary, open the CDB root keystore.

	<pre><code><copy>ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY password CONTAINER=ALL;</pre></code></copy>

7. Open the pluggable database.

	<pre><code><copy>ALTER PLUGGABLE DATABASE pdb1 OPEN;</pre></code></copy>

8. In session2, reconnect as ```SYS```. If necessary, open the PDB keystore.

	<pre><code><copy>sqlplus sys@PDB1 AS SYSDBA
Enter password: password</pre></code></copy>

	<pre><code><copy>ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY password;</pre></code></copy>

9. Execute the function that waits until in-memory tables are populated into the IMCS to the specified percentage of 100.

	<pre><code><copy>SELECT DBMS_INMEMORY_ADMIN.POPULATE_WAIT('NONE', 100, 180) POP_STATUS FROM dual;</copy>

 POP_STATUS
 ----------
            0</pre></code>

	The query does not give any result until the population of the segments is 100% complete. When the population is complete, the return code is 0. The code returned means that the all in-memory objects are fully populated into the IMCS. You can therefore allow your application to query the tables, because you know that the tables queried are fully populated into the IMCS. A wrapper package invoking the function at instance startup would be beneficial.

10. Observe the population progress in session1.

	<pre><code><copy>SELECT segment_name, bytes, inmemory_size, bytes_not_populated, populate_status FROM   v$im_segments;
	</pre></code></copy>

	Read the result from the result2 text file.

## Task 3: Wait for In-Memory Segments to be Populated with Other Return Codes

1. In session2, execute the ```/home/oracle/labs/alter_oe.sql``` SQL script that modifies the in-memory attribute of the ```OE``` tables.

	<pre><code><copy>@/home/oracle/labs/alter_oe.sql</pre></code></copy>

2. Quit session2.

	<pre><code><copy>EXIT</pre></code></copy>

3. In session1, restart ```PDB1``` so that ```OE``` tables are no longer populated into the IMCS.

	<pre><code><copy>ALTER PLUGGABLE DATABASE pdb1 CLOSE;</pre></code></copy>

	<pre><code><copy>ALTER PLUGGABLE DATABASE pdb1 OPEN;</pre></code></copy>

4. In session2, reconnect as ```SYS```, and if necessary, open the PDB keystore.

	<pre><code><copy>sqlplus sys@PDB1 AS SYSDBA
	Enter password: -password-</pre></code></copy>

	<pre><code><copy>ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY password;</pre></code></copy>

	Then execute the function that waits until in-memory tables are populated into the IMCS to the specified percentage of 100 and a timeout set to one minute.

	<pre><code><copy>SELECT DBMS_INMEMORY_ADMIN.POPULATE_WAIT('NONE', 100, 60) POP_STATUS FROM dual;</copy>

 POP_STATUS
 ----------
	        2</pre></code>

5. Observe the population progress in session1.

	<pre><code><copy>SELECT segment_name, bytes, inmemory_size, bytes_not_populated, populate_status
FROM   v$im_segments;</copy>
 	2
no rows selected</pre></code>

## Task 4: Display Meaningful Messages Returned by the Function

1. In session1, execute the function after setting output to ```ON```.

	<pre><code><copy>SET SERVEROUTPUT ON</pre></code></copy>

	<pre><code>SELECT DBMS_INMEMORY_ADMIN.POPULATE_WAIT('NONE', 100, 60) POP_STATUS FROM dual;</pre></code></copy>

	Read the result from the results3 text file. The message is more meaningful than the return code error.

2. In session2, update the priority NONE to HIGH for two of the in-memory tables.

	<pre><code><copy>ALTER TABLE oe.lineorder INMEMORY PRIORITY HIGH;</pre></code></copy>

	<pre><code><copy>ALTER TABLE oe.date_dim INMEMORY PRIORITY HIGH;</pre></code></copy>

3. Quit session2.

	<pre><code><copy>EXIT</pre></code></copy>

4. In session1, restart PDB1.

	<pre><code><copy>ALTER PLUGGABLE DATABASE pdb1 CLOSE;</pre></code></copy>

	<pre><code><copy>ALTER PLUGGABLE DATABASE pdb1 OPEN;</pre></code></copy>

5. In session2, reconnect as SYS and if necessary, open the PDB keystore.

	<pre><code><copy>sqlplus sys@PDB1 AS SYSDBA</copy>
Enter password: password</pre></code>

	<pre><code>ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY password;</pre></code></copy>

	Then execute the function that waits until in-memory tables are populated into the IMCS to the specified percentage of 100 and a timeout set to one minute.

	<pre><code><copy>SET SERVEROUTPUT ON;</pre></code></copy>

	<pre><code><copy>SELECT DBMS_INMEMORY_ADMIN.POPULATE_WAIT('HIGH', 100, 60) POP_STATUS FROM dual;</pre></code></copy>

	Read the result from the result4 text file. The message is more meaningful than the return code error.

6. Quit session2.

	<pre><code><copy>EXIT</pre></code></copy>

## Task 5: Clean up the Environment

1. In session1, reset the IMCS size to 0.

 <pre><code><copy>ALTER SYSTEM SET inmemory_size=0 SCOPE=SPFILE;</pre></code>

2. Restart the database instance.

 <pre><code><copy>SHUTDOWN</pre></code></copy>

 <pre><code><copy>STARTUP</pre></code></copy>

3. If necessary, open up the CDB root keystore.

 <pre><code><copy>ADMINISTER KEY MANAGEMENT SET KEYSTORE OPEN IDENTIFIED BY password CONTAINER=ALL;</pre></code></copy>

4. Open ```PDB1```.

 <pre><code><copy>ALTER PLUGGABLE DATABASE pdb1 OPEN;</pre></code></copy>

5. Verify the return status of the function after the cleanup completed.

 <pre><code><copy>SET SERVEROUTPUT ON</pre></code></copy>

 <pre><code>SELECT DBMS_INMEMORY_ADMIN.POPULATE_WAIT('HIGH', 100, 60)
 POP_STATUS FROM dual;

 POP_STATUS
 ----------
            3

 POPULATE ERROR, INMEMORY_SIZE=0</pre></code></copy>

 The message is more meaningful than the return code error 3.

6. Connect to PDB1 as SYS, and if necessary, open the PDB keystore.

 <pre><code><copy>CONNECT sys@PDB1 AS SYSDBA</copy>
 Enter password: password</pre></code>

7. Drop the ```OE``` schema.

 <pre><code><copy>DROP USER oe CASCADE;</pre></code></copy>

8. Quit session1.

 <pre><code><copy>EXIT</pre></code></copy>

 **You may now proceed to the next lab**

## Acknowledgements
* **Author** - Andrew Selius, Solution Engineer, Oracle Santa Monica Hub
* **Last Updated By/Date** - Andrew Selius, January 6, 2021
