# Initialize Environment

## Introduction

We will review and startup all components required to run this workshop in this lab successfully.

*Estimated Time:* 10 Minutes.

### Objectives
- Initialize the workshop environment.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- You have completed:
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup

## Task 1: Validate That Required Processes are Up and Running.
1. Now with access to your remote desktop session, proceed as indicated below to validate your environment before you start executing the subsequent labs. The following Processes should be up and running:

    - Database Listener
        - LISTENER
    - Database Server instance
        - ORCL
    - Veridata Server
    - Veridata Agent

2. On the *web browser* window on the right preloaded with *Veridata*, click on the *Username* field and select the saved credentials to login. These credentials have been saved within *web browser* and are provided below for reference

    - Username

    ```
    <copy>ggadm</copy>
    ```

    - Password

    ```
    <copy>welcome1</copy>
    ```

    ![](images/veridata-login.png " ")

3. Confirm successful login.

    ![](images/veridata-landing.png " ")

    If successful, the page above is displayed and as a result your environment is now ready.  

    You may now [proceed to the next lab](#next).

4. If you are still unable to login or the login page is not functioning after reloading from the *Workshop Links* bookmark folder, open a terminal session and proceed as indicated below to validate the services.

    - Database and Listener

    ```
    <copy>
    sudo systemctl status oracle-database
    </copy>
    ```

    ![](images/db-service-status.png " ")

    - WLS Admin Server, Veridata Server, and Veridata Agent

    ```
    <copy>
    sudo systemctl status oracle-veridata
    </copy>
    ```

    ![](images/veridata-service-status.png " ")

5. If you see questionable output(s), failure or down component(s), restart the corresponding service(s) accordingly

    - Database and Listener

    ```
    <copy>
    sudo sudo systemctl restart oracle-database
    </copy>
    ```

    - WLS Admin Server, Veridata Server, and Veridata Agent

    ```
    <copy>
    sudo sudo systemctl restart oracle-veridata
    </copy>
    ```

You may now [proceed to the next lab](#next).

## Appendix 1: Managing Startup Services

1. Database Service (Database and Listener).

    - Start

    ```
    <copy>sudo systemctl start oracle-database</copy>
    ```

    - Stop

    ```
    <copy>sudo systemctl stop oracle-database</copy>
    ```

    - Status

    ```
    <copy>sudo systemctl status oracle-database</copy>
    ```

    - Restart

    ```
    <copy>sudo systemctl restart oracle-database</copy>
    ```

2. Veridata Service (WLS Admin Server, Veridata Server, and Veridata Agent)

    - Start

    ```
    <copy>sudo systemctl start oracle-veridata</copy>
    ```

    - Stop

    ```
    <copy>sudo systemctl stop oracle-veridata</copy>
    ```

    - Status

    ```
    <copy>sudo systemctl status oracle-veridata</copy>
    ```

    - Restart

    ```
    <copy>sudo systemctl restart oracle-veridata</copy>
    ```

## Appendix 2: Login to Oracle GoldenGate Veridata Web UI Remotely

1. If for any reason you want to login from a location that is external to your remote desktop session such as your workstation/laptop, then refer to the following details

    ```
    Username: <copy>ggadm</copy>
    ```

    ```
    Password: <copy>welcome1</copy>
    ```


    ```
    URL: <copy>http://<Your Instance public_ip>:8830/veridata/login.jsf</copy>
    ```

    ![](./images/veridata-login-external.png " ")

2. Click **Login**.

*Note*: After you login, you may see a this pop-up screen about **Memory Check**. Click **Ok** or close.

You may now **proceed to the next lab**.

## Acknowledgements
* **Author** - Anuradha Chepuri, Principal UA Developer, Oracle GoldenGate User Assistance
* **Contributors** -  Nisharahmed Soneji, Sukin Varghese, Rene Fontcha
* **Last Updated By/Date** - Anuradha Chepuri, May 2022
