# Log in to Oracle EMCC

## Introduction

This lab shows how to log in to Oracle Enterprise Manager Cloud Control (Oracle EMCC) and access the home page.

*Estimated Time:* 5 minutes

### Objectives
Log in to Oracle EMCC and select a personal home page.

### Prerequisites
This lab assumes you have -
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- You have completed -
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Setup Compute Instance
    - Lab: Initialize Environment

## Task 1: Log in to Oracle EMCC
From Oracle EMCC, you can do various activities, such as view details of your Oracle Database, monitor the database, and perform administrative tasks.

1. Log in to your host as *oracle*, the user who can perform database administration.

2. Open a web browser and enter the URL for Oracle EMCC.  

    <!-- Replace 0.0.0.0 and enter the actual IP address of the host machine. -->

    [https://emcc:7803/em](https://emcc:7803/em)  

    ![Oracle EMCC Login URL](images/emcc-001-login-url.png)

    **Note:** If you get a security certificate issue, you can safely ignore the warning. Depending on your web browser, click *Advanced* or *More Information* and continue to the login page.

    > **URL Syntax**  
    > The Oracle EMCC URL comprises the host name and the port number - `https://hostname:portnumber/em`.  
    For this lab, the host name for Oracle EMCC is *emcc* or *emcc.livelabs.oraclevcn.com* and the port number is *7803*. The values may differ depending on the system you are using.

    To view your host name, open a terminal window and run the command.
    ```
    <copy>hostname</copy>
    ```

3. Enter the login credentials for Oracle EMCC.  
    **User Name** - *sysman* (not case sensitive)  
    **Password** - *welcome1*

    ![Oracle EMCC Login Page](images/emcc-002-login-page.png)

4. The first time you log in to Oracle EMCC, the web browser displays a License Agreement. Click **I Accept** to confirm your compliance and continue to log in.

    ![License Agreement](images/emcc-003-license.png)

    Henceforth, the License Agreement does not appear on subsequent logins.

5. Oracle EMCC opens and displays the default landing page, the Welcome page.

    ![Oracle EMCC Welcome page](images/emcc-004-welcome.png)

    You can select a different home page from the given options and change the default home page.  

6. Open another page, for example the Enterprise Summary page, and set it as your home page. From the **Enterprise** menu, select **Summary**.

    ![Enterprise Summary page](images/emcc-005-enterprise-menu.png)

7. On the Enterprise Summary page from the account name menu, that is from **SYSMAN**, select **Set Current Page as My Home** to set the Enterprise Summary page as your default home page.

    ![Enterprise Summary page](images/emcc-006-set-homepage.png)

    The window displays a confirmation message that you have updated your home page. Your personal home page will appear from the next login onwards.

Congratulations! You have successfully logged in to Oracle EMCC and set your home page. You can explore Oracle EMCC and perform administrative tasks for your Oracle Database.

In this lab, you have learned how to log in to Oracle EMCC from a web browser and select a personal home page.

You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Manish Garodia, Principal User Assistance Developer, Database Technologies
- **Contributors** - Suresh Rajan, Kurt Engeleiter, Prakash Jashnani, Subhash Chandra, Steven Lemme, Ashwini R
- **Last Updated By/Date** - Manish Garodia, December 2021
