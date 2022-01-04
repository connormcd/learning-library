# Create Custom OCI Compute Image for Marketplace Publishing

## Introduction
This lab will show you how to prepare a host for custom image capture and create the custom image that meets stringent OCI marketplace requirements.

### Objectives
- Perform cleanup tasks to get the image in the desired state for custom image capture
- Create Custom Image

### Prerequisites
This lab assumes you have:
- An Oracle Enterprise Linux (OEL) that meets requirement for marketplace publishing

## Task 1: Cleanup Instance for Image Capture   

1. As user *opc*, Download the latest *oci-image-cleanup.sh* script.

    ```
    <copy>
    cd /tmp
    wget https://raw.githubusercontent.com/oracle/oci-utils/master/libexec/oci-image-cleanup -O /tmp/oci-image-cleanup.sh
    chmod +x oci-image-cleanup.sh
    </copy>
    ```

2. Stop VNC Service to preserve the remote desktop layout before proceeding with custom image creation.

    ```
    <copy>
    cat > /tmp/stopvnc.sh <<EOF
    #!/bin/bash
    cd /etc/systemd/system
    for i in \$(ls vncserver_*@*)
    do
      sudo systemctl stop \$i
    done
    EOF
    chmod +x /tmp/stopvnc.sh
    /tmp/stopvnc.sh
    </copy>
    ```

2. Create and run script */tmp/cleanup.sh*

    ```
    <copy>
    cat > /tmp/cleanup.sh <<EOF
    #!/bin/bash
    sudo service rsyslog stop
    sudo service auditd stop
    sudo sh -c 'yes| /tmp/oci-image-cleanup.sh'
    sudo find /var/log -type f -exec cp /dev/null {} \;
    sudo find /var/log -type f -size 0 -exec rm {} +
    sudo rm -rf /var/lib/cloud/instances/*
    sudo rm -f /home/opc/get-pip.py
    sudo rm -f /home/opc/.bashrc-orig
    sudo rm -f /home/oracle/.bash_history
    sudo sed -i -e 's|\\\(^.*PermitRootLogin.*$\\\)|PermitRootLogin no|g' /etc/ssh/sshd_config
    sudo sed -i -e 's|root:x:0:0:root:/root:/bin/bash|root:x:0:0:root:/root:/sbin/nologin|g' /etc/passwd
    sudo ln -sf /root/bootstrap/firstboot.sh /var/lib/cloud/scripts/per-instance/firstboot.sh
    sudo ln -sf /root/bootstrap/eachboot.sh /var/lib/cloud/scripts/per-boot/eachboot.sh
    sudo rm -f /u01/app/osa/non-marketplace-init/system-configured
    sudo rm -f /var/log/audit/audit.log
    EOF
    chmod +x /tmp/cleanup.sh
    /tmp/cleanup.sh

    </copy>
    ```

## Task 2: Create Custom Image   

Your instance at this point is ready for clean capture. Proceed to OCI console to perform the next steps

1. Launch your browser to OCI console, then navigate to *"Compute > Instances"*

    ![](./images/select-instance-1.png " ")

2. Select the instance on which you just performed the prior cleanup steps. Make sure to select the right compartment

    ![](./images/select-instance-2.png " ")

3. Click on *"More Actions"* and select *"Create Custom Image"*

    ![](./images/create-image-1.png " ")

4. Enter a name for the image and click *"Create Custom Image"*

    ![](./images/create-image-2.png " ")

5. After successful image creation, click on *"Create Instance"* to provision a test instance from the image

    ![](./images/create-test-instance.png " ")

6. After successful instance creation, logon to the host and validate


You may now [proceed to the next lab](#next).

## Learn More
* [Oracle Cloud Marketplace Partner Portal Documentation](https://docs.oracle.com/en/cloud/marketplace/partner-portal/index.html)
* [Oracle Cloud Marketplace Partner Portal Videos](https://docs.oracle.com/en/cloud/marketplace/partner-portal/videos.html)


## Acknowledgements
* **Author** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, February 2021
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, December 2021
