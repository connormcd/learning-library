# Initialize Environment

## Introduction

This lab provides steps to review and start up all the services that are required to run this workshop.

*Estimated Time:* 10 Minutes.

### Objectives
- Initialize the workshop environment.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- You have completed:
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup

## Task 1: Validate That Required Services are Up and Running.
Now with access to your remote desktop session, validate your environment before you proceed to the subsequent labs.
1. Open the command terminal and run the command **ggsa-services**, to check the status of all the ggsa services. The following services should be up and running:

    - GoldenGate Big Data Manager
    - Apache Zookeeper Server (Kafka)
    - Apache Kafka Server (Broker)
    - MySQL Server
    - Oracle Stream Analytics
    - The nginx HTTP and reverse proxy server
    - Apache Spark Master
    - Apache Spark Slave

2. On the web browser window on the right preloaded with *GoldenGate Stream Analytics* login page, provide the credentials below to login:

    - Username

    ```
    <copy>osaadmin</copy>
    ```

    - Password

    ```
    <copy>xY3q3svdHt8=</copy>
    ```

    ![GGSA Login](./images/ggsa-login.png "")
    ![GGSA Landing](./images/ggsa-landing.png "")

    *Note:* If the browser window is not fully loaded with the login page displayed, Double click on the *Get Started with Your Workshop* icon on the upper left corner in your remote desktop to relaunch.

    ![Get Started with your Workshop](./images/get-started-icon.png "")

3. Confirm successful login. Note that it takes about 5 minutes after instance provisioning for all processes to fully start.

    - Double click *Terminal* , and execute the below command to check the status of all the services:

    ```
    <copy>
    sudo systemctl | grep 'nginx\|mysqld\|spark-master\|spark-slave\|kafka\|kafka-zookeeper\|osa\|ggbd-mgr'
    </copy>
    ```

    ![Checking the status of the GGSA services, using the command terminal](images/ggsa-terminal-status.png " ")

    If successful, the page above is displayed and your environment is ready.  

    You may now [proceed to the next lab].

4. If you are unable to login, or the login page is not functioning after reloading from the *Workshop Links* bookmark folder, validate the services:

    - Check the status of all services:

    ```
    <copy>
    sudo systemctl status | grep 'nginx\|mysqld\|spark-master\|spark-slave\|kafka\|kafka-zookeeper\|osa\|ggbd-mgr'
    </copy>
    ```

    ![Validating the GGSA services, using the command terminal](images/ggsa-terminal2.png " ")
    ![Validating the GGSA services, using the command terminal](images/ggsa-terminal3.png " ")
    ![Validating the GGSA services, using the command terminal](images/ggsa-terminal4.png " ")


5. If you see questionable output(s), failure or down component(s), restart the corresponding service(s) accordingly

    - Restart all services:

    ```
    <copy>
    sudo systemctl restart | grep 'nginx\|mysqld\|spark-master\|spark-slave\|kafka\|kafka-zookeeper\|osa\|ggbd-mgr'
    </copy>
    ```

    - Restart a particular service:

    ```
    <copy>
    sudo systemctl restart <Service-name>
    </copy>
    ```

    *Note*- The following are the service names used in this workshop

    | Service Name                    |systemctl service             |
    |:-------------                   | :----------------------------|
    | GoldenGate Big Data Manager     | ggbd-mgr.service             |
    | Apache Zookeeper Server (Kafka) | kafka-zookeeper.service      |
    | Apache Kafka Server (Broker)    | kafka.service                |
    | MySQL Server                    | mysqld.service               |
    | Oracle Stream Analytics         | osa.service                  |
    | The nginx HTTP and reverse proxy| nginx.service    |
    | Apache Spark Master             | spark-master.service         |
    | Apache Spark Slave              | spark-slave.service          |

    You may now [proceed to the next lab](#next).

## Appendix 1: Managing Startup Services

- Start

    ```
    <copy>sudo systemctl start <Service-name></copy>
    ```

- Stop

    ```
    <copy>sudo systemctl stop <Service-name></copy>
    ```

- Status

    ```
    <copy>sudo systemctl status <Service-name></copy>
    ```

- Restart

    ```
    <copy>sudo systemctl restart <Service-name></copy>
    ```

    *Note*- The following are the service names used in this workshop

    | Service Name                    |systemctl service             |
    |:-------------                   | :----------------------------|
    | GoldenGate Big Data Manager     | ggbd-mgr.service             |
    | Apache Zookeeper Server (Kafka) | kafka-zookeeper.service      |
    | Apache Kafka Server (Broker)    | kafka.service                |
    | MySQL Server                    | mysqld.service               |
    | Oracle Stream Analytics         | osa.service                  |
    | The nginx HTTP and reverse proxy| nginx.service                |
    | Apache Spark Master             | spark-master.service         |
    | Apache Spark Slave              | spark-slave.service          |

## Appendix 2: External Web Access

If for any reason you want to login from a location that is external to your remote desktop session such as your workstation/laptop, then refer to the details below.

1.  GGSA Console

    - Username

    ```
    <copy>osaadmin</copy>
    ```

    - Password

    ```
    <copy>xY3q3svdHt8=</copy>
    ```

    - URL

    ```
    <copy>https://[Instance Public_IP Address]/osa</copy>
    ```

    *Note:* Substitute *[Instance Public IP]* with the correct host's public IP address

2. You may see an error on the browser while accessing the Web Console - “*Your connection is not private*” as shown below. Ignore and add the exception to proceed.

    For Chrome browser, click on *Advanced* to expand and select *Proceed to [Instance Public IP] (unsafe)*

    ![Privacy Error](images/login-ggsa-external-1.png " ")
    ![GGSA Login](images/login-ggsa-external-2.png " ")
    ![GGSA Landing](images/login-ggsa-external-3.png " ")

## Acknowledgements
* **Author** - Pratibha Manjunath, Senior User Assistance Developer, GoldenGate Stream Analytics
* **Contributors** - Ashish Kumar, Sumathi Nelapati, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, January 2022
