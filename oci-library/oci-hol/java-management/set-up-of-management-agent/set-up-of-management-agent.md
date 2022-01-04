# Set Up of Management Agent

## Introduction

This lab walks you through the steps to install a management agent on your compute instance host and set up tags for the agent and compute instance to allow Java usage tracking by the Java Management Service (JMS).

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

* Configure a response file
* Install a management agent on a Linux / Windows compute instance host
* Verify management agent
* Configure Java Usage Tracker
* Tag Management Agent and Compute Instance
* Monitor the Java runtime(s) and Java application(s) in JMS

### Prerequisites

* You have signed up for an account with Oracle Cloud Infrastructure and have received your sign-in credentials.
* You are using an Oracle Linux image on your host machine or compute instance for this workshop.
* Access to the cloud environment and resources configured in Lab 2

## Task 1: Transfer of files to Compute Instance

1. The last line in the response file `Service.plugin.jms.download=true` will download and enable the JMS plugin

  ![image of input rsp file](/../images/input-rsp-updated.png)

2. Open up a **Terminal** or **Command Prompt** window in the local machine where the install key and management agent software file is saved

3. Enter the following command to transfer the install key and management agent software file via scp into the remote host compute instance
    ```
    <copy>
    scp <full_path_of_file_to_be_transfered_on_local_host> opc@<public_IP_Address>:<full_path_of_remote_directory_transferred_to>
    </copy>
    ```

## Task 2: Install Management Agent

Install Management Agent (If your host is Windows, skip to **For Windows** Section)

### For Linux

1. Login as a user with `sudo` privileges.

2. Navigate to the directory where you have downloaded the management agent software RPM file and run the following command to install the `RPM` file:
    ```
    <copy>
    sudo rpm -ivh <rpm_file_name.rpm>
    </copy>
    ```

  For example: `sudo rpm -ivh oracle.mgmt_agent-<VERSION>.rpm`

3. The output will look similar to the following:

    ```
    Preparing... ################################# [100%]

    Checking pre-requisites

    Checking if any previous agent service exists
      Checking if OS has systemd or initd
      Checking available disk space for agent install
      Checking if /opt/oracle/mgmt_agent directory exists
      Checking if 'mgmt_agent' user exists
      'mgmt_agent' user already exists, the agent will proceed installation without creating a new one.
      Checking Java version
      JAVA_HOME is not set. Trying default path
      Java version: 1.8.0_231 found at /usr/bin/java

    Updating / installing...
        1:oracle.mgmt_agent-<VERSION>202################################# [100%]

    Executing install
      Unpacking software zip
      Copying files to destination dir (/opt/oracle/mgmt_agent)
      Initializing software from template
      Creating 'mgmt_agent' daemon
      Agent Install Logs: /opt/oracle/mgmt_agent/installer-logs/installer-log-0
      Setup agent using input response file (run as any user with 'sudo' privileges)
      Usage:sudo
      /opt/oracle/mgmt_agent/agent_inst/bin/setup.sh opts=[RESPONSE_FILE]
    Agent install successful
    ```

4. The agent installation process does the following:
* A new user called `mgmt_agent` is created. This will be the management agent user. If `mgmt_agent` user already exists, the agent installation process will use it to install the agent software.

* When `mgmt_agent` daemon is created, the hard and soft nofile ulimit are set to 5000.

* All agent files are copied and installed by mgmt_agent user. The agent install base directory is the directory where the agent is installed. The directory is created as part of the agent installation process under `/opt/oracle/mgmt_agent` directory.
  By default, the `mgmt_agent` service is enabled and started automatically after the agent installation.
<!--  -->

