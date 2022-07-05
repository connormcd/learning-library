# How do I create an Oracle user account in Oracle Linux?  
Duration: 10 minutes

OPC is the default user when creating compute instances in Oracle cloud infrastructure. Additionally, you might want to create an oracle user for specific installations. This sprint will help you create an oracle user in your Oracle Linux environment. 

## Oracle user account

**SSH into your virtual machine:**

Create a new group called oracle.

```
<copy>  
groupadd oracle 
</copy>
```

Create a new user account called oracle that belongs to the oracle group. 

```
<copy>  
useradd -m -g oracle -d /home/oracle -s /bin/bash oracle 
</copy>
```

Set the password for the oracle user account.

```
<copy>  
passwd oracle 
</copy>
```
 
## Learn More
* [Installation Guide for Oracle Fusion Middleware](https://docs.oracle.com/cd/E97665_01/html/rpm_81_installation_12c/GUID-E462932A-723A-4B10-9F28-A68AE9068901.htm )
