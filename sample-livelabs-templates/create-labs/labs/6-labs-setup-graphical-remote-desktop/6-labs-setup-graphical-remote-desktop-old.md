# Setup Graphical Remote Desktop

## Introduction
This lab shows you how to deploy and configure noVNC Graphical Remote Desktop on an Oracle Enterprise Linux (OEL) instance prior to capturing the custom image.

### Objectives
- Deploy NoVNC Remote Desktop
- Configure Desktop
- Add Applications Shortcuts to Desktop
- Configure remote clipboard
- Optimize Browser Settings
- Enable VNC password reset

### Prerequisites
This lab assumes you have:
- An Oracle Enterprise Linux 7 (OEL) that meets requirement for marketplace publishing

## Task 1: Deploy noVNC
1.  As root, download and run the latest setup script. You will be prompted for the following input:

    - The *OS user* for which the remote desktop will be configured. *Default: Oracle*

    ```
    <copy>
    sudo su - || (sudo sed -i -e 's|root:x:0:0:root:/root:.*$|root:x:0:0:root:/root:/bin/bash|g' /etc/passwd && sudo su -)

    </copy>
    ```

    ```
    <copy>
    cd /tmp
    rm -rf setup-novnc-livelabs*
    wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/Nx05fQvoLmaWOPXEMT_atsi0G7Y2lHAlI7W0k5fEijsa-36DcucQwPUn6xR2OIH8/n/natdsecurity/b/misc/o/setup-novnc-livelabs.zip
    unzip -o setup-novnc-livelabs.zip
    chmod +x setup-novnc-livelabs.sh
    ./setup-novnc-livelabs.sh

    </copy>
    ```
2. After validating successful setup from URL displayed by above script, remove all setup scripts from "*/tmp*"

    ```
    <copy>
    rm -rf /tmp/novnc-*.sh
    rm -rf /tmp/set-os-user.sh
    rm -rf /tmp/setup-novnc-livelabs*

    </copy>
    ```

## Task 2: Add Applications to Desktop   
For ease of access to desktop applications provided on the instance and needed to perform the labs, follow the steps below to add shortcuts to the desktop. In the example below, we will be adding a shortcut called *Get Started with your Workshop* for launching the workshop guide and webapps if any.

1. Launch your browser to the following URL to access the remote desktop

    ```
    <copy>http://[your instance public-ip address]:6080/vnc.html?password=LiveLabs.Rocks_99&resize=scale&quality=9&autoconnect=true</copy>
    ```

2. On the remote desktop, click on *Home > Other Locations*, then navigate to *`/usr/share/applications`* and scroll-down to find *Get Started with your Workshop*

    ![](./images/create-shortcut-1.png " ")

3. Right-click on *Get Started with your Workshop* and select *Copy to...*

    ![](./images/create-shortcut-2.png " ")

4. Navigate to *Home > Desktop* and Click on *Select*

    ![](./images/create-shortcut-3.png " ")

5. Double-click on the newly added icon on the desktop and click on *Trust and Launch*

    ![](./images/create-shortcut-4.png " ")
    ![](./images/create-shortcut-5.png " ")

6. Repeat steps [2-5] to add the *Terminal* utility, *Google Chrome* browser, and any required Application the workshop may need to the Desktop (e.g. JDeveloper, SQL Developer, etc...)

    ![](./images/create-shortcut-6.png " ")

## Task 3: Optimize Terminal Utility
Perform the following to optimize the *Terminal* utility

1. Double-click on the *Terminal* icon to launch a session, then Click on *Edit* and select *Preferences*

    ![](./images/novnc-terminal-1.png " ")

2. Select the *Colors* tab, uncheck *Use colors from system theme*, Select *White on black* from *Built-in schemes* drop-down

    ![](./images/novnc-terminal-2.png " ")

3. Select the *Command* tab, check *Run command as a login shell*, and click *close*

    ![](./images/novnc-terminal-3.png " ")

4. Review *$HOME/.bash_profile* and move any custom entry of type alias, script call, or function to  *$HOME/.bashrc*. If these are referencing environment variables set in the file, then copy those over to *$HOME/.bashrc* as well.

    *Notes:* Do not remote the following default entry from *$HOME/.bash_profile*

    ```
    # Get the aliases and functions
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
    ```

## Task 4: Configure Desktop   
LiveLabs compute instance are password-less and only accessible optionally via SSH keys. As result it's important to adjust session settings to ensure a better user experience.

