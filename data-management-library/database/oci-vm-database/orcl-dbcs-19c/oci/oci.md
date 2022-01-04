# Oracle Cloud Infrastructure (OCI)

## Introduction

This is the first of several labs that are part of the Oracle Public Cloud Database Cloud Service workshop. These labs will give you a basic understanding of the Oracle Database Cloud Service and many of the capabilities around administration and database development.

This lab will walk you through creating a new Database Cloud Service instance. You will also connect into a Database image using the SSH private key and familiarize yourself with the image layout.

Estimated Lab Time: 60 minutes

## Task 1: Verify Virtual Cloud Network (VCN)

1. Login to Oracle cloud console using the Workshop Details received:

    - Login URL 	
    - Tenancy name
    - Region
    - User name
    - Initial password
    - Compartment 

2. Click on main menu ≡, then Networking > **Virtual Cloud Networks**. Select the Region and Compartment assigned in Workshop Details. 

3. Click the name of the Virtual Cloud Network (VCN).

4. Under Subnets, click the name of the Public subnet.

5. Under Security Lists, click the name of the existing security list. 

6. Review the Ingress Rules and Egress Rules defined in this security list.

7. Make sure you have this Ingress Rule:
    - CIDR Block: 10.0.0.0/24
    - Destination Port Range: 1521
    - Description: Database connection


## Task 2: Create Database

1. Click on main menu ≡, then **Oracle Database** > **Bare Metal, VM, and Exadata**. Click **Create DB System**.

    - Select your compartment (default)
    - Name your DB system: WS-DB
    - Select a shape type: Virtual Machine (default)
    - Select a shape: VM.Standard2.1
    - Oracle Database software edition: Enterprise Edition Extreme Performance
    - Choose Storage Management Software: Logical Volume Manager
    - Generate SSH key pair, and save both Private Key and Public Key files on your computer.(*optionally select Upload SSH key files to use your own id_rsa.pub public key*)
    - Choose a license type: Bring Your Own License (BYOL)

2. Specify the network information.

    - Virtual cloud network: WS-VCN
    - Client Subnet: Public Subnet
    - Hostname prefix: ws-host

3. Click Next.

    - Database name: WSDB
    - Database version: 19c (default)
    - PDB name: PDB011
    - Password: DBlabsPTS#22_
    - Select workload type: Transaction Processing (default)
    - Configure database backups: Enable automatic backups

4. Click **Create DB System**.


## Task 3: Create Compute Instance

1. Click on hamburger menu ≡, then Compute > **Instances**. Click **Create Instance**.

    - Name: WS-VM
    - Image or operating system: Change Image > **Oracle Images**. Type 'dev' in the search field, and select Oracle Cloud Developer Image
    - Shape: Change Shape > Intel: VM.Standard2.1
    - Virtual cloud network: WS-VCN
    - Subnet: Public Subnet
    - Assign a public IP address (default)
    - Add SSH keys: Upload public key files (.pub), Browse and select the public key file saved from the DB System. (*optionally use your own SSH key files, id_rsa.pub*)

2. Click **Create**.


## Task 4: Compute SSH Connection

1. Wait for both Compute Instance and DB System to finish provisioning, and have status Available.

2. Check Compute Instance Details.

3. Click on hamburger menu ≡, then Compute > **Instances**. Click **WS-VM** Compute instance. On the Instance Details page, copy Public IP Address in your notes. 

4. Check DB System Details.

5. Click on hamburger menu ≡, then Oracle Database > **Bare Metal, VM, and Exadata**. Click **WS-DB** DB System. On the DB System Details page, copy **Host Domain Name** in your notes. In the table below, copy **Database Unique Name** in your notes. Click **Nodes** on the left menu, and copy **Private IP Address** in your notes. E.g.
    - Host Domain Name: subXXXXXXXXXXXX.ws-vcn.oraclevcn.com
    - Database Unique Name: WSDB_xxxxxx
    - Node Private IP Address: 10.0.0.XX 

6. Verify SSH connection from a Linux client. Change the permissions on the private key file you saved from DB System. (Linux only)

    ````
    <copy>
    chmod 400 Downloads/ssh-key-XXXX-XX-XX.key
    </copy>
    ````

7. Connect to the Compute node using SSH. In OpenSSH, local port forwarding is configured using the -L option. Use this option to forward any connection to port 3389 on the local machine to port 3389 on your Compute node. Change `id_rsa` with the private key file you saved on your computer. (Linux only)

    ````
    <copy>
    ssh -C -i id_rsa -L 3389:localhost:3389 opc@<Compute Public IP Address>
    </copy>
    ````

8. Set SSH connection from a Windows client. Use PuttyGen from your computer to convert the private key file you saved on your computer to Putty `.ppk` format. Click on Conversions > Import Key. Open the private key. Click on Save Private Key and Yes to save without a passphrase. Use the same name for the new `.ppk` key file, add only the extension `.ppk`. (Windows only)

9. Connect to Compute Public IP Address port 22. (Windows only)

    ![](./images/putty1.png "")

10. Use the `.ppk` private key you converted with PuttyGen. (Windows only)

    ![](./images/putty2.png "")

11. Create a SSH tunnel from Source port 5001 to Destination localhost:3389. Click **Add**. (Windows only)

    ![](./images/putty4.png "")

12. Go back to Session, give it a name, and save it. When asked if you trust this host, click **Yes**. (Windows only)

    ![](./images/putty3.png "")


## Task 5: Verify DB connection using SQL*Plus.

