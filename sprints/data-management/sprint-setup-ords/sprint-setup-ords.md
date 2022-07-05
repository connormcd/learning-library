# How can I configure ORDS for an On-Premise Oracle Database?
Duration: 10 minutes

ORDS is deployed as a WAR file. Download the file  from the [Oracle REST Data Services download page](https://docs.oracle.com/pls/topic/lookup?ctx=en/database/oracle/oracle-rest-data-services/21.3/aelig&id=OTN_downloads).
## Install and Configure ORDS

**Install ORDS in standalone mode:**

Make sure you at least have Oracle Java 8 installed in your system.

The installer gets the following information from you.
* Installation location
* Database connection details
* Password to be used for ```ORDS_PUBLIC_USER```
* Administrator username and passwords
* Tablespace details. You can accept default values
* Information related to APEX if you are using it. You can configure ORDS without using APEX too. **In this lab you will not be using APEX.**
* You can also configure additional ORDS features. Here you will go with the default which is SQL Developer Web  (Enables all features)
```
<copy>
java -jar ords.war install
</copy>
```
**Start ORDS:**

Your installation is now complete. You can start ORDS in standalone mode. You can choose either a HTTP or a  HTTPS connection. You can opt to generate a self signed certificate or choose to provide an external certificate for authorization.

ORDS schemas are validated and appropriate log files are written.
If you want to check that the ORDS installation is valid, go to the directory or folder containing the ```ords.war``` file and enter the validate command in the following format:

```
<copy>
java -jar ords.war validate [--database <dbname>]
</copy>
```

From the installation output, determine the port for http. The default value is 8080.

In a browser open the URL to access ORDS.

```
<copy>
http://localhost:8080/ords
</copy>
```

You will get a **"404 error"** here as you have not configured APEX. This is because nothing in your database has been published. The Jetty server is running and connecting to your database , but not able to publish anything. Your installation is successful.

**Note:**

When using the multitenant architecture, the recommended way is to set ```cdb.common.schema=false``` in the properties file, which will allow each PDB to run a different version of ORDS. Alternatively you can use ```cdb.common.schema=true``` in the properties file, which will mean all PDBs will have to use the same version of ORDS. Whichever option you choose, you will probably want to also use the ```db.serviceNameSuffix=.your_db_domain``` parameter to enable the pluggable mapping functionality.

## Learn More
* To learn more about Installing, Configuring & Developing REST applications See [Oracle REST Data Services](https://docs.oracle.com/en/database/oracle/oracle-rest-data-services/21.4/aelig/index.html)