5. Configure the management agent by running the `setup.sh` script using a response file.
    ```
    <copy>
    sudo /opt/oracle/mgmt_agent/agent_inst/bin/setup.sh opts=<full_path_of_response_file>
    </copy>
    ```
    Sample output:
    ```
    sudo /opt/oracle/mgmt_agent/agent_inst/bin/setup.sh opts=<user_home_directory>/input.rsp
      Executing configure
      Generating communication wallet
      Parsing input response file
      Validating install key
      Generating security artifacts
      Registering management agent
      Configuration Logs: /opt/oracle/mgmt_agent/configure-logs
      Agent configuration successful

      Starting agent...
      Agent started successfully
      In future agent can be started by directly running: sudo systemctl start mgmt_agent
      Please make sure that you delete input.rsp or store it in a secure location.
    ```
  **Skip to the next section Task 3** if the Management Agent has been **successfully** installed on a Linux host.

  If you would like to install the Management software agent on Windows, continue with the following section **For Windows**.

### For Windows

1. To install the management agent software on Windows, perform the following steps:

2. Extract the management agent software.

3. Navigate to the directory where you have downloaded the management agent software `ZIP` file and unzip it to any preferred location.

4. Login as an Administrator user and open a Command Prompt window. To install a management agent on **Windows 10**, you must first create a system environment variable `OVERRIDE_VERSION_CHECK` with value `true`.

5. Install and configure the management agent by running the `install.bat` script using a response file.

    ```
    <copy>
    installer.bat <full_path_of_response_file>
    </copy>
    ```

6. The output will look similar to the following:

    ```
    C:\Users\test_agent>installer.bat C:\Users\input.rsp
    Checking pre-requisites

          Checking if previous agent service exists
          Checking if C:\Oracle\mgmt_agent\agent_inst directory exists
          Checking if C:\Oracle\mgmt_agent\200820.0751 directory exists
          Checking available disk space for agent install
          Checking Java version
                  Java version: 1.8.0_261 found at C:\Program Files\Java\jdk1.8.0_261

    Executing install
          Unpacking software zip
          Copying files to destination dir (C:\Oracle\mgmt_agent)
          Initializing software from template
          Creating mgmt_agent service

    Agent install successful

    Executing configure

          Parsing input response file
          Generating communication wallet
          Validating install key
          Generating security artifacts
          Registering Management Agent

    The mgmt_agent service is starting....
    The mgmt_agent service was started successfully.

    Agent setup completed and the agent is running
    In the future agent can be started by directly running: NET START mgmt_agent
    Please make sure that you delete C:\Users\input.rsp or store it in secure location.
    ```

7. The agent installation process does the following:

* A new directory is created as part of the agent installation process: `C:\Oracle\mgmt_agent`.
* The agent install base directory is the directory where the agent will be installed. By default, the agent is installed under `C:\Oracle directory`. This default directory can be changed by setting the `AGENT_INSTALL_BASEDIR` environment variable before running the `install.bat` script.
* Log files from the agent installation are located under `C:\Oracle\mgmt_agent\installer-logs` directory.

## Task 3: Verify Management Agent Installation

1. In the Oracle Cloud Console, open the navigation menu, click **Observability & Management**, and then click **Agents** under **Management Agent**.

  ![image of console navigation to access management agent overview](/../images/management-agent-overview.png)

2. From the Agents list, look for the agent that was recently installed.

  ![image of management agent list](/../images/management-agent-list.png)

## Task 4: Configure Java Usage Tracker

### For Linux:

1. Execute the following commands:
    ```
    <copy>
    VERSION=$(sudo ls /opt/oracle/mgmt_agent/agent_inst/config/destinations/OCI/services/jms/)
    </copy>
    ```
    ```
    <copy>
    sudo bash /opt/oracle/mgmt_agent/agent_inst/config/destinations/OCI/services/jms/"${VERSION}"/scripts/setup.sh
    </copy>
    ```

2. This script creates the file `/etc/oracle/java/usagetracker.properties` with appropriate permissions. By default, the file contains the following lines:
    ```
    com.oracle.usagetracker.logToFile = /var/log/java/usagetracker.log
    com.oracle.usagetracker.additionalProperties = java.runtime.name
    ```

### For Windows:

1. Open a command prompt as an administrator, and run the following commands.
    ```
    <copy>
    dir /b C:\Oracle\mgmt_agent\agent_inst\config\destinations\OCI\services\jms >%TEMP%\version.txt
    set /p VERSION=<%TEMP%\version.txt
    powershell -ep Bypass C:\Oracle\mgmt_agent\agent_inst\config\destinations\OCI\services\jms\%VERSION%\scripts\setup.ps1
    </copy>
    ```