1. Try to connect to your DB System database using SQL*Plus. You may need to set the `LD_LIBRARY_PATH` environment variable required by SQL*Plus.

    ````
    <copy>
    export LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib
    sqlplus sys/DBlabsPTS#22_@<DB Node Private IP Address>:1521/<Database Unique Name>.<Host Domain Name> as sysdba
    </copy>
    ````

2. List pluggable databases.

    ````
    <copy>
    show pdbs
    </copy>
    ````

3. You will see `PDB011` in the list opened in `READ WRITE` mode. Exit SQL*Plus.

    ````
    <copy>
    exit
    </copy>
    ````

4. Connect directly to the pluggable database.

    ````
    <copy>
    sqlplus sys/DBlabsPTS#22_@<DB Node Private IP Address>:1521/pdb011.<Host Domain Name> as sysdba
    </copy>
    ````

5. Display the current container name.

    ````
    <copy>
    show con_name
    </copy>
    ````

6. List all users in PDB011.

    ````
    <copy>
    select username from all_users order by 1;
    </copy>
    ````

7. This pluggable database doesn't have Oracle Sample Schemas. Exit SQL*Plus.

    ````
    <copy>
    exit
    </copy>
    ````

## Task 6: Remote Desktop Connection

1. For some of the labs we need graphical user interface, and this can be achieved using a Remote Desktop connection.

2. Use the substitute user command to start a session as **root** user.

    ````
    <copy>
    sudo su -
    </copy>
    ````

3. Create a new script that will install and configure all the components required for the Remote Desktop connection.

    ````
    <copy>
    vi xRDP_config.sh
    </copy>
    ````

4. Press **i** to insert text, and paste the following lines:

    ````
    <copy>
    #!/bin/bash

    yum -y groupinstall "Server with GUI"

    yum -y install xrdp tigervnc-server terminus-fonts terminus-fonts-console cabextract

    wget --no-check-certificate https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
    yum -y localinstall msttcore-fonts-installer-2.6-1.noarch.rpm

    yum -y update sqldeveloper.noarch
    yum update -y oracle-instantclient*

    sed -i 's/max_bpp=24/max_bpp=128\nuse_compression=yes/g' /etc/xrdp/xrdp.ini

    systemctl enable xrdp

    firewall-cmd --permanent --add-port=3389/tcp
    firewall-cmd --permanent --add-port=5500/tcp
    firewall-cmd --reload

    chcon --type=bin_t /usr/sbin/xrdp
    chcon --type=bin_t /usr/sbin/xrdp-sesman

    systemctl start xrdp

    echo -e "DBlabsPTS#22_\nDBlabsPTS#22_" | passwd oracle

    sed -i -e 's/^/#/' /etc/profile.d/oracle-instantclient*

    printf "\nORACLE_HOME="$(find /usr -iname client64 | grep lib)"\nLD_LIBRARY_PATH=\$ORACLE_HOME/lib\nPATH=\$PATH:\$ORACLE_HOME/bin\nexport ORACLE_HOME LD_LIBRARY_PATH PATH\n" >> /etc/profile

    # Shared library libomsodm.so is missing from the Instant Client Tools Package (RPM)
    wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-tools-linux.x64-21.1.0.0.0.zip
    unzip instantclient-tools-linux.x64-21.1.0.0.0.zip
    install -m 755 -o root -g root instantclient_21_1/libomsodm.so /usr/lib/oracle/21/client64/lib/libomsodm.so
    ldconfig
    </copy>
    ````

5. Press **Esc**, type **:wq** and hit **Enter** to save the file and close. Make this script executable.

    ````
    <copy>
    chmod u+x xRDP_config.sh 
    </copy>
    ````

6. Run the script and check that all goes well.

    ````
    <copy>
    ./xRDP_config.sh
    </copy>
    ````

7. Use Microsoft Remote Desktop to open a connection to **localhost**. (Linux only)

8. If you are using Putty on Windows, connect to **localhost:5001**. (Windows only)

    ![](./images/putty5.png "")

9. When asked about username and password, use **oracle** and **DBlabsPTS#22_**. 

    >**Note** : Verify in the username dialog you are typing your password correctly. The standard US 101 keyboard is default on the compute node, `#` is `Shift+3` and `_` is `Shift+key-after-0`.

10. After setting your language and keyboard layout, open a Terminal window using **Right-Click** and **Open Terminal**. Check if your keyboard works. If you need to select another keyboard layout, click the **On-Off** button in the upper right corner, and **Settings** button. You will find the options under Region & Language.

11. From the Terminal window, launch SQL Developer.

    ````
    <copy>
    sqldeveloper 
    </copy>
    ````

12. It may ask for the full pathname of a JDK installation. This should be available in folder **/usr/java**. Type **/usr/java/latest** when asked.

    ````
    Default JDK not found
    Type the full pathname of a JDK installation (or Ctrl-C to quit), the path will be stored in /home/oracle/.sqldeveloper/19.4.0/product.conf
    <copy>
    /usr/java/latest
    </copy>
    ````

13. You will receive a warning message that Java JDK is older than the recommended version for this SQL Developer. In order to save time, we will skip Java update for now.

14. Once JDK installation full pathname is set, SQL Developer can be started from **Applications** main menu, and **Programming**.

## Acknowledgements

- **Author** - Valentin Leonard Tabacaru
- **Last Updated By/Date** - Valentin Leonard Tabacaru, DB Product Management, December 2021

See an issue? Please open up a request [here](https://github.com/oracle/learning-library/issues). Please include the workshop name and lab in your request.