1. Follow steps in the screenshot below and run command provided below to resize desktop icons

    ```
    <copy>
    gsettings set org.gnome.nautilus.icon-view default-zoom-level small
    </copy>
    ```

    ![](./images/novnc-resize-desktop-icons-1.png " ")

2. Right-click anywhere on the desktop and select *Organize Desktop by Name*

    ![](./images/novnc-resize-desktop-icons-2.png " ")

3. Navigate to "*Applications >> System Tools >> Settings*"

    ![](./images/system-settings.png " ")

4. Click on "*Privacy*" and set **Screen Lock** to *Off*

    ![](./images/privacy-screen-lock.png " ")

5. Click on "*Power*" and set **Blank Screen** under Power Saving to *Never*

    ![](./images/power-saving-off.png " ")

6. Click on "*Notifications*" and set **Notifications Popups**, **Lock Screen Notifications**, and **Automatic Bug Reporting Tool** to *Off*

    ![](./images/desktop-notifications-off-1.png " ")
    ![](./images/desktop-notifications-off-1.png " ")

7. Scroll-down, Click on "*Devices >> Resolution*" and select **1920 x 1080 (16:9)**

    ![](./images/desktop-display-1.png " ")
    ![](./images/desktop-display-2.png " ")

8. From the same Terminal window, run the following command to open *Startup Programs* configuration.

    ```
    <copy>
    gnome-session-properties
    </copy>
    ```

9. Fill in the details as shown below and click *Add* to add *Get Started with your Workshop* to the list of applications to be started automatically on *VNC* Startup

    - Name

    ```
    <copy>Get Started with your Workshop</copy>
    ```

    - Command

    ```
    <copy>/usr/local/bin/livelabs-get_started.sh</copy>
    ```

    - Comment

    ```
    <copy>Launch Workshop Guide and WebApps</copy>
    ```

    ![](./images/novnc-startup-prog-1.png " ")

10. Restart *vncserver* to test.

    ```
    <copy>sudo systemctl restart vncserver_$(whoami)@\:1</copy>

    ```

    ![](./images/novnc-startup-prog-2.png " ")

11. Click *Connect* to get back into the remote desktop

    ![](./images/novnc-startup-prog-3.png " ")

    *Notes:* Don't worry if the browser window(s) is(are) not loaded as expected on VNC startup at the moment. The required instance metadata is not yet present on the host but will be injected at provisioning to cover the following.

    - `DESKTOP_GUIDE_URL` - *required*
    - `DESKTOP_APP1_URL` - optional
    - `DESKTOP_APP2_URL` - optional

    The following is an example from the *GoldenGate Veridata* workshop

    ![](./images/novnc-startup-prog-4.png " ")

12. If there are no WebApps used in the workshop, configure *Startup Programs* for another application such as *SQL Developer* to open up on the right next to the workshop guide on *VNC* startup

    ![](./images/novnc-startup-prog-5.png " ")
    ![](./images/novnc-startup-prog-6.png " ")

## Task 5: Optimize Chrome Browser
Perform the following to further customize and optimize *Google Chrome* Browser.

1. Close any running *Google Chrome* browser session running on the remote desktop

2. Launch *Terminal* utility and run the following to customize *Google Chrome* Launch Command

    ```
    <copy>
    sed -i "s|^Exec=/usr/bin/google-chrome-stable|Exec=/usr/bin/google-chrome --password-store=basic --user-data-dir="${HOME}/.livelabs/chrome-window2" --disable-session-crashed-bubble|g" $HOME/Desktop/google-chrome.desktop
    </copy>
    ```

3. Double-click on *Google Chrome* browser icon to launch and click on *Trust and Launch*

    ![](./images/novnc-custom-chrome-0.png " ")

4. Keep *Make Google Chrome the default browser* checked, uncheck *Automatic Usage Statistics & Crash reporting* and click *OK*

    ![](./images/novnc-custom-chrome-1.png " ")

5. Click on *Get Started*, on the next 3 pages click on *Skip*, and finally on *No Thanks*.

    ![](./images/novnc-custom-chrome-3.png " ")
    ![](./images/novnc-custom-chrome-4.png " ")
    ![](./images/novnc-custom-chrome-5.png " ")
    ![](./images/novnc-custom-chrome-6.png " ")

6. Click in the *Three dots* at the top right, then select *"Bookmarks >> Show bookmarks bar"*

    ![](./images/add-bookmarks-01.png " ")

7. Right-click anywhere in the *Bookmarks bar area*, then Uncheck *Show apps shortcuts* and *Show reading list*

    ![](./images/add-bookmarks-04.png " ")

