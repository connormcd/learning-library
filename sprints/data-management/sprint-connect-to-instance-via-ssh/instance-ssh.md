# How do I connect to a compute instance via SSH?

Duration: 5 minutes

## SSH connection 

1. Open terminal window

2.  SSH using your private SSH key and your Public IP Address. Remove brackets when writing out IP Address. 
    ```
    ssh -i < Location of Private SSH key> opc@< Your Public IP Address>
    ```

    ```
    Example: ssh -i .ssh/test opc@132.226.31.189
    ```

## Learn More
* [Oracle Database Instance] (https://docs.oracle.com/cd/E11882_01/server.112/e40540/startup.htm#CNCPT005)
* [Connecting to your Instance] (https://docs.oracle.com/en-us/iaas/Content/GSG/Tasks/testingconnection.htm)