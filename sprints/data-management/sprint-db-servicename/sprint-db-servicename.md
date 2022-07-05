# How do I get Oracle Database SERVICE_NAME? 
Duration: 10 minutes

SERVICE_NAMES specifies one or more names by which clients can connect to the instance. The instance registers its service names with the listener. When a client requests a service, the listener determines which instances offer the requested service and routes the client to the appropriate instance.  

## Get Service Name

**Login to SQL Web Developer or SQLPlus and run the following statement:**

```
<copy>
select name, value from v$parameter where name='service_names';
</copy>
```
 
## Learn More
* [Get Service Name](https://docs.oracle.com/cd/B19306_01/server.102/b14237/initparams188.htm )