8. Right-click anywhere in the *Bookmarks bar area* and select *Add page*

    ![](./images/add-bookmarks-02.png " ")

9. Provide the following two inputs, select *Bookmark bar* for destination, and click *Save* to create a bookmark to *LiveLabs*

    - Name

    ```
    <copy>Oracle LiveLabs</copy>
    ```

    - URL

    ```
    <copy>http://bit.ly/golivelabs</copy>
    ```

    ![](./images/add-bookmarks-03.png " ")

10. Click on the newly added bookmark to confirm successful page loading.

    ![](./images/add-bookmarks-05.png " ")

11. Click in the *Three dots* at the top right, then select *Settings*

    ![](./images/add-bookmarks-06.png " ")

12. Scroll down to *On Startup* section, select *open a specific page or set of pages*, and select *Use current pages* or simply add the *LiveLabs* address you set earlier as bookmark.

    ![](./images/add-bookmarks-07.png " ")

13. Run the following from terminal session to initialize LiveLabs browser windows.

    ```
    <copy>
    $HOME/.livelabs/init_ll_windows.sh
    </copy>
    ```
14. If the *desktop_app1_url* and/or *desktop_app2_url* are applicable to the workshop, test with *chrome-window2* chrome profile to validate before proceeding to custom image creation.

    e.g. The example below is from the *DB Security - Key Vault* workshop

    ```
    <copy>
    user_data_dir_base="/home/$(whoami)/.livelabs"
    desktop_app1_url="https://kv"
    desktop_app2_url="https://dbsec-lab:7803/em"
    google-chrome --password-store=basic ${desktop_app1_url} --window-position=1010,50 --window-size=887,950 --user-data-dir="${user_data_dir_base}/chrome-window2" --disable-session-crashed-bubble >/dev/null 2>&1 &
    google-chrome --password-store=basic ${desktop_app2_url} --window-position=1010,50 --window-size=887,950 --user-data-dir="${user_data_dir_base}/chrome-window2" --disable-session-crashed-bubble >/dev/null 2>&1 &
    </copy>
    ```

15. Update *vncserver* startup script to add dependency(ies) on primary service(s) supporting Web Apps behind *desktop_app1_url* and/or *desktop_app2_url*. This will prevent premature web browser startup leading to *404-page-not-found-error* when the app requested is not yet ready.

    - Edit `/etc/systemd/system/vncserver_${appuser}@\:1.service` and append the dependent service(s) at the end of the starting with **After=**

    e.g. The example below is from the *EM Fundamentals* workshop, please substitute *oracle-emcc.service* in the block below with the correct service name relevant to your workshop before running it.

    ```
    <copy>
    sudo sed -i "/^After=/ s/$/ oracle-emcc.service/" /etc/systemd/system/vncserver_$(whoami)@\:1.service
    sudo systemctl daemon-reload
    cat /etc/systemd/system/vncserver_$(whoami)@\:1.service |grep After
    </copy>
    ```

    ![](./images/add-bookmarks-08.png " ")

    - Verify the output as shown above and confirm that the service dependency has been successfully added

16. Close all browser windows opened.

