# How do I enable Application Continuity?
Duration: 1 minutes

## Enable Application Continuity

Enable application continuity for the TPURGENT service as the ADMIN user.
The ENABLE\_AC procedure takes three parameters: SERVICE NAME is the service name to change, FAILOVER\_RESTORE, set to LEVEL1 to select Application Continuity(AC), and REPLAY\_INITIATION\_TIMEOUT, is the replay timeout that specifies how many seconds after a request is submitted to allow that request to replay.

```
<copy>
execute DBMS_APP_CONT_ADMIN.ENABLE_AC('databaseid_tpurgent.adb.oraclecloud.com', 'LEVEL1', 600);
</copy>
```

## Learn More

* [Configure Your Service to Enable Application Continuity](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/application-continuity-configure.html#GUID-BFD31E09-1BA2-4D4B-AFBC-42D54B3E2BF0)
* [Application Continuity Fundamentals](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=801&clear=180&session=2985410566499)
