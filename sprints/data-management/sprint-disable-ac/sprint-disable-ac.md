# How do I disable Application Continuity?
Duration: 1 minutes

## Disable Application Continuity

Disable application continuity for the TP service as the ADMIN user:

```
<copy>
execute DBMS_APP_CONT_ADMIN.DISABLE_FAILOVER('databaseid_tp.adb.oraclecloud.com');
</copy>
```

## Learn More

* [Configure Application Continuity on Autonomous Database](https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/application-continuity-configure.html#GUID-BFD31E09-1BA2-4D4B-AFBC-42D54B3E2BF0)
* [Application Continuity Fundamentals](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=801&clear=180&session=2985410566499)