You may now [proceed to the next lab](#next).

## Appendix 1: Enable VNC Password Reset, and Workshop Guide and WebApps URLs injection for each instance provisioned from the image
Actions provided in this Appendix are not meant to be performed on the image. They are rather intended as guidance for workshop developers writing terraform scripts to provision instances from an image configured as prescribed in this guide.

Update your Terraform/ORM stack with the tasks below to enable VNC password reset and add workshop URLs for each VM provisioned from the image.

1. Add provider *random* to *main.tf* or and any other *TF* file in your configuration if you not using *main.tf*

    ```
    <copy>
    terraform {
      required_version = "~> 0.13.0"
    }

    provider "oci" {
      tenancy_ocid = var.tenancy_ocid
      region       = var.region
    }

    provider "random" {}
    </copy>
    ```
2. Add the following variables to *variables.tf* and *schema.yaml*.

    - `desktop_guide_url`
    - `desktop_app1_url`
    - `desktop_app2_url`

    The example below is from the *DB Security - Key Vault* workshop

    - variables.tf

    ```
    <copy>
    variable "desktop_guide_url" {
      default = "https://oracle.github.io/learning-library/security-library/database/advanced/workshops/main-key-vault"
    }

    variable "desktop_app1_url" {
      default = "https://kv"
    }

    variable "desktop_app2_url" {
      default = "https://dbsec-lab:7803/em"
    }
    </copy>
    ```

    - schema.yaml

    ```
    variableGroups:
      - title: General Configuration
        visible: false
        variables:
        - desktop_guide_url
        - desktop_app1_url
        - desktop_app2_url

    desktop_guide_url:
      type: text
      required: true
      title: "Workshop Guide"
      description: "Workshop Guide on noVNC Desktop"

    desktop_app1_url:
      type: text
      required: false
      title: "Application URL 1"
      description: "Application URL 1 on noVNC Desktop"

    desktop_app2_url:
      type: text
      required: false
      title: "Application URL 2"
      description: "Application URL 2 on noVNC Desktop"
      </copy>
      ```

3. Add a *random* resource in your *instance.tf* or any *TF* of your choice to generate a 10 characters random password with a mix of Number/Uppercase/Lowercase characters.

    ```
    <copy>
    resource "random_string" "vncpwd" {
      length  = 10
      upper   = true
      lower   = true
      number  = true
      special = false
    }
    </copy>
    ```

4. Add *`random_string`* result and the URL variables to the metadata property for resource *`oci_core_instance`*. This will store the random value generated above as part of the instance metadata and used on first boot to reset VNC Password. The URLs will be used to preload the workshop guide and webapps on the remote desktop on VNC startup

    ```
    <copy>
    metadata = {
      vncpwd            = random_string.vncpwd.result
      desktop_guide_url = var.desktop_guide_url
      desktop_app1_url  = var.desktop_app1_url
      desktop_app2_url  = var.desktop_app2_url
    }
    </copy>
    ```

5. Add the entry *`remote_desktop`* to your *output.tf* to provide the single-click URL for remote desktop access with auto resizable window and auto-login. Replace [instance-name] from the snippet below with your real instance name as provided the resource *`oci_core_instance`* block of *instance.tf*

    ```
    <copy>
    output "remote_desktop" {
      value = format("http://%s%s%s%s",
        oci_core_instance.[instance-name].public_ip,
        ":6080/index.html?password=",
        random_string.vncpwd.result,
        "&resize=scale&autoconnect=true&quality=9&reconnect=true"
      )
    }
    </copy>
    ```
6. Add output entry *`remote_desktop`* to your *schema.yaml* file

    ```
    <copy>
    outputGroups:
      - title: Resources Access Information
        outputs:
          - ${remote_desktop}

    outputs:
      remote_desktop:
        type: string
        title: Remote Desktop
        visible: true

    </copy>
    ```

7. Add an *ingress* rule to your *network.tf* to enable remote access to port *6080* when the VCN is created

    ```
    <copy>
    ingress_security_rules {
      protocol = "6"
      source   = "0.0.0.0/0"
      tcp_options {
        min = 6080
        max = 6080
      }
    }

    </copy>
    ```

8. Test out your ORM Stack and verify the output for *`remote_desktop`* as shown below

    ![](./images/orm-output.png " ")

9. From to the *Application Information Tab* as shown above, click on the single-click URL to test it out.

    ![](./images/orm-single-click-url.png " ")

    **Note:** Your source image instance is now configured to generate a random VNC password for every instance created from it, provided that the provisioning requests include the needed metadata storing the random string.

## Appendix 2: Removing Guacamole from a previously configured LiveLabs image

Prior to noVNC some images were configured with *Apache Guacamole*. If this applies to your image, proceed as detailed below to remove it prior to deploying noVNC

1.  As root, create and run script */tmp/remove-guac.sh*.

    ```
    <copy>
    sudo su - || (sudo sed -i -e 's|root:x:0:0:root:/root:.*$|root:x:0:0:root:/root:/bin/bash|g' /etc/passwd && sudo su -)

    </copy>
    ```

    ```
    <copy>
    cat > /tmp/remove-guac.sh <<EOF
    #!/bin/sh
    # Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.

    cd /etc/systemd/system

    for i in `ls vncserver_*.service`
      do
    systemctl stop $i
    done

    cd /tmp

    systemctl disable guacd tomcat
    systemctl stop guacd tomcat

    yum -y remove \
    	guacd \
        libguac \
        libguac-client-ssh \
        libguac-client-vnc \
    	tomcat \
        tomcat-admin-webapps \
        tomcat-webapps \
        nginx
    EOF
    chmod +x /tmp/remove-guac.sh
    /tmp/remove-guac.sh

    rm -rf /etc/guac*
    rm -rf /etc/nginx*
    rm -f /tmp/remove-guac.sh
    rm -rf /opt/guac*
    cd
    </copy>
    ```

## Acknowledgements
* **Author** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, September 2020
* **Contributors** - Robert Pastijn
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, October 2021