2. This script creates the file `C:\Program Files\Java\conf\usagetracker.properties` with appropriate permissions. By default, the file contains the following lines:

    ```
    com.oracle.usagetracker.logToFile = C:\ProgramData\Oracle\Java\usagetracker.log
    com.oracle.usagetracker.additionalProperties = java.runtime.name
    ```
3. If successful, you should see a message similar to:
    ```
    [C:\ProgramData\Oracle\Java\] folder has been created.
    [C:\ProgramData\Oracle\Java\usagetracker.log] file has been created.
    [C:\ProgramData\Oracle\Java\usagetracker.log] permissions has been set.
    [C:\Program Files\Java\conf\] folder has been created.
    ```
## Task 5: Check that management agent is tagged with the Fleet OCID

1. In the Oracle Cloud Console, open the navigation menu and click **Observability & Management**, and then click **Java Management**.

  ![image of console navigation to java management service](/../images/console-navigation-jms.png)

  * Select the Fleet created in Lab 3.

  ![image of fleet page](/../images/check-fleet-ocid-page.png)

  * Take note of the fleet ocid for steps 2-4.

  ![image of fleet ocid](/../images/check-fleet-ocid.png)
<!--  -->

2. In the Oracle Cloud Console, open the navigation menu and click **Observability & Management**, and then click **Agents**.
  ![image of console navigation to management agents](/../images/console-navigation-agents.png)

3. Select the compartment that the management agent is contained in.

  ![image of agents main page](/../images/agents-main-page-new.png)

4. Select the management agent to view more details

5. Under **Tags**, the `jms` tag will be indicated to show that the management agent is linked to that fleet. The fleet ocid under the jms tag should be the same fleet ocid noted in step 1.

  ![image of agents details page](/../images/tagged-mgmt-agent.png)

6. JMS has been linked to the management agent and will collect information on your Java runtimes. As the management agent will scan the instance periodically, the information may not appear immediately. To change the frequency, see steps 9 to 11.

7. In the Oracle Cloud Console, open the navigation menu and click **Observability & Management**. Click **Java Management**.

  ![image of console navigation to java management](/../images/console-navigation-java-management.png)

8. Select the compartment that the fleet is in and click the fleet.

9. Click on **Modify Agent Settings**.

  ![image of fleet details page](/../images/fleet-details-page-new.png)

10. Change the **Java Runtime Discovery** and **Java Runtime Usage** to the desired value.

  ![image of modify agent settings page](/../images/fleet-modify-agent-settings-new.png)

11. If tagging and installation of management agents is successful, Java Runtimes will be indicated on the Fleet Main Page.

  ![image of successful installation](/../images/successful-installation.png)

## Troubleshoot Management Agent Installation Issues

**For Task 2**

* Ensure that /usr/share folder has write permissions
* Uninstall and reinstall the management agent after permissions for the /usr/share folder have been updated

**For Task 3**

* Transfer the response file to /tmp folder where read permissions are allowed

## Want to Learn More?

* Refer to the [Installation of Management Agents](https://docs.oracle.com/en-us/iaas/management-agents/doc/install-management-agent-chapter.html) and
[JMS Plugin for Management Agents](https://docs.oracle.com/en-us/iaas/jms/doc/installing-management-agent-java-management-service.html) sections of the JMS documentation for more details.

* Use the [Troubleshooting](https://docs.oracle.com/en-us/iaas/jms/doc/troubleshooting.html#GUID-2D613C72-10F3-4905-A306-4F2673FB1CD3) chapter for explanations on how to diagnose and resolve common problems encountered when installing or using Java Management Service.

* If the problem still persists or if the problem you are facing is not listed, please refer to the [Getting Help and Contacting Support](https://docs.oracle.com/en-us/iaas/Content/GSG/Tasks/contactingsupport.htm) section or you may open a a support service request using the **Help** menu in the OCI console.

## Acknowledgements

* **Author** - Esther Neoh, Java Management Service
* **Last Updated By** - Esther Neoh, November 2021
