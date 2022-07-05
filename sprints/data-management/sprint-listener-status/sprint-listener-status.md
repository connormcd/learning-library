# How do I check the listener status?
Duration: 2 minutes

## Check the Status of the Oracle Database Listeners

1. First, log in as the Oracle user.

  ```
  <copy>
  ssh -Y oracle@myserver
  </copy>
  ```

2. Then, to check the status of the listener, use the following command:
  ```
  <copy>
  ./lsnrctl status
  </copy>
  ```

## Learn More

* [How to Start, Stop, and Check the Status of the Oracle Database Listeners](https://docs.oracle.com/cd/E97665_01/html/rpm_81_installation_12c/GUID-21D99D16-AAB3-4AF0-A942-26C78D73AB89.htm)
