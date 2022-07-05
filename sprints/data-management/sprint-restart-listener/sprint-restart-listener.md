# How do I restart the listener?
Duration: 3 minutes

## Restart the Oracle Database Listener

1. First, log in as the Oracle user.

  ```
  <copy>
  ssh -Y oracle@myserver
  </copy>
  ```

2. Use the export ORACLE_HOME variable to restart the listener. Ensure that this variable identifies (set to equal) the directory path on which you installed the Oracle database software. For example:
  ```
  <copy>
  export ORACLE_HOME=/home/oracle/app/oracle/product/<oracle-database-software-version>/dbhome_1
cd $ORACLE_HOME/bin
  </copy>
  ```

## Learn More

* [How to Start, Stop, and Check the Status of the Oracle Database Listeners](https://docs.oracle.com/cd/E97665_01/html/rpm_81_installation_12c/GUID-21D99D16-AAB3-4AF0-A942-26C78D73AB89.htm)
