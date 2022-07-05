> ***MySQL Implementation Essentials Bootcamp***
>
> ***(release 2022-04)***

# Summary

[Summary [2](#summary)](#summary)

[Environment description
[4](#environment-description)](#environment-description)

[Document standard and prerequisites
[5](#document-standard-and-prerequisites)](#document-standard-and-prerequisites)

[1a) Material and software download
[6](#a-material-and-software-download)](#a-material-and-software-download)

[1b) Create a VCN (Virtual Cloud Network)
[10](#b-create-a-vcn-virtual-cloud-network)](#b-create-a-vcn-virtual-cloud-network)

[1c) Application server creation and test
[15](#c-application-server-creation-and-test)](#c-application-server-creation-and-test)

[1d) OCI CLI installation
[21](#d-oci-cli-installation)](#d-oci-cli-installation)

[1e) Environment setup [29](#e-environment-setup)](#e-environment-setup)

[2a) Installation of MySQL Community
[31](#a-installation-of-mysql-community)](#a-installation-of-mysql-community)

[2b) Open subnet ports to access MySQL
[34](#b-open-subnet-ports-to-access-mysql)](#b-open-subnet-ports-to-access-mysql)

[2c) Detailed Installation of MySQL on Linux
[39](#c-detailed-installation-of-mysql-on-linux)](#c-detailed-installation-of-mysql-on-linux)

[2d) Verify the new MySQL Installation on Linux and import test
databases
[43](#d-verify-the-new-mysql-installation-on-linux-and-import-test-databases)](#d-verify-the-new-mysql-installation-on-linux-and-import-test-databases)

[2e) MySQL Shell: the new client
[46](#e-mysql-shell-the-new-client)](#e-mysql-shell-the-new-client)

[3a) Database Design [48](#a-database-design)](#a-database-design)

[3b) MySQL JSON datatype
[50](#b-mysql-json-datatype)](#b-mysql-json-datatype)

[3c) MySQL Document Store
[51](#c-mysql-document-store)](#c-mysql-document-store)

[4a) Users management [53](#a-users-management)](#a-users-management)

[4b) MySQL Roles [56](#b-mysql-roles)](#b-mysql-roles)

[4c) MySQL Enterprise Firewall
[57](#c-mysql-enterprise-firewall-account-profiles)](#c-mysql-enterprise-firewall-account-profiles)

[4d) MySQL Enterprise Audit
[59](#d-mysql-enterprise-firewall-group-profiles)](#d-mysql-enterprise-firewall-group-profiles)

[4e) Data Masking and de-identification
[60](#f-data-masking-and-de-identification)](#f-data-masking-and-de-identification)

[5a) MySQL logical backup (mysqldump)
[61](#a-mysql-logical-backup-mysqldump)](#a-mysql-logical-backup-mysqldump)

[5b) MySQL Enterprise Backup
[62](#b-mysql-shell-dumpload)](#b-mysql-shell-dumpload)

[6a) MySQL Replication: prepare replica server
[64](#a-mysql-replication-prepare-replica-server)](#a-mysql-replication-prepare-replica-server)

[6b) MySQL Replication: create replica
[65](#b-mysql-replication-create-replica)](#b-mysql-replication-create-replica)

[7a) Open subnet ports for MySQL InnoDB Cluster
[68](#a-open-subnet-ports-for-mysql-innodb-cluster)](#a-open-subnet-ports-for-mysql-innodb-cluster)

[7b) MySQL InnoDB Cluster
[71](#b-mysql-innodb-cluster)](#b-mysql-innodb-cluster)

[8a) Open subnet ports for MySQL Enterprise Monitor
[81](#a-open-subnet-ports-for-mysql-enterprise-monitor)](#a-open-subnet-ports-for-mysql-enterprise-monitor)

[8b) MySQL Enterprise Monitor - Install Service Manager
[85](#b-mysql-enterprise-monitor---install-service-manager)](#b-mysql-enterprise-monitor---install-service-manager)

[8c) MySQL Enterprise Monitor - Install Agent
[91](#c-mysql-enterprise-monitor---install-agent)](#c-mysql-enterprise-monitor---install-agent)

[9) MySQL Database Service
[95](#a-mysql-heatwave-database-service---deploy)](#a-mysql-heatwave-database-service---deploy)

[Addendum
[100](#b-mysql-heatwave-database-service---use)](#b-mysql-heatwave-database-service---use)

[A1) Software used in this lab guide
[100](#a1-software-used-in-this-lab-guide)](#a1-software-used-in-this-lab-guide)

[A2) Content of file my.cnf.mysql1
[101](#a2-content-of-file-my.cnf.mysql1)](#a2-content-of-file-my.cnf.mysql1)

[A3) Content of file my.cnf.mysql2
[102](#a3-content-of-file-my.cnf.mysql2)](#a3-content-of-file-my.cnf.mysql2)

[A4) Content of file my.cnf.mysql3
[103](#a4-content-of-file-my.cnf.mysql3)](#a4-content-of-file-my.cnf.mysql3)

[A5) Content of mysqld-advanced.service
[104](#a5-content-of-mysqld-advanced.service)](#a5-content-of-mysqld-advanced.service)

[A6) Content of file mysqlbackup_user_grants.sql
[105](#a6-content-of-file-mysqlbackup_user_grants.sql)](#a6-content-of-file-mysqlbackup_user_grants.sql)

[A7) Putty configuration
[106](#a7-putty-configuration)](#a7-putty-configuration)

[A8) How to create and use Compartments
[109](#a8-how-to-create-and-use-compartments)](#a8-how-to-create-and-use-compartments)

# Environment description

![](media/image1.wmf){width="6.0734984689413825in"
height="8.775877077865267in"}![](media/image2.png){width="6.0734984689413825in"
height="8.775877077865267in"}![](media/image3.png){width="6.0734984689413825in"
height="8.775877077865267in"}![](media/image2.png){width="6.0734984689413825in"
height="8.775877077865267in"}![](media/image3.png){width="6.0734984689413825in"
height="8.775877077865267in"}![](media/image2.png){width="6.0734984689413825in"
height="8.775877077865267in"}![](media/image3.png){width="6.0734984689413825in"
height="8.775877077865267in"}![](media/image2.png){width="6.0734984689413825in"
height="8.775877077865267in"}![](media/image3.png){width="6.0734984689413825in"
height="8.775877077865267in"}

# Document standard and prerequisites

> To completes the labs in this guide you need

- a valid Oracle account on edelivery.oracle.com

- an empty trial environment or a dedicated compartment inside Oracle
    Cloud Infrastructure (OCI)

- SSH and SCP client to interact with the lab machines

- Basic SQL skills

- Basic linux shell skills

> Document standard:

- When in the manual you read shell\> the command must be executed in
    the Operating System shell

- When in the manual you read mysql\> the command must be executed in
    a client like mysql, mysqlsh, MySQL Workbench, etc.\
    We recommend students to use MySQL Shell to practice with it

- When in the manual you read MySQL ... \> the command must be
    executed in MySQL shell

> Software used in the labs

- When all of the lab 1 steps are completed, the software will be
    located within each server in the directory "/workshop"

# 1a) Material and software download

Objective: Download the software and configure the environment for the
labs

Notes:

- You need a valid Oracle account on edelivery.oracle.com

- **The software that you are using in this workshop is trial**: you
    are eligible to use it for 30 days, that you have to buy or remove
    it

1. Create a dedicated directory inside your PC where to put all the
    material. From now on we call this directory "WORK_DIRECTORY"

2. Download from provided link all materials in WORK_DIRECTORY

- lectures slides in pdf

- lab guide in pdf (this document)

- configure_essential_labs.sh script

3. Connect to <https://edelivery.oracle.com> and login with your
    account

![Graphical user interface, website Description automatically
generated](media/image7.jpeg){width="6.179104330708661in"
height="3.131593394575678in"}

4. In the text box insert "MySQL Enterprise Edition" and then click on
    "DLP: MySQL Enterprise Edition (MySQL Enterprise Edition)" to add it
    to cart

![Graphical user interface, text, application Description automatically
generated](media/image8.jpg){width="6.178472222222222in"
height="2.7451574803149605in"}

5. Deselect "MySQL Installer 8..."

6. Select for MySQL Server 8... the platform "Linux x86-64"

![A screenshot of a computer Description automatically
generated](media/image9.png){width="6.551999125109361in"
height="3.321898512685914in"}

7. All the software automatically add the Linux x86-64 platform and the
    button.\
    Click now the button "Continue" now enabled

![Graphical user interface, text, application Description automatically
generated](media/image10.png){width="6.471999125109361in"
height="3.286557305336833in"}

8. Read and accept the Terms and restrictions and click "Continue"

![Text Description automatically
generated](media/image11.png){width="6.383999343832021in"
height="3.245087489063867in"}

9. Click on "Wget options" and download the file "wget.sh" with a click
    on "Download .sh"

![Graphical user interface, text, application Description automatically
generated](media/image12.png){width="6.383333333333334in"
height="3.235097331583552in"}

10. Move the file wget.sh **inside WORK_DIRECTORY**

# 1b) Create a VCN (Virtual Cloud Network)

Objective: Create a new VCN (Virtual Cloud Network) to connect our
machines and services.

Notes:

- You need an empty trial environment or a dedicated compartment
    inside Oracle Cloud Infrastructure (OCI) with user settings access

- For more information on Oracle Cloud Console, please visit:
    <https://docs.cloud.oracle.com/iaas/Content/GSG/Concepts/console.htm>

1. Sign in to Oracle Cloud, please visit
    <https://www.oracle.com/cloud/sign-in.html>, enter your Cloud
    Account (tenancy name)

![](media/image13.png){width="4.715277777777778in"
height="2.951388888888889in"}

2. On Oracle Cloud Account Sign in, enter User Name, that is the e-mail
    address provided on Exercise 1, and Password created and click on
    Sign in.

![](media/image14.png){width="4.750694444444444in"
height="2.973611111111111in"}

3. When you sign in to the Oracle Cloud you\'ll see the Console home
    page. Use the navigation menu in the upper left to navigate to the
    service pages where you create, manage, and view the cloud
    resources.

![](media/image15.png){width="5.0in" height="3.129861111111111in"}

4. Choose your compartment.\
    If your tenancy is empty, you can use root compartment, otherwise we
    suggest you to create a dedicated compartment for the bootcamp. For
    the instructions read the addendum.

5. We create now the VCN

6. On the Navigation Menu, select Networking -\> Virtual Cloud
    Networks.

![ ](media/image16.png){width="5.833333333333333in"
height="2.7554735345581802in"}

7. Click on Start VCN Wizard.

![](media/image17.png){width="5.8127646544181975in" height="4.03125in"}

8. On Start VCN Wizard, select VCN with Internet Connectivity and click
    the button "Start VCN Wizard".\
    If you don't see the button, select in the left menu the Compartment
    "(root)".

![](media/image18.png){width="4.888094925634296in"
height="3.283047900262467in"}

9. On Basic Information, enter then click Next

**VCN Name:** mysqlvcn

**Compartment:** (keep the root compartment or choose your own)

Keep the defaults for the section "Configure VCN and Subnets"

**VCN CIDR Block:** 10.0.0.0/16

> (keep the default)

**Public Subnet CIDR Block:** 10.0.0.0/24

> (keep the default)

**Private Subnet CIDR Block:** 10.0.1.0/24

> (keep the default)

**DNS Resolution:** enabled

> (keep the default)

![](media/image19.png){width="5.587583114610673in" height="2.625in"}

10. Under Review and Create, review the Oracle Virtual Cloud Network
    (VCN) and Subnets information and click on Create. As you see, you
    can customize the VCN with route tables and security lists.\
    We do this later to show you how to modify the VCN when it's
    created.\
    \
    Click Create button to create the VCN.

![](media/image20.png){width="5.6347834645669295in"
height="3.173912948381452in"}

11. ![](media/image21.png){width="5.677083333333333in"
    height="3.6041666666666665in"}The Virtual Cloud Network creation is
    done.

12. Click \"View Virtual Cloud Network\" button to display the created
    VCN

# 1c) Application server creation and test

Objective: download and upload wget sw, upload and execute deploy.sh
script; connect to all mysql servers, then power off mysql2 and mysql3

Notes:

- The compute machine that we create is called "app-srv"

- You need an empty trial environment or a dedicated compartment
    inside Oracle Cloud Infrastructure (OCI)

- Compute instances have by default the user "opc" without password.
    It's mandatory to use an SSH key file to access the instance

- Linux opc user has limited privileges. To work with administrative
    privileges, use \"sudo\" like

shell\> sudo su - root

1. On the navigation Menu, click on Compute -\> Instances

![ ](media/image22.png){width="5.833333333333333in" height="2.625in"}

2. Click on "Create Instance".

![](media/image23.png){width="5.439015748031496in"
height="3.5104166666666665in"}

3. On Create Compute Instance, enter

**Name:** app-srv\
**Create in compartment**: (keep the root compartment or choose your
own)

**Placement**: (keep the default)

**Image and shape**

> **Image:**

a.  click "Edit"

b.  then \"Change image"

c.  Insert:

- Image name: Oracle Linux

- OS version: 8

d.  Then click "Select Image"

![](media/image24.jpeg){width="6.707995406824147in"
height="3.77586176727909in"}

**\
**

> **Shape:**

a.  click \"Change shape"

b.  Insert:

- Instance type: Virtual machine

- Shape series: AMD

- Shape name: VM.Standard.E4.Flex

- Number of OCPUs: 1

- Amount of memory: 8GB

c.  Then click "Select shape"

> ![](media/image25.png){width="5.5516130796150485in"
> height="4.25582895888014in"}

**\
**

> **Networking**
>
> Virtual Cloud Network: mysqlvcn (the default)
>
> Subnet: Public Subnet-mysqlvcn (regional) (the default)
>
> Public IP address: Assign a public IPv4 address (the default)
>
> **Add SSH keys:** keep the default \"Generate a key pair for me\" and
> then click the button \"Save Private Key". Please save the file in our
> previously created directory WORK_DIRECTORY

![](media/image26.png){width="6.006944444444445in"
height="1.563865923009624in"}

4. We are now ready to start the creation, so click on button "Create".

5. The New Virtual Machine is now in PROVISIONING.

![Interface gráfica do usuário, Site Descrição gerada
automaticamente](media/image27.png){width="4.840859580052493in"
height="2.712765748031496in"}

6. Wait for the status to change to RUNNING. The instance is now ready
    to be used. \*\*plf\*\*\
    In the recap you see the public IP address to use in next steps

PUBLIC IP ADDRESS \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

![Graphical user interface, text, application Description automatically
generated](media/image28.jpeg){width="6.181376859142607in"
height="3.4791666666666665in"}

7. Now we can test the connection to app-srv

8. Using your ssh client (e.g. from bash shell or Windows Powershell on
    your local system) connect to the Compute with these parameters:

> **User**: opc
>
> **Private key**: the file downloaded during the instance creation
>
> **Connection address**: public IP of the compute machine. It's shown
> in the instances summary or Instance details.

The command will look like\
ssh -i \<private_key_file\> opc@\<your_compute_instance_ip\>

For example:

shell\> ssh -i ssh-key-2022-01-10.key opc@132.145.170

9. If you can connect to your MDS Client the task is finished. Proceed
    to next lab.

10. If not, fix your ssh connection errors or ask the instructor for
    help. \*\*plf\*\*

**IN CASE OF ERRORS WITH WINDOWS POWERSHELL**

In case you are using powershell and you receive an error like

Permissions for \'.\\\\id_rsa\' are too open.

It is required that your private key files are NOT accessible by others.

This private key will be ignored.

Load key \".\\\\id_rsa\": bad permissions

Please use below commands to fix the permissions (please change full
path with your path\
(e.g. New-Variable -Name Key -Value \"C:\\mysql\\id_rsa\")

powershell\> New-Variable -Name Key -Value \"\<full path\>\\id_rsa\"

\# Verify that ls command retrieve the right file

powershell\> ls \$Key

powershell\> Icacls \$Key /c /t /Inheritance:d

powershell\> Icacls \$Key /c /t /Grant \${env:UserName}:F

powershell\> TakeOwn /F \$Key

powershell\> Icacls \$Key /c /t /Grant:r \${env:UserName}:F

powershell\> Icacls \$Key /c /t /Remove:g Administrator \"Authenticated
Users\" BUILTIN\\Administrators BUILTIN Everyone System Users

powershell\> Icacls \$Key

powershell\> Remove-Variable -Name Key

Then retry the ssh connection.

\*plf\*\* How about

\$ sudo chmod 600 \~/.ssh/id_rsa

\$ sudo chmod 600 \~/.ssh/id_rsa.pub

# 1d) OCI CLI installation

Objective: Install the OCI CLI tool

Notes:

- OCI CLI tool is used by setup script, but it's useful also to
    control our instances. In the addendum you have an example how to
    automatically stop&start resources with crontab

- More info on OCI CLI can be found here
    <https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm>

1. If not already connected, connect to app-srv

shell\> ssh -i \<private_key_file\> opc@\<your_compute_instance_ip\>

2. Install the OCI CLI

shell-app-srv\> sudo yum -y install oraclelinux-developer-release-el8

shell-app-srv\> sudo yum -y install python36-oci-cli

3. Before configuring the OCI CLI we need to retrieve some information
    needed to complete the task: \*\*plf\*\*\
    tenancy OCID, user OCID and region

    - From the shell submit the following command to retrieve your
        region\
        Region: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

shell-app-srv\> oci-metadata -g region

> Output example:
>
> \[opc@app-srv \~\]\$ oci-metadata -g region
>
> Instance details:
>
> Region: iad - us-ashburn-1 (Ashburn, VA, USA)

- Connect to your dashboard and click on profile. Then select Tenancy

![A screenshot of a computer Description automatically
generated](media/image29.png){width="6.478261154855643in"
height="3.9068077427821524in"}

- Write down the tenancy OCID

> Tenancy OCID: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

![Graphical user interface, text, application, email Description
automatically generated](media/image30.png){width="6.2in"
height="3.399032152230971in"}

- From the dashboard click on profile and select "User: Settings"

![A screenshot of a computer Description automatically
generated](media/image29.png){width="6.478261154855643in"
height="3.9068077427821524in"}

- Write down the User OCID

![Graphical user interface, text, application, email Description
automatically generated](media/image31.png){width="6.2in"
height="3.960850831146107in"}

4. **Don't close this page**!

5. We are now ready to execute the setup.

Switch to your ssh connection to app-srv and execute the following
command

shell-app-srv\> oci setup config

6. Accept all defaults except for the information retrieve above

    - Tenancy OCID

    - User OCID

    - Region (insert your region number)

> Output example (the region number change when we add new regions!)

\[opc@app-srv \~\]\$ **oci setup config**

This command provides a walkthrough of creating a valid CLI config file.

The following links explain where to find the information required by
this

script:

User API Signing Key, OCID and Tenancy OCID:

<https://docs.cloud.oracle.com/Content/API/Concepts/apisigningkey.htm#Other>

Region:

<https://docs.cloud.oracle.com/Content/General/Concepts/regions.htm>

General config documentation:

<https://docs.cloud.oracle.com/Content/API/Concepts/sdkconfig.htm>

Enter a location for your config \[/home/opc/.oci/config\]:

Enter a user OCID:
**ocid1.user.oc1..aaaaaaaantijdlnhvrp3dfwngs4flpjxeyriph3tf4472owrywxmvltoezpa**

Enter a tenancy OCID:
**ocid1.tenancy.oc1..aaaaaaaa4yet6xypq5khquqhozb7rja2cwomj4zvpxvqgusrnojr3t5rieiq**

Enter a region by index or name(e.g.

1: ap-chiyoda-1, 2: ap-chuncheon-1, 3: ap-hyderabad-1, 4: ap-ibaraki-1,
5: ap-melbourne-1,

6: ap-mumbai-1, 7: ap-osaka-1, 8: ap-seoul-1, 9: ap-singapore-1, 10:
ap-sydney-1,

11: ap-tokyo-1, 12: ca-montreal-1, 13: ca-toronto-1, 14: eu-amsterdam-1,
15: eu-frankfurt-1,

16: eu-marseille-1, 17: eu-milan-1, 18: eu-stockholm-1, 19: eu-zurich-1,
20: il-jerusalem-1,

21: me-abudhabi-1, 22: me-dubai-1, 23: me-jeddah-1, 24: sa-santiago-1,
25: sa-saopaulo-1,

26: sa-vinhedo-1, 27: uk-cardiff-1, 28: uk-gov-cardiff-1, 29:
uk-gov-london-1, 30: uk-london-1,

**31: us-ashburn-1**, 32: us-gov-ashburn-1, 33: us-gov-chicago-1, 34:
us-gov-phoenix-1, 35: us-langley-1,

36: us-luke-1, 37: us-phoenix-1, 38: us-sanjose-1): **31**

Do you want to generate a new API Signing RSA key pair? (If you decline
you will be asked to supply the path to an existing key.) \[Y/n\]: **Y**

Enter a directory for your keys to be created \[/home/opc/.oci\]:

Enter a name for your key \[oci_api_key\]:

Public key written to: /home/opc/.oci/oci_api_key_public.pem

Enter a passphrase for your private key (empty for no passphrase):

Private key written to: /home/opc/.oci/oci_api_key.pem

Fingerprint: 21:1f:6e:84:92:ec:88:54:86:1a:17:6b:e6:ab:bf:cf

Config written to /home/opc/.oci/config

If you haven\'t already uploaded your API Signing public key through the

console, follow the instructions on the page linked below in the section

\'How to upload the public key\':

<https://docs.cloud.oracle.com/Content/API/Concepts/apisigningkey.htm#How2>

\[opc@app-srv \~\]\$

7. Now we need to upload the public key in our user settings.

8. Show the content of the public certificate automatically generated
    by the setup wizard.

shell-app-srv\> cat \~/.oci/oci_api_key_public.pem

> The output shows something like

\-\-\-\--BEGIN PUBLIC KEY\-\-\-\--

MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxzT4IK6xQRm6O1iIIUGI

smDerJp3hnRjS3INOScBnwaMRaR3ZYmcvUfXznE7sI2v/E7C3ISAsAx+ZJFTLnnq

KMHcZ8Q4OiorJFDlMYybXZEDV4RoQrvBmjxxO2tGg5qIUDCcajf7+AHDCf6PkP+W

ZmuuGF8tLfEsBNvfNChp0mkBl3cwc6bhzWUypi4fZBRopSGg3Cemm3hehGTVfng9

btNRCAslOYwhE2wEDiiNhcSXsxAutS4LRrvrLobuOQocXa07tv0XuCg1TT+IzfXW

CjW4dw9mIFtVtDVZ8Oq/t7fmK2maUd+sTKKQLXz6Sfqfc/eX1O65uf1puZ32y6va

9QIDAQAB

\-\-\-\--END PUBLIC KEY\-\-\-\--

9. Return to your user settings. IF you previously closed the page,
    here are the steps to return \*\*plf\*\*

![A screenshot of a computer Description automatically
generated](media/image29.png){width="6.477777777777778in"
height="3.906515748031496in"}

10. From the User Details page select "API Keys" and click on "Add API
    Key"

![Graphical user interface, text, application Description automatically
generated](media/image32.png){width="6.477777777777778in"
height="3.4742727471566055in"}

11. Select "Paste Public Key"

![Graphical user interface, text, application Description automatically
generated](media/image33.png){width="6.487682633420822in"
height="3.6496073928258967in"}

12. In the text box insert the content of the public certificate
    retrieved before in the SSH connection. Please insert from
    "\-\-\-\--BEGIN PUBLIC KEY\-\-\-\--" to "\-\-\-\--END PUBLIC
    KEY\-\-\-\--". The nclick "Add"

![Graphical user interface, application Description automatically
generated](media/image34.png){width="6.4875in"
height="3.649504593175853in"}

13. If everything is fine, a recap windows is displayed. Click "Close".

![Graphical user interface, text, application, email Description
automatically generated](media/image35.png){width="6.365217629046369in"
height="3.580715223097113in"}

14. We are now ready to test the installation.\
    Return to the SSH connection to app-srv and check the version with

shell-app-srv\> oci \--version

15. If the version is shown without errors, go to next lab. \*\*plf\*\*

# 1e) Environment setup

Objective: Configure the app-srv as NFS server, create and populate the
/workshop folder, create 3 new instances for mysql servers

Note: It's mandatory that previous steps are correctly completed
\*\*plf\*\*

1. If the SSH is open, close it

shell-app-srv\> exit

2. Copy the files wget.sh downloaded in lab 1a and the configuration
    script to your instance

shell\> scp -i \<private_key_file\> wget.sh
opc@\<your_compute_instance_ip\>:/home/opc/

shell\> scp -i \<private_key_file\> configure_essential_labs.sh
opc@\<your_compute_instance_ip\>:/home/opc/

3. Now reconnect to app-srv

shell\> ssh -i \<private_key_file\> opc@\<your_compute_instance_ip\>

4. Verify that the 2 files (wget.sh and configure_labs.sh) are here

shell-app-srv\> ls -l

5. Execute the configuration script

shell-app-srv\> chmod +x configure_essential_labs.sh \*\*plf\*\*

shell-app-srv\> ./configure_essential_labs.sh \*\*plf\*\*

a.  Choose your timezone (use the mouse or "space" to select your
    timezone)

> ![Graphical user interface, text Description automatically
> generated](media/image36.png){width="3.5196423884514436in"
> height="2.90625in"}

b.  If you have not changed the wget.sh file name, insert your edelivery
    username and password.\
    If you changed the name of the file download from edelivery, provide
    the correct one.

![](media/image37.png){width="6.39287510936133in"
height="2.5416666666666665in"}

6. If everything is fine download start.\
    The script requires some time to be completed, if no errors was
    displayed until now, continue with the lecture while the script
    complete.

If you see any error message, please inform the trainer.

# 2a) Installation of MySQL Community

Objective: Installation of MySQL 8 (Community) on Oracle Linux 7.
Because by default RedHat install MariaDB so, we update the repository
to install the original MySQL.

Server: mysql1

Notes:

- We call the instance installed here **mysql-gpl**

- References

  - <https://dev.mysql.com/doc/mysql-yum-repo-quick-guide/en/>

  - <https://dev.mysql.com/doc/refman/8.0/en/validate-password.html>

1. Open an SSH client to app-srv

2. Connect to mysql1

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql1 mysql1

3. Which MySQL packages are installed on your Linux?

shell-mysql1\> sudo rpm -qa \| grep mysql

4. What happens when you try to install the mysql binaries with RedHat
    repositories?\
    Run this command but **don't confirm**

shell-mysql1\> sudo yum install mysql

5. As you have seen, above command try to install MariaDB sw. Each
    distribution has its own repositories and different choices for the
    packages to install.

6. Because a non update PGPkey please run (\*\*plf\*\* What does this
    mean? )

shell-mysql1\> sudo rpm \--import
<https://repo.mysql.com/RPM-GPG-KEY-mysql-2022>

7. Oracle Linux 8 already have the official MySQL repository, but to
    show you how to do it, we install it from the package downloading
    from <https://dev.mysql.com/downloads/>

shell-mysql1\> wget
<https://dev.mysql.com/get/mysql80-community-release-el8-1.noarch.rpm>

shell-mysql1\> sudo yum -y install
mysql80-community-release-el8-1.noarch.rpm

8. Update repository database with the new references

shell-mysql1\> sudo yum repolist all

9. repeat the command above to install mysql-client (without using the
    mysql module id default repositories, to force the usage of MySQL
    ones) and note the different packages

shell-mysql1\> sudo yum module disable mysql

shell-mysql1\> sudo yum install mysql

10. If only mysql packages are shown, confirm the installation.

11. Install mysql-server

shell-mysql1\> sudo yum install mysql-server

12. Because MySQL is automatically installed you can use OS command for
    service management, for example to check if it's already started

shell-mysql1\> sudo systemctl status mysqld

13. Start MySQL if not started

shell-mysql1\> sudo systemctl start mysqld

shell-mysql1\> sudo systemctl status mysqld

14. Check the content of my.cnf, that is in default folder for linux OS
    and note some info (lines that stat with "#" are just comments)

shell-mysql1\> cat /etc/my.cnf

a.  Where is the database and the error log (mysqld.log) stored?

> \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

b.  check if there are error for the instance looking in the error log
    file

shell\> sudo grep -i error /var/log/mysqld.log

15. Starting from MySQL 5.7 the default installation of MySQL Server
    generates a one-time password. You find it in error log notes above

shell-mysql1\> sudo grep \'temporary\' /var/log/mysqld.log

16. Login to MySQL using password retrieved in previous step

shell-mysql1\> mysql -uroot -p -h localhost

17. Try to run a command and write down the error message

mysql\> status;

> ERROR MESSAGE:
> \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

18. Change root password

mysql\> ALTER USER \'root\'@\'localhost\' IDENTIFIED BY \'Welcome1!\';

19. Retry command above, now it works

mysql\> status;

20. Which databases are installed by default?

mysql\> show databases;

> **+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+**
>
> **\| Database \|**
>
> **+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+**
>
> **\| information_schema \|**
>
> **\| mysql \|**
>
> **\| performance_schema \|**
>
> **\| sys \|**
>
> **+\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--+**
>
> **4 rows in set (0.01 sec)**

21. To see which version of MySQL you are using submit the command

mysql\> show variables like \"%version%\";

22. Check default users in standard installation

mysql\> select user, host from mysql.user where user=\'root\';

23. Logout as 'root' and connect as admin

mysql\> exit

# 2b) Open subnet ports to access MySQL

Objective: Tarball Installation of MySQL 8 Enterprise on Linux

Notes:

- We have an installation on standard port (3306 and 33060). Next lab
    create a new instance on 3307/33070, so we open now the access to
    both the instances

- The security by default approach of OCI, means that connect services
    between subnets requires to open the dedicated ports. This can be
    achieved using Security lists
    (<https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/securitylists.htm>)
    or Network security groups
    (<https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/networksecuritygroups.htm#Network_Security_Groups>).\
    In this workshop we use Security lists

1. Login in your OCI tenancy dashboard

2. If are using a dedicated compartment, select it

3. On the Navigation Menu, select Networking -\> Virtual Cloud
    Networks.

![ ](media/image16.png){width="5.833333333333333in"
height="2.7554735345581802in"}

4. Select mysqlvn

![Graphical user interface, text, application, email Description
automatically generated](media/image38.png){width="6.147826990376203in"
height="2.9775535870516188in"}

5. Select "Security Lists" from left side menu

![Graphical user interface, text, application Description automatically
generated](media/image39.png){width="5.895048118985127in"
height="2.85869094488189in"}

6. Select "Security List for **Private** Subnet-mysqlvcn" security
    list.

![Graphical user interface, application Description automatically
generated](media/image40.png){width="5.843478783902012in"
height="2.836628390201225in"}

7. Click the button "Add Ingress Rules"

![A screenshot of a computer Description automatically
generated](media/image41.png){width="5.886956474190726in"
height="2.839339457567804in"}

8. In the form insert these values then add a new line with the button
    "+ Another Ingress rule"

**Source:** CIDR

**Source CIDR:** 10.0.0.0/16

**IP Protocol:** TCP

**Source Port Range:** \<leave it empty\>

**Destination port range:** 3306,33060

**Description:** Default MySQL ports

![](media/image42.png){width="6.3917727471566055in"
height="3.951846019247594in"}

9. In the new line add these values then confirm with the button "Add
    Ingress Rules"

**Source:** CIDR

**Source CIDR:** 10.0.0.0/16

**IP Protocol:** TCP

**Source Port Range:** \<leave it empty\>

**Destination port range:** 3307,33070

**Description:** MySQL ports for custom installation

![Graphical user interface, application Description automatically
generated](media/image43.png){width="6.889583333333333in"
height="6.373611111111111in"}

# 2c) Detailed Installation of MySQL on Linux

Objective: Tarball Installation of MySQL 8 Enterprise on Linux

Server: mysql1

Notes:

- we call this instance **mysql-advanced**

- this is the most used instance in the labs

1. If not already connected, connect to mysql1 server trhougth app-srv

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql1 mysql1

2. On Oracle Linux8/RHEL8/Centos 8 is required to install
    ncurses-compat-libs to use the tar package (not for the rpms)

shell-mysql1\> sudo yum install -y ncurses-compat-libs

3. Usually, to run mysql the user "mysql" is used, but because it is
    already available we show here how to create a new one. \*\*plf\*\*

Create a new user/group for your MySQL service (mysqluser/mysqlgrp) and
a add 'mysqlgrp' group to opc to help with labs execution.

shell-mysql1\> sudo groupadd mysqlgrp

shell-mysql1\> sudo useradd -r -g mysqlgrp -s /bin/false mysqluser

shell-mysql1\> sudo usermod -a -G mysqlgrp opc

4. Create new directory structure:

shell-mysql1\> sudo mkdir /mysql/ /mysql/etc /mysql/data

shell-mysql1\> sudo mkdir /mysql/log /mysql/temp /mysql/binlog

5. To simplify the lab, add the mysql bin folder to the bash profile
    and customize the client prompt.\
    Please insert these lines at the end of the file /home/opc/.bashrc

> export PATH=\$PATH:/mysql/mysql-latest/bin
>
> export MYSQL_PS1=\"\\\\u on \\\\h\>\\\\\_\"

a.  You can edit the file with the editor that you prefer, here some
    examples

> shell-mysql1\> nano /home/opc/.bashrc
>
> shell-mysql1\> vi /home/opc/.bashrc

6. **Close the ssh session and reopen it to activate the new privilege
    and settings for opc user**

7. Extract the tarball in your /mysql folder

shell-mysql1\> cd /mysql/

shell-mysql1\> sudo tar xvf
/workshop/linux/mysql-commercial-8.0.\*-linux-glibc2.12-x86_64.tar.xz

8. Create a symbolic link to mysql binary installation

shell-mysql1\> sudo ln -s mysql-commercial-8.0.\*-linux-glibc2.12-x86_64
mysql-latest

9. Create a new configuration file my.cnf inside /mysql/etc\
    To help you we created one with some variables, please copy it

shell-mysql1\> sudo cp /workshop/support/my.cnf.mysql1 /mysql/etc/my.cnf

10. Check the content of the configuration file to have a look inside.\
    Please note that, because the port 3306 is already in use by the
    community server previously installed , we use now port 3307.

shell-mysql1\> cat /mysql/etc/my.cnf

11. For security reasons change ownership and permissions

shell-mysql1\> sudo chown -R mysqluser:mysqlgrp /mysql

shell-mysql1\> sudo chmod -R 750 /mysql

The following permission is for the Lab purpose so that opc account can
make changes and copy files to overwrite the content

shell-mysql1\> sudo chmod -R 770 /mysql/etc

12. Save the changes, log out and log in again from the ssh for the
    changes to take effect on the user profile.initialize your database

shell-mysql1\> sudo /mysql/mysql-latest/bin/mysqld
\--defaults-file=/mysql/etc/my.cnf \--initialize \--user=mysqluser

13. Start your new mysql instance

shell-mysql1\> sudo /mysql/mysql-latest/bin/mysqld
\--defaults-file=/mysql/etc/my.cnf \--user=mysqluser &

14. Verify that process is running

shell-mysql1\> ps -ef \| grep mysqld

shell-mysql1\> netstat -an \| grep 3307

15. Another way is searching the message "ready for connections" in
    error log as one of the last

shell-mysql1\> grep -i ready /mysql/log/err_log.log

16. Retrieve root password for first login

shell-mysql1\> grep -i \'temporary password\' /mysql/log/err_log.log

17. Before version 5.7 it was recommended to run the \'
    mysql_secure_installation \' script. From version 5.7 all these
    settings are "by default", but the script can be used also to setup
    the validate_password plugin (used later). Execute now
    mysql_secure_installation

shell-mysql1\> /mysql/mysql-latest/bin/mysql_secure_installation
-h127.0.0.1 -P3307

using these values

- root password: retrieved from previous step

- new password: Welcome1!

- setup VALIDATE PASSWORD component: Y

- password validation policy: 2

- Change the password for root: N

- Remove anonymous users: Y

- Disallow root login remotely: N

- Remove test database: Y

- Reload privilege tables now: Y

18. Login to you mysql-advanced installation and check the status.

shell-mysql1\> mysql -uroot -p -h 127.0.0.1 -P3307

mysql\> status

19. Shutdown the service

mysql\> exit

shell-mysql1\> mysqladmin -uroot -h127.0.0.1 -p -P3307 shutdown

20. Configure automatic startup and shutdown with system.\
    Add a systemd service unit configuration file with details about the
    MySQL service. The file is named mysqld.service and is placed in
    /usr/lib/systemd/system. We created one for you (See addendum for
    the content)

shell-mysql1\> sudo cp /workshop/support/mysqld-advanced.service
/usr/lib/systemd/system/

shell-mysql1\> sudo chmod 644
/usr/lib/systemd/system/mysqld-advanced.service

shell-mysql1\> sudo systemctl enable mysqld-advanced.service

21. Test start, stop and restart

shell-mysql1\> sudo systemctl start mysqld-advanced

shell-mysql1\> sudo systemctl status mysqld-advanced

shell-mysql1\> sudo systemctl stop mysqld-advanced

shell-mysql1\> sudo systemctl status mysqld-advanced

shell-mysql1\> sudo systemctl restart mysqld-advanced

shell-mysql1\> sudo systemctl status mysqld-advanced

22. Create a new administrative user called \'admin\' with remote access
    and full privileges

shell-mysql1\> mysql -uroot -p -h 127.0.0.1 -P3307

mysql\> CREATE USER \'admin\'@\'%\' IDENTIFIED BY \'Welcome1!\';

mysql\> GRANT ALL PRIVILEGES ON \*.\* TO \'admin\'@\'%\' WITH GRANT
OPTION;

23. The configuration file was specified to load the commercial Thread
    Pool Plugin, check if it's loaded and active. Here we use the same
    command with different output (";" vs "\\G" as line termination)
    \*\*plf\*\*

mysql\> select \* from information_schema.plugins where plugin_name like
\'thread%\';

mysql\> select \* from information_schema.plugins where plugin_name like
\'thread%\'\\G

# 2d) Verify the new MySQL Installation on Linux and import test databases

Objectives:

- understand better how MySQL connection works

- install test databases for labs (world and employees)

- have a look on useful statements

Server: mysql1

1. If not already connected, connect to mysql1 server through app-srv

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql1 mysql1

2. Discussion about MySQL connections.

Please note that now you have 2 instances on the same server: one on
3306 (Commercial) and one on 3307 (Community).\
MySQL (as default) interpret localhost as socket and not the 127.0.0.1
TCP address.

This may end with strange behaviors and errors

Here we practice connecting in various way and check what is working and
what is not (note: port 3310 is intentionally wrong).

3. Use the command in table below to test different connection strings
    and check the result.

If the result is not clear to you, please ask an explanation to your
instructor.

Please note that "-p" lowercase refers to password, "-P" uppercase refer
to the TCP port.

Don't be confused by the client version and check these lines, to
understand "why" (not all are always available...)

> Current user:
>
> Connection:
>
> UNIX socket:
>
> TCP port:
>
> Server version:

+-------------------------------------------------+-----+---+---------+
| **Command**                                     | *|* | **Conne |
|                                                 | *33 | * | ction** |
|                                                 | 06\ | S |         |
|                                                 | or\ | S | **Socke |
|                                                 | 330 | L | t/TCP** |
|                                                 | 7** | * |         |
|                                                 |     | * |         |
|                                                 |     |   |         |
|                                                 |     | * |         |
|                                                 |     | * |         |
|                                                 |     | Y |         |
|                                                 |     | / |         |
|                                                 |     | N |         |
|                                                 |     | * |         |
|                                                 |     | * |         |
+=================================================+=====+===+=========+
| shell\> mysql -u root -p                        |     |   |         |
|                                                 |     |   |         |
| mysql\> status                                  |     |   |         |
+-------------------------------------------------+-----+---+---------+
| shell\> mysql -u root -p -P3306                 |     |   |         |
|                                                 |     |   |         |
| mysql\> status                                  |     |   |         |
+-------------------------------------------------+-----+---+---------+
| shell\> mysql -u root -p -P3307                 |     |   |         |
|                                                 |     |   |         |
| mysql\> status                                  |     |   |         |
+-------------------------------------------------+-----+---+---------+
| shell\> mysql -uroot -p -h localhost -P3310     |     |   |         |
|                                                 |     |   |         |
| mysql\> status                                  |     |   |         |
+-------------------------------------------------+-----+---+---------+
| shell\> mysql -uadmin -p -h 127.0.0.1 -P3307    |     |   |         |
|                                                 |     |   |         |
| mysql\> status                                  |     |   |         |
+-------------------------------------------------+-----+---+---------+
| shell\> mysql -uadmin -p -h mysql1 -P3307       |     |   |         |
|                                                 |     |   |         |
| mysql\> status                                  |     |   |         |
|                                                 |     |   |         |
| Note: we are using here the hostname            |     |   |         |
+-------------------------------------------------+-----+---+---------+
| shell\> mysql -uroot -p -S                      |     |   |         |
| /var/lib/mysql/mysql.sock                       |     |   |         |
|                                                 |     |   |         |
| mysql\> status                                  |     |   |         |
+-------------------------------------------------+-----+---+---------+
| shell\> mysql -uroot -p -S                      |     |   |         |
| /mysql/temp/mysql.sock                          |     |   |         |
|                                                 |     |   |         |
| mysql\> status                                  |     |   |         |
+-------------------------------------------------+-----+---+---------+

4. Now that we better understand how to connect, we can remove the
    community installation \*\*plf\*\*

shell-mysql1\> sudo yum remove mysql-server \*\*plf\*\* do not remove
mysql client

5. Import the world database, that will be used later, from
    c:\\workshop\\databases\\world

    a.  You can do it with mysql client

> shell-mysql1\> mysql -uadmin -p -P3307 -h mysql1 \<
> /workshop/databases/world/world.sql

6. Import the employees demo database that is in /workshop/databases
    folder.

shell-mysql1\> cd /workshop/databases/employees

shell-mysql1\> mysql -uadmin -p -P3307 -h mysql1 \< ./employees.sql

7. Have a look to these useful SQL Statements:

shell-mysql1\> mysql -uadmin -p -h mysql1 -P 3307

mysql\> SHOW VARIABLES LIKE \"%version%\";

mysql\> SELECT table_name, engine FROM INFORMATION_SCHEMA.TABLES WHERE
engine \<\> \'InnoDB\';

mysql\> SELECT table_name, engine FROM INFORMATION_SCHEMA.TABLES WHERE
engine = \'InnoDB\';

mysql\> SELECT table_name, engine FROM INFORMATION_SCHEMA.TABLES where
engine = \'InnoDB\' and table_schema not in
(\'mysql\',\'information_schema\', \'sys\');

mysql\> SELECT ENGINE, COUNT(\*), SUM(DATA_LENGTH)/ 1024 / 1024 AS
\'Data MB\', SUM(INDEX_LENGTH)/1024 / 1024 AS \'Index MB\' FROM
information_schema.TABLEs group by engine;

mysql\> SELECT table_schema AS \'Schema\', SUM( data_length ) / 1024 /
1024 AS \'Data MB\', SUM( index_length ) / 1024 / 1024 AS \'Index MB\',
SUM( data_length + index_length ) / 1024 / 1024 AS \'Sum\' FROM
information_schema.tables GROUP BY table_schema ;

> the "\\G" is like ";" with a different way to show results

mysql\> SHOW GLOBAL VARIABLES\\G

mysql\> SHOW GLOBAL STATUS\\G

mysql\> SHOW FULL PROCESSLIST;

mysql\> SHOW ENGINE INNODB STATUS\\G

# 2e) MySQL Shell: the new client

Objective: Execute MySQL Shell and explore the interface:

- help

- settings

- test an extension: reporting

- command mode

Server: mysql1

Note: to close the MySQL Shell you can the commands "\\q" or "\\exit"

1. If not already connected, connect to mysql1 server trhougth app-srv

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql1 mysql1

2. Install Mysql Shell, a new client that can be used in devOps
    organizations (you'll learn more about it during the course)

shell-mysql1\> sudo yum install
/workshop/linux/mysql-shell-commercial-8.0.\*.rpm

3. Launch MySQL shell

shell-mysql1\> mysqlsh

4. Discover the command auto-completion feature, type \\h and press TAB
    twice

MySQL JS \> \\h \[tab\] \[tab\]

5. Check the available options. Add the letter "e" to "\\h" and press
    TAB again to see that the command will automatically complete for
    you. Press enter and explore the help menu

MySQL JS \> \\he \[tab\]

6. Activate the command history autosave in MySQL shell\
    MySQL Shell comes with the option of automatically saving the
    history of command disabled by default. Therefore we need to check
    and to activate it.

    a.  Show settings and look for history.autoSave

MySQL JS \> \\option -l

b.  activate autosave history

MySQL JS \> \\option \--persist history.autoSave=1

7. Close and reopen the session and in the new one **uses the arrow up
    key** to verify that the data from previous session are available

MySQL JS \> \\exit

> shell-mysql1\> mysqlsh

8. MySQL Shell can be used as SQL client

    a.  Connect to the newly installed mysql-advanced instance. Enter
        the password when requested and press enter. When the prompt
        asks to save the password choose No and press Enter.

MySQL JS \> \\c admin@mysql1:3307

b.  Switch to SQL mode

MySQL ... JS \> \\sql

9. Now you can submit SQL commands

MySQL ... SQL \> show databases;

MySQL ... SQL \> SELECT \* FROM world.city LIMIT 10;

10. But MySQL Shell has also nice features. Here we see one of them:
    reporting.\
    If you want to execute a command continuously use the command
    "query" (default refresh time: 5 seconds).\
    To exit from reporting press CTRL+C

MySQL ... SQL \> \\watch query show processlist;

MySQL ... SQL \> \\watch query \--interval=2 show processlist;

11. Switch to Python command mode, then Javascript command mode, check
    how prompt change

MySQL ... SQL \> \\py

MySQL ... Py \> \\js

12. Exit from MySQL Shell with "\\q" or "\\exit"

MySQL ... JS \> \\q

13. Command line connection from MySQL Client and MySQL Shell are
    similar (just specify "\--sql"). Try these

shell-mysql1\> mysql -uadmin -p -hmysql1 -P3307

mysql\> SHOW DATABASES;

mysql\> exit

shell-mysql1\> mysqlsh \--sql -uadmin -p -hmysql1 -P3307

MySQL ... SQL \> SHOW DATABASES;

MySQL ... SQL \> \\exit

14. From now on, if you like, the labs may be completed with MySQL Shell
    instead of classic mysql client.

# 3a) Database Design

Objective: Working with SQL

Server: mysql1

1. To start the lab connect to your **mysql-advanced** with admin user
    \*\*plf\*\*

shell\> mysql -uadmin -p -P3307 -hmysql1

2. Create a new table poi

mysql\> use world;

mysql\> CREATE TABLE if not exists poi (x Int, y INT, z INT);

3. Add to the table a new column for id used for large integer values

mysql\> alter table poi add id bigint;

mysql\> ALTER TABLE poi ADD PRIMARY KEY (id);

4. Create a copy of your city table

mysql\> create table city_part as select \* from city;

5. How many records does it contain?

mysql\> SELECT count(\*) FROM city_part;

6. How many records city table contain?

mysql\> SELECT count(\*) FROM city;

7. Verify the difference of the two table creation (there is a big
    one!)

mysql\> show create table city\\G

mysql\> show create table city_part\\G

8. Create an index on new table

mysql\> CREATE INDEX myidindex ON city_part (ID);

9. Check table statistics. What is the Cardinality (=unique records) of
    primary key?

mysql\> SELECT \* FROM INFORMATION_SCHEMA.STATISTICS WHERE table_name =
\'city\' and table_schema=\'world\'\\G

10. Create a new index

mysql\> CREATE INDEX myccindex ON city_part (CountryCode);

11. Delete some columns (Population and CountryCode)

mysql\> ALTER TABLE city_part DROP COLUMN Population;

mysql\> ALTER TABLE city_part DROP COLUMN CountryCode;

12. Optimize the table

mysql\> OPTIMIZE TABLE city_part;

warning is expected:
<https://dev.mysql.com/doc/refman/8.0/en/optimize-table.html>

13. Update table statistics

mysql\> ANALYZE TABLE city_part;

to mysql1, do it now

14. Create partitions:

    a.  Check the files for the city_part table on your disk. We can do
        it from the mysql client using the built-in function "system"

shell-mysql1\> system ls -l /mysql/data/world

b.  Partition your table into 5 segments based on hash

mysql\> ALTER TABLE world.city_part PARTITION BY HASH (id) PARTITIONS 5;

c.  Check the file of the city_part table on your disk

shell-mysql1\> system ls -l /mysql/data/world

# 3b) MySQL JSON datatype

Objective: practice with JSON

Server: mysql1

Notes:

- The lab can be completed from app-srv \*\*plf\*\* What does this
    mean?

1. Create a database for JSON tests

mysql\> CREATE DATABASE json_test;

mysql\> USE json_test;

2. Create a JSON table

mysql\> CREATE TABLE jtest (id bigint NOT NULL AUTO_INCREMENT, doc JSON,
PRIMARY KEY (id));

mysql\> SELECT \* FROM jtest;

3. add data to this table

mysql\> INSERT INTO jtest(doc) VALUE(\'{\"A\": \"hello\", \"b\":
\"test\", \"c\": {\"hello\": 1}}\');

mysql\> INSERT INTO jtest(doc) VALUE(\'{\"b\": \"hello\"}\'),(\'{\"c\":
\"help\"}\');

mysql\> SELECT \* FROM jtest;

4. Retrieve json documents with these commands (note the shortcut
    "-\>")

mysql\> SELECT json_extract (doc, \"\$.b\") FROM jtest;

mysql\> SELECT doc-\>\"\$.b\" FROM jtest;

mysql\> SELECT json_extract (doc, \"\$.c\") FROM jtest;

mysql\> SELECT doc-\>\"\$.b\" from jtest;

mysql\> SELECT doc-\>\>\"\$.b\" from jtest;

5. Create Index on the virtual column

mysql\> alter table jtest add column gencol CHAR(7) AS (doc-\>\"\$.b\");

mysql\> CREATE INDEX myvirtindex ON jtest(gencol);

mysql\> SELECT \* FROM jtest;

# 3c) MySQL Document Store

Objective: Understanding the functioning of MySQL Document Store and
practicing some CRUD operations.

Server: mysql1

Notes:

- The lab can be completed from app-srv

- Please note that we use the port for Xdev (33070) instead of usual
    classic protocol port (3307)

1. Please connect to MySQL Database via X Protocol

shell\> mysqlsh -uadmin -hmysql1 -P33070 -p

2. Create and use a test schema. (We use javascript mode, but python is
    available also)

MySQL ... JS \> session.createSchema(\'docstore\')

MySQL ... JS \> \\use docstore

3. Now create and populate a small collection

MySQL ... JS \> db.createCollection(\'posts\');

MySQL ... JS \> db.posts.add({\"title\":\"MySQL 8.0 rocks\",
\"text\":\"My first post!\", \"code\": \"42\"})

MySQL ... JS \> db.posts.add({\"title\":\"Polyglot database\",
\"text\":\"Developing both SQL and NoSQL applications\"})

4. Checking the built-in JSON validation

MySQL ... JS \> db.posts.add(\"This is not a valid JSON document\")

5. Inspect the posts collection you have just created

MySQL ... JS \> db.posts.find()

What can you notice? Did the system add something to content by itself?\
\
MySQL ... JS \> db.posts.find().limit(1)

6. Modify existing elements of the collection

MySQL ... JS \> db.posts.modify(\"title = \'MySQL 8.0
rocks\'\").set(\"title\", \" MySQL 8.0 rocks!!!\")

MySQL ... JS \> db.posts.find()

7. Check that that a collection is just a table with 2 columns: Index
    and JSON Document

MySQL ... JS \> session.sql(\"desc posts\")

MySQL ... JS \> session.sql(\"show create table posts\")

MySQL ... JS \> session.sql(\"select \* from posts\")

8. Therefore, it is possible to add indexes on specific JSON elements
    of the collection

MySQL ... JS \> db.posts.createIndex(\'myIndex\', {fields: \[{field:
\"\$.title\", type: \"TEXT(20)\"}\]} )

MySQL ... JS \> session.sql(\"show create table posts\")

# 4a) Users management

Objective: explore user creation and privileges

Servers:

- app-srv as client (appuser)

- mysql1 as server (root)

Notes:

- use two shells, both can be from app-srv

1. If not already connected, connect to app-srv and retrieve the
    Private IP (this info is also available in OCI dashboard)

shell-app-srv\> ifconfig \| grep 10.0.0

App-srv **PRIVATE** ip:
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
(**client_ip**)

2. Keep previous connection open and open a new connection to mysql1
    server through app-srv \*\*plf\*\*

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql1 mysql1

3. Connect to your mysql-advanced with administrative user (**keep it
    open**)

shell\> mysql -uadmin -p -h mysql1 -P 3307

a.  Create a new user and restrict the user to your "app-srv" IP

mysql\> CREATE USER \'appuser\'@\<app-srv_ip\> IDENTIFIED BY
\'Welcome1!\';

mysql\> GRANT ALL PRIVILEGES ON world.\* TO \'appuser\'@\<app-srv_ip\>;

mysql\> SHOW GRANTS FOR \'appuser\'@\<app-srv_ip\>;

4. Open **a new shell** on the app-srv install the clients to test
    appuser connection

    a.  Install mysql client and mysqlsh

shell-app-srv\> sudo yum -y install /workshop/linux/client/\*.rpm

b.  connect to mysql-advanced with appuser

shell-app-srv\> mysql -u appuser -p -h mysql1 -P 3307

c.  Run a select on the tables e.g.

mysql\> USE world;

mysql\> SELECT \* FROM city;

5. (admin connection) Switch to the administrative connection revoke
    privilege on city to appuser

mysql\> REVOKE SELECT ON world.\* FROM \'appuser\'@\<app-srv_ip\>;

mysql\> SHOW GRANTS FOR \'appuser\'@\<app-srv_ip\>;

6. (appuser connection) Repeat the select on for the user. There is a
    difference?

mysql\> SELECT \* FROM city;

7. (appuser connection) Close and reopen the appuser connection, then
    repeat above commands. There is a difference?

mysql\> exit

shell-app-srv\> mysql -u appuser -p -h mysql1 -P 3307

mysql\> SHOW DATABASES;

mysql\> USE world;

mysql\> SELECT \* FROM city;

8. (admin connection) Switch to the administrative connection revoke
    'USAGE' privilege using and administrative connection and verify
    (tip: this privilege can't be revoked...)

mysql\> REVOKE USAGE ON \*.\* FROM \'appuser\'@\<app-srv_ip\>;

mysql\> SHOW GRANTS FOR \'appuser\'@\<app-srv_ip\>;

9. (admin connection) Using the administrative connection revoke all
    privileges using and administrative connection and verify

mysql\> REVOKE ALL PRIVILEGES ON \*.\* FROM \'appuser\'@\<app-srv_ip\>;

mysql\> SHOW GRANTS FOR \'appuser\'@\<app-srv_ip\>;

10. (appuser connection) Close and reopen appuser session, do you see
    schemas?

mysql\> exit

shell-app-srv\> mysql -u appuser -p -h mysql1 -P 3307

mysql\> SHOW DATABASES;

11. (admin connection) Using the administrative connection restore user
    privileges to reuse it in next labs

mysql\> GRANT ALL PRIVILEGES ON world.\* TO \'appuser\'@\<app-srv_ip\>;

12. (admin connection) Using the administrative connection, what are
    your password settings?

mysql\> SHOW VARIABLES LIKE \'validate_password%\';

13. (appuser connection) Try to set unsecure passwords for appuser

mysql\> alter user \'appuser\'@\<app-srv_ip\> identified by \'appuser\';

mysql\> alter user \'appuser\'@\<app-srv_ip\> identified by \'Welcome\';

mysql\> alter user \'appuser\'@\<app-srv_ip\>identified by \'We1!\';

14. (admin connection) Expire the password for appuser

mysql\> alter user \'appuser\'@\<app-srv_ip\> PASSWORD EXPIRE;

15. (appuser connection) Close and reopen connection to mysql-advanced
    and try to submit a command. What changed?

shell-app-srv\> mysql -u appuser -p -h mysql1 -P 3307 \*\*plf\*\* fixed
-u

mysql\> SHOW DATABASES;

mysql\> alter user \'appuser\'@\<app-srv_ip\> identified by
\'Welcome1!\';

# 4b) MySQL Roles

Objective: Discover and Configure roles

Servers:

- App-srv can be used for the exercise

- mysql1 is the MySQL Server

1. If not already connected, connect to mysql1 through app-srv

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql1 mysql1

2. Reconnect to MySQL instance as admin to create a new user

shell\> mysql -u admin -p -h mysql1 -P 3307

mysql\> CREATE USER \'appuser2\'@\'%\' IDENTIFIED BY \'Welcome1!\';

mysql\> SHOW GRANTS FOR \'appuser2\'@\'%\';

3. Now create a new role and grant it to the new user

mysql\> CREATE ROLE \'app_read\';

mysql\> GRANT SELECT ON world.\* TO \'app_read\';

mysql\> GRANT \'app_read\' TO \'appuser2\'@\'%\';

mysql\> SHOW GRANTS FOR \'appuser2\'@\'%\';

mysql\> exit

4. Connect now as appuser2 and submit some commands (you receive
    errors, why?)

shell\> mysql -u appuser2 -p -h mysql1 -P 3307

mysql\> SHOW DATABASES;

mysql\> SELECT COUNT(\*) FROM world.city;

mysql\> SELECT current_role();

5. Set the role for the user and repeat above commands

mysql\> SET ROLE ALL;

mysql\> SELECT current_role();

mysql\> SHOW DATABASES;

mysql\> SELECT COUNT(\*) FROM world.city;

6. We can also assign a default role to avoid asking to set one after
    every login

mysql\> ALTER USER \'appuser2\'@\'%\' DEFAULT ROLE \'app_read\';

# 4c) MySQL Enterprise Firewall -- Account profiles

Objective: Firewall with Account profiles

Server: mysql1

Notes:

- We work here with account profiles, because used also in MySQL 5.6
    and 5.7

- Group profiles have the same approach

- References

  - <https://dev.mysql.com/doc/refman/8.0/en/firewall-installation.html>

1. If not already connected, connect to mysql1 through app-srv

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql1 mysql1

2. Install MySQL Enterprise Firewall on
    **[mysql-advanced]{.underline}** using CLI

shell-mysql1\> mysql -uadmin -p -P3307 -h mysql1 \<
/mysql/mysql-latest/share/linux_install_firewall.sql

3. Connect to the instance with administrative account **first SSH
    connection - administrative**

shell-mysql1\> mysql -uadmin -p -P3307 -hmysql1

mysql\> SHOW GLOBAL VARIABLES LIKE \'mysql_firewall_mode\';

mysql\> SHOW GLOBAL STATUS LIKE \"firewall%\";

4. Create a new user \'fwtest\' and assign full privileges to database
    world

mysql\> CREATE USER \'fwtest\'@\'%\' IDENTIFIED BY \'Welcome1!\';

mysql\> GRANT ALL PRIVILEGES ON world.\* TO \'fwtest\'@\'%\';

5. Now we set firewall in recording mode, to create a white list and
    verify that allowlist is empty

mysql\> CALL mysql.sp_set_firewall_mode(\'fwtest@%\', \'RECORDING\');

mysql\> SELECT \* FROM mysql.firewall_users;

mysql\> SELECT \* FROM mysql.firewall_whitelist;

6. Open a **second SSH connection** and use it to connect as "fwtest"
    from app-srv

shell-mysql1\> mysql -ufwtest -p -P3307 -hmysql1

mysql\> USE world;

mysql\> SELECT \* FROM city limit 25;

mysql\> SELECT Code, Name, Region FROM country WHERE population \>
200000;

7. Administrative connection: Return to admin session (**first SSH
    connection terminal**) and verify that there are now rules in
    allowlist (noticed that we interrogate temporary rules from
    information schema)

mysql\> SELECT \* FROM information_schema.mysql_firewall_whitelist;

8. Administrative connection: switch Firewall mode from \'recording\'
    to \'protecting\' and verify the presence of rules in allowlist

mysql\> CALL mysql.sp_set_firewall_mode(\'fwtest@%\', \'PROTECTING\');

mysql\> SELECT \* FROM mysql.firewall_whitelist;

9. fwtest connection: run these commands. Which one's work? Which ones
    fail and why?

mysql\> USE world;

mysql\> SELECT \* FROM city limit 25;

mysql\> SELECT Code, Name, Region FROM country WHERE population \>
200000;

mysql\> SELECT \* FROM countrylanguage;

mysql\> SELECT Code, Name, Region FROM country WHERE population \>
500000;

mysql\> SELECT Code, Name, Region FROM country WHERE population \>
200000 or 1=1;

10. Administrative connection: set firewall in detecting mode in your

mysql\> CALL mysql.sp_set_firewall_mode(\'fwtest@%\', \'DETECTING\');

mysql\> SET GLOBAL log_error_verbosity=3;

11. fwtest connection: Repeat a blocked command (it works? Why?
    \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_)

mysql\> SELECT Code, Name, Region FROM world.country WHERE population \>
200000 or 1=1;

12. Search the error in the error log.

shell-mysql1\> grep \"MY-011191\" /mysql/log/err_log.log

13. Administrative connection: Error log can also be interrogated also
    from the client.

mysql\> select \* from performance_schema.error_log order by LOGGED DESC
limit 5;

14. Disable now the firewall

mysql\> CALL mysql.sp_set_firewall_mode(\'fwtest@%\', \'OFF\');

mysql\> SELECT MODE FROM INFORMATION_SCHEMA.MYSQL_FIREWALL_USERS WHERE
USERHOST = \'fwtest@%\';

mysql\> SELECT RULE FROM INFORMATION_SCHEMA.MYSQL_FIREWALL_WHITELIST
WHERE USERHOST = \'fwtest@%\';

# 4d) MySQL Enterprise Firewall -- Group profiles

Objective: Firewall with Account profiles

Server: mysql1

Notes:

- This lab continue the previous

1. If not already connected, connect to mysql1 through app-srv

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql1 mysql1

2. Connect to the instance with administrative account and create a new
    user \'fwtest2\', then assign full privileges to database world

shell-mysql1\> mysql -uadmin -p -P3307 -hmysql1

mysql\> CREATE USER \'fwtest2\'@\'%\' IDENTIFIED BY \'Welcome1!\';

mysql\> GRANT ALL PRIVILEGES ON world.\* TO \'fwtest2\'@\'%\';

3. Grant firewall management privilege to admin and exclude it from
    firewall checks

mysql\> GRANT FIREWALL_ADMIN, FIREWALL_EXEMPT on \*.\* to admin@\'%\';

4. Now create a firewall group profile in recording mode, and add the
    new user

mysql\> CALL mysql.sp_set_firewall_group_mode(\'fwgrp\', \'RECORDING\');

mysql\> CALL mysql.sp_firewall_group_enlist(\'fwgrp\', \'fwtest@%\');

5. Open a **second SSH connection** and use it to connect as "fwtest2"
    from app-srv

shell-mysql1\> mysql -ufwtest2 -p -P3307 -hmysql1

mysql\> USE world;

mysql\> SELECT \* FROM city limit 25;

mysql\> SELECT Code, Name, Region FROM country WHERE population \>
200000;

6. Administrative connection: Return to admin session (**first SSH
    connection terminal**) and verify that there are now rules in
    allowlist

mysql\> SELECT RULE FROM performance_schema.firewall_group_allowlist
WHERE NAME = \'fwgrp\';

7. Administrative connection: switch Firewall mode from \'recording\'
    to \'protecting\' and verify the presence of rules in allowlist

mysql\> CALL mysql.sp_set_firewall_group_mode(\'fwgrp\',
\'PROTECTING\');

8. Fwtest2 connection: run these commands. Which one's work? Which ones
    fail and why?

mysql\> USE world;

mysql\> SELECT \* FROM city limit 25;

mysql\> SELECT Code, Name, Region FROM country WHERE population \>
200000;

mysql\> SELECT \* FROM countrylanguage;

mysql\> SELECT Code, Name, Region FROM country WHERE population \>
500000;

mysql\> SELECT Code, Name, Region FROM country WHERE population \>
200000 or 1=1;

9. Disable now the firewall

mysql\> CALL mysql.sp_set_firewall_group_mode(\'fwgrp\', \'OFF\');

# 4e) MySQL Enterprise Audit

Objective: Auditing in action...

Notes:

- Audit can be activated and configured without stop the instance.\
    In this lab we edit my.cnf and restart the instance just to see how
    to update my.cnf

Server: mysql1

1. If not already connected, connect to mysql1 through app-srv

2. Enable Audit Log on mysql-advanced (remember: you can't install on
    mysql-gpl). Audit is COMMERCIAL plugin.

    a.  Edit the my.cnf setting in /mysql/etc/my.cnf

> shell-mysql1\> sudo nano /mysql/etc/my.cnf

b.  Change the line "plugin-load=thread_pool.so" to load the plugin

plugin-load=thread_pool.so;audit_log.so

c.  **[below the previous]{.underline}** add these lines to make sure
    that the audit plugin can\'t be unloaded and that the file is
    automatically rotated at 20 MB

audit_log=FORCE_PLUS_PERMANENT

audit_log_rotate_on_size=20971520

d.  Restart MySQL (you can configure audit without restart the server,
    but here we show how to set the configuration file)

shell-mysql1\> sudo systemctl restart mysqld-advanced

3. Login to a mysql-advanced with the user "appuser", then submit some
    commands

shell-mysql1\> mysql -u appuser2 -p -h mysql1 -P 3307

mysql\> USE world;

mysql\> SELECT \* FROM city limit 25;

mysql\> SELECT Code, Name, Region FROM country WHERE population \>
200000;

4. Open the audit.log file the datadir and verify the content

shell-mysql1\> nano /mysql/data/audit.log

5. You can check the documentation about other Log policies

# 4f) Data Masking and de-identification

Objective: Install and use data masking functionalities

Notes:

- The lab can be completed from app-srv

- Data masking has more functions than what we test in the lab. The
    full list of functions is here

  - <https://dev.mysql.com/doc/refman/5.7/en/data-masking-usage.html>

Server: mysql1

1. Install the data masking plugin

shell\> mysql -uadmin -p -h mysql1 -P 3307

mysql\> INSTALL PLUGIN data_masking SONAME \'data_masking.so\';

mysql\> SHOW PLUGINS;

2. Look for data_masking and check the status? Is it active?

3. Install some masking functions

mysql\> CREATE FUNCTION gen_range RETURNS INTEGER SONAME
\'data_masking.so\';

mysql\> CREATE FUNCTION gen_rnd_email RETURNS STRING SONAME
\'data_masking.so\';

mysql\> CREATE FUNCTION gen_rnd_us_phone RETURNS STRING SONAME
\'data_masking.so\';

mysql\> CREATE FUNCTION mask_inner RETURNS STRING SONAME
\'data_masking.so\';

mysql\> CREATE FUNCTION mask_outer RETURNS STRING SONAME
\'data_masking.so\';

4. Use data masking functions

mysql\> SELECT mask_inner(NAME, 1,1) FROM world.city limit 10;

mysql\> SELECT mask_outer(NAME, 1,1) FROM world.city limit 10;

5. Discuss differences between mask_inner and mask_outer

mysql\> SELECT mask_inner(NAME, 1,1, \'&\') FROM world.city limit 1;

6. Use data masking random generators executing these statements
    several times

mysql\> SELECT gen_range(1, 200);

mysql\> SELECT gen_rnd_us_phone();

mysql\> SELECT gen_rnd_email();

# 5a) MySQL logical backup (mysqldump)

Objective: explore how mysqldump works

Server: mysql1

Notes:

- Reference:

  - <https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html>

1. Create the export folder

shell\> sudo mkdir -p /mysql/exports

shell\> sudo chown mysqluser:mysqlgrp /mysql/exports/

shell\> sudo chmod 770 /mysql/exports/

2. Export all the data with mysqldump

shell\> mysqldump -uadmin -p -hmysql1 -P3307 \--single-transaction
\--events \--routines \--flush-logs \--all-databases \>
/mysql/exports/full.sql

3. Watch the content of the file /mysql/exports/full.sql

4. Export employees database

shell\> mysqldump -uadmin -p -hmysql1 -P3307 \--single-transaction
\--set-gtid-purged=OFF \--databases employees \>
/mysql/exports/employees.sql

5. Drop employees database

shell\> mysql -uadmin -p -hmysql1 -P3307

mysql\> show databases;

mysql\> DROP DATABASE employees;

mysql\> show databases;

6. Import the employees database.\
    It can be done in shell (as when we loaded first example data) or
    from within the mysql client.

mysql\> SOURCE /mysql/exports/employees.sql

mysql\> show databases;

> mysql\> show tables in employees;

# 5b) MySQL Shell dump&load

Objective: explore how MySQL Shell works

Server: mysql1

Notes:

- Reference:

  - <https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html>

\*\*plf\* I think you mean this:
<https://dev.mysql.com/doc/mysql-shell/8.0/en/mysql-shell-install.html>

# 5c) MySQL Enterprise Backup

Objective: explore how mysqlbackup works

Server: mysql1

Notes:

- We work now with **mysql-advanced** instance

- References:

  - <https://dev.mysql.com/doc/mysql-enterprise-backup/8.0/en/mysqlbackup.tasks.html>

  - <https://dev.mysql.com/doc/mysql-enterprise-backup/8.0/en/mysqlbackup.privileges.html>

1. MySQL Enterprise Backup is now available inside MySQL Enterprise
    Distributions like a tool, so you don't have to install it.

2. Create directories to store backups

shell\> sudo mkdir -p /backupdir/full

shell\> sudo mkdir /backupdir/compressed

shell\> sudo chown -R mysqluser:mysqlgrp /backupdir

shell\> sudo chmod 770 -R /backupdir

3. Create a user in **mysql-advanced** with grants options for backup.
    To simplify user creations we have a script with minimal grants for
    this user (see the manual for additional privileges required for
    specific features like TTS, SBT integration, encrypted). You can
    also have a look on the privileges opening the file
    /workshop/support/mysqlbackup_user_grants.sql

shell\> mysql -uadmin -p -hmysql1 -P3307

mysql\> CREATE USER \'mysqlbackup\'@\'%\' IDENTIFIED BY \'Welcome1!\';

mysql\> source /workshop/support/mysqlbackup_user_grants.sql;

mysql\> exit

4. Create a full backup (be careful with copy&paste!).

shell\> mysqlbackup \--port=3307 \--host=127.0.0.1 \--protocol=tcp
\--user=mysqlbackup \--password \--backup-dir=/backupdir/full
backup-and-apply-log

5. Create a second backup with compression (be careful with
    copy&paste!)

shell\> mysqlbackup \--port=3307 \--host=127.0.0.1 \--protocol=tcp
\--user=mysqlbackup \--password \--backup-dir=/backupdir/compressed
\--compress backup-and-apply-log

6. Because these backups are created with sudo, change the permissions

shell\> sudo chown -R mysqluser:mysqlgrp /backupdir/full

shell\> sudo chown -R mysqluser:mysqlgrp /backupdir/compressed

7. Have a look of the content of the backup folders

shell\> cd /backupdir/full

shell\> ls -l

shell\> cd /backupdir/compressed

shell\> ls -l

8. Check the size of the two backups, the one uncompressed and the one
    compressed

shell\> cd /backupdir

shell\> du -sh \*

9. Restore

    a.  Stop the server

shell\> sudo systemctl stop mysqld-advanced

b.  (**destroy time**!) empty datadir and move binary log dir

shell\> sudo rm -rf /mysql/data/\*

shell\> sudo mkdir /mysql/binlog.old

shell\> sudo chown mysqluser:mysqlgrp /mysql/binlog.old

shell\> sudo chmod -R 750 /mysql/binlog.old

shell\> sudo mv /mysql/binlog/\* /mysql/binlog.old/

c.  Restore the backup (be careful with copy&paste!).\
    We execute mysqlbackup as root because of permission in destination
    folders

shell\> sudo /mysql/mysql-latest/bin/mysqlbackup
\--defaults-file=/mysql/etc/my.cnf \--backup-dir=/backupdir/full/
\--datadir=/mysql/data \--log-bin=/mysql/binlog/binlog copy-back

d.  Set ownership

shell\> sudo chown -R mysqluser:mysqlgrp /mysql/data /mysql/binlog

shell\> sudo chmod -R 750 /mysql/data /mysql/binlog

e.  Start the server and verify the data

shell\> sudo systemctl start mysqld-advanced

shell\> mysql -uadmin -p -hmysql1 -P3307

mysql\> SHOW DATABASES;

# 6a) MySQL Replication: prepare replica server

Objective: install binaries on a new server

Server: mysql2

Notes:

- mysql2 don\'t have binaries installed, so first part of the lab
    installs them. This is the same to first installation of
    mysql-advanced on mysql1

1. If instance mysql2 is not started, start it from OCI dashboard

2. Open an SSH client to app-srv

shell\> ssh -i \<private_key_file\> opc@\<your_compute_instance_ip\>

3. connect to **mysql2** server trhougth app-srv

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql2 mysql2

4. Execute below script that replicate what we did in manual
    installation lab (create mysqluser/mysqlgrp, folders and install
    binaries

shell-mysql2\> /workshop/support/mysql2_prepare_replica_server.sh
\*\*plf\*\* Not found

shell-mysql2\>
/workshop/support/lab7a-MySQL_Replication\_\_\_Prepare_replica_server.sh
\*\*plf\*\* fix

5. **Close and reopen the SSH connection** to let opc user have the new
    group.

# 6b) MySQL Replication: create replica

NOTE:

- MySQL 8.0 replication requires SSL. To make it works like MySQL 5.7
    and practice for the exam we force the usage of old native password
    authentication in my.cnf

- Some commands must run inside the source, other on replica: please
    read carefully the instructions

Servers:

- mysql1 (source)

- mysql2 (replica)

1. If not already connected, open two connections, one to mysql1 and
    one to mysql2

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql1 mysql1

And in a second shell

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql2 mysql2

2. **mysql1 (source)**: Make the replica a copy of the source in a
    shared folder to easily restore on the replica:

```{=html}
<!-- -->
```

a.  take a full backup of the source using MySQL Enterprise Backup in
    your NFS folder /workshop/backups:

shell-mysql1\> mysqlbackup \--port=3307 \--host=127.0.0.1
\--protocol=tcp \--user=mysqlbackup \--password
\--backup-dir=/workshop/backups/mysql1_source backup

3. **mysql2 (replica):** We now create the my.cnf, restore the backup
    create and configure the replica

```{=html}
<!-- -->
```

a.  It's mandatory that each server in a replication topology have a
    unique server id. There is a copy of the my.cnf ready to be used.
    It's a duplicate of the one used for mysql-advanced instance, with a
    different server_id

shell-mysql2\> sudo cp /workshop/support/my.cnf.mysql2 /mysql/etc/my.cnf

shell-mysql2\> sudo chown mysqluser:mysqlgrp /mysql/etc/my.cnf

b.  restore the backup from share folder

shell-mysql2\> sudo /mysql/mysql-latest/bin/mysqlbackup
\--defaults-file=/mysql/etc/my.cnf
\--backup-dir=/workshop/backups/mysql1_source \--datadir=/mysql/data
\--log-bin=/mysql/binlog/binlog copy-back-and-apply-log

shell-mysql2\> sudo chown -R mysqluser:mysqlgrp /mysql

c.  start the new replica instance it and verify that it works (hostname
    have to be mysql2).\
    Don't make any change to the instance content!

shell-mysql2\> sudo systemctl start mysqld-advanced

shell-mysql2\> mysql -uadmin -p -hmysql2 -P3307

mysql-replica\> SELECT @@hostname;

mysql-replica\> SHOW DATABASES;

4. **mysql1 (source)**: Create the replication user

shell-mysql1\> mysql -uadmin -p -hmysql1 -P3307

mysql-source\> CREATE USER \'repl\'@\'%\' IDENTIFIED BY \'Welcome1!\'
REQUIRE SSL;

mysql-source\> GRANT REPLICATION SLAVE ON \*.\* TO \'repl\'@\'%\';

5. **mysql2 (replica):** Time to connect and start the replica

    a.  Configure the replica connection.

mysql-replica\> CHANGE REPLICATION SOURCE TO SOURCE_HOST=\'mysql1\',

SOURCE_PORT=3307,

SOURCE_USER=\'repl\',

SOURCE_PASSWORD=\'Welcome1!\',

SOURCE_AUTO_POSITION=1,

MASTER_SSL=1;

b.  start the replica threads

mysql-replica\> START REPLICA;

c.  Verify replica status, e.g. that IO_Thread and SQL_Thread are
    started searching the value with the following command (in case of
    problems check error log)

mysql-replica\> SHOW REPLICA STATUS\\G

6. **mysql1 (source)**: Let's test that data are replicated. Connect to
    source and make some changes

mysql-source\> CREATE DATABASE newdb;

mysql-source\> USE newdb;

mysql-source\> CREATE TABLE t1 (c1 int primary key);

mysql-source\> INSERT INTO t1 VALUES(1);

mysql-source\> INSERT INTO t1 VALUES(2);

mysql-source\> DROP DATABASE employees;

7. **mysql2 (replica)**: Verify that the new database and table is on
    the replica, to do so connect to replica and submit

mysql-replica\> SHOW DATABASES;

mysql-replica\> SELECT \* FROM newdb.t1;

# 7a) Open subnet ports for MySQL InnoDB Cluster

Objectives: Open the XCom ports to use MySQL InnoDB Cluster.

NOTE:

- MySQL Cluster use XCom protocol with default port calculated like
    target instance\'s port value by 10 and then adding one to the
    result. So we need to open port 33071

1. Login in your OCI tenancy dashboard

2. If are using a dedicated compartment, select it

3. On the Navigation Menu, select Networking -\> Virtual Cloud
    Networks.

![ ](media/image16.png){width="5.833333333333333in"
height="2.7554735345581802in"}

4. Select mysqlvn

![Graphical user interface, text, application, email Description
automatically generated](media/image38.png){width="6.147826990376203in"
height="2.9775535870516188in"}

5. Select "Security Lists" from left side menu

![Graphical user interface, text, application Description automatically
generated](media/image39.png){width="5.895048118985127in"
height="2.85869094488189in"}

6. Select "Security List for **Private** Subnet-mysqlvcn" security
    list.

![Graphical user interface, application Description automatically
generated](media/image40.png){width="5.843478783902012in"
height="2.836628390201225in"}

7. Click the button "Add Ingress Rules"

![A screenshot of a computer Description automatically
generated](media/image41.png){width="5.886956474190726in"
height="2.839339457567804in"}

8. In the form insert these values and then confirm

**Source:** CIDR

**Source CIDR:** 10.0.1.0/24

**IP Protocol:** TCP

**Source Port Range:** \<leave it empty\>

**Destination port range:** 33071

**Description:** MySQL Group Replication

![Graphical user interface, text, application Description automatically
generated](media/image44.png){width="6.339643482064742in"
height="3.0608694225721784in"}

# 7b) MySQL InnoDB Cluster

Objectives: To create a 3 nodes MySQL InnoDB Cluster as Single Primary
and have a trial on the MySQL Shell to configure and operate. Using
MySQL Router to test for Server routing and test for Failover.

Steps in the lab

- Check and, if required, fix data model for InnoDB Cluster
    compatibility

- Configure InnoDB Cluster in single primary (mysql1 as primary)

- Configure mysql router

- Test client connection with MySQL Router, read/write and read only

- Simulate a crash of primary instance

NOTE:

- MySQL InnoDB cluster require at least 3 instances (refer to schema
    in the first part of the lab guide)

  - mysql1 will be the primary

  - mysql2 and mysql3 will be first secondaries

- We use here different ways to configure the secondaries

1. From app-srv, connect to mysql1 and verify data model compatibility
    with Group replication requirements.\
    If needed, fix the errors

    a.  Connect to instance

shell-app-srv\> mysql -uadmin -p -hmysql1 -P3307

b.  Search non InnoDB tables and if there are you must change them.
    **For this lab just** **drop them**

mysql-primary\> SELECT table_schema, table_name, engine, table_rows,
(index_length+data_length)/1024/1024 AS sizeMB

FROM information_schema.tables

WHERE engine != \'innodb\'

> AND table_schema NOT IN (\'information_schema\', \'mysql\',
> \'performance_schema\');

c.  Search InnoDB tables without primary or unique key. In production
    you must fix, here it\'s enough that **you drop them**

mysql-primary\> SELECT tables.table_schema, tables.table_name,
tables.engine, tables.table_rows

FROM information_schema.tables

> LEFT JOIN (select table_schema, table_name
>
> FROM information_schema.statistics
>
> GROUP BY table_schema, table_name, index_name
>
> HAVING
>
> SUM(CASE
>
> WHEN non_unique = 0
>
> AND nullable != \'YES\' then 1
>
> ELSE 0
>
> END
>
> ) = count(\*)
>
> ) puks
>
> ON tables.table_schema = puks.table_schema
>
> AND tables.table_name = puks.table_name

WHERE puks.table_name is null

> AND tables.table_type = \'BASE TABLE\'
>
> AND engine=\'InnoDB\'
>
> AND tables.table_schema NOT IN (\'information_schema\', \'mysql\',
> \'performance_schema\');

mysql-primary\> DROP TABLE world.city_part;

mysql-primary\> exit

1. Thanks to replication, instance on mysql2 is ready for cluster. Just
    stop replication

    a.  Connect with administrative account

shell-app-srv\> mysql -uadmin -p -hmysql2 -P3307

b.  Stop and remove the replication and the server is ready to be used

mysql-secondary-1\> stop replica;

mysql-secondary-1\> reset replica all;

mysql-secondary-1\> exit

2. Now we need a third instance, we create a new one on mysql3 .

    a.  If not already stared, start mysql3 instance with OCI dashboard

    b.  Connect to mysql3 through app-srv

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql3 mysql3

c.  Execute below script that replicate what we did in manual
    installation lab (create mysqluser/mysqlgrp, folders and install
    binaries and enterprise plugins, create the admin user)

shell-mysql3\> /workshop/support/mysql3_prepare_secondary.sh \*\*plf\*\*
not found

shell-mysql3\> /workshop/support/
lab7c-MySQL_InnoDB_Cluster\_\_\_Prepare_secondary-2.sh \*\*plf\*\* fix

6. Verify that the instance is up and running.\
    Login to verify that the instance is accessible and empty, then
    close the connection (we don't need it)

shell-mysql3\>\
sudo /mysql/mysql-latest/bin/mysql -uadmin -p -hmysql3 -P 3307

mysql3 \> SELECT @@hostname;

mysql3\> exit

shell-mysql3\> exit

7. Now we can create the cluster. We can do it from any server, we use
    here app-srv

shell-app-srv\> mysqlsh

a.  Check the instance configuration

MySQL JS \> dba.checkInstanceConfiguration(\'admin@mysql1:3307\')

> If the check may return errors, we use MySQL Shell to fix with the
> command. e.g.
>
> {\
> \"config_errors\": \[\
> {\
> \"action\": \"server_update\",\
> \"current\": \"CRC32\",\
> \"option\": \"binlog_checksum\",\
> \"required\": \"NONE\"\
> }\
> \],\
> \"status\": \"error\"\
> }
>
> MySQL JS \> dba.configureInstance(\'admin@mysql1:3307\')
>
> ![](media/image45.png){width="4.967361111111111in"
> height="3.095138888888889in"}

b.  Just to be sure, re-check the instance configuration and verify that
    you receive an \"ok\" message

MySQL JS \> dba.checkInstanceConfiguration(\'admin@mysql1:3307\')

The instance \'primary:3307\' is valid for InnoDB cluster usage.

{

\"status\": \"ok\"

}

c.  Create the cluster.

> MySQL JS \> \\connect admin@mysql1:3307
>
> MySQL JS \> var cluster = dba.createCluster(\'testCluster\')
>
> ![](media/image46.png){width="6.421911636045494in"
> height="2.6267924321959755in"}

3. Verify cluster status (why \"Cluster is NOT tolerant to any
    failures\" ?)

> MySQL JS \> cluster.status()
>
> ![](media/image47.png){width="6.014281496062992in"
> height="3.2558136482939632in"}

4. Add the second server to the cluster

    a.  Check the instance configuration, and probably it produces the
        same error as the first 'primary:3307'

MySQL JS \> dba.checkInstanceConfiguration(\'admin@mysql2:3307\')

b.  Use MySQL Shell to fix issues

> MySQL JS \> dba.configureInstance(\'admin@mysql2:3307\')

c.  Add the instance to the cluster

> MySQL JS \> cluster.addInstance(\'admin@mysql2:3307\')
>
> ![](media/image48.png){width="6.072916666666667in"
> height="3.08667760279965in"}

d.  Verify cluster status

> MySQL JS \> cluster.status()
>
> ![](media/image49.png){width="4.958577209098863in"
> height="3.5729166666666665in"}

24. Now we add the third node to cluster

    a.  Check the instance configuration

MySQL JS \> dba.checkInstanceConfiguration(\'admin@mysql3:3307\')

![](media/image50.png){width="5.3125in" height="3.2621511373578302in"}

b.  If there are issues (we missed something...), read the messages and
    fix with

> MySQL JS \> dba.configureInstance(\'admin@mysql3:3307\')

c.  Add the last instance to the cluster

> MySQL JS \> cluster.addInstance(\'admin@mysql3:3307\')

d.  Because the instance is empty, we receive an alert. We use now the
    clone plugin

> ![](media/image51.png){width="6.369445538057743in"
> height="1.7849857830271216in"}

e.  Type 'C' and confirm. This start the clone process

> ![](media/image52.png){width="6.307562335958005in"
> height="3.3482863079615046in"}

25. Verify cluster status, now with all three servers

> MySQL JS \> cluster.status()
>
> ![](media/image53.png){width="5.674419291338583in"
> height="5.027778871391076in"}

26. Verify the new status. How do you recognize the Primary server?

27. Exit from MySQL Shell and install MySQL Router via rpm package

MySQL JS \> \\q

> shell-app-srv\> sudo yum -y install
> /workshop/linux/mysql-router-commercial-8.0.\*.x86_64.rpm

28. Configure MySQL Router

> shell-app-srv\> sudo mysqlrouter \--bootstrap admin@mysql1:3307
> \--user=mysqlrouter

Have a look on the output.

Read/Write Connections port: \_\_\_\_\_\_\_\_\_\_\_\_\_

Read/Only Connections: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

29. Start MySQL Router

> shell-app-srv\> sudo systemctl start mysqlrouter

30. Test the connection with a mysql client connect to 6446 port
    (read/write).\
    To which server are you currently connected?
    \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\
    Can you change the content?
    \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

> shell-app-srv\> mysql -uadmin -p -h127.0.0.1 -P**6446**
>
> mysql-rw\> SELECT @@hostname, @@port;
>
> mysql-rw\> use newdb;
>
> mysql-rw\> SHOW TABLES;

mysql-rw\> CREATE TABLE newtable (c1 int primary key);

mysql-rw\> INSERT INTO newtable VALUES(1);

mysql-rw\> INSERT INTO newtable VALUES(2);

mysql-rw\> SELECT \* from newtable;

mysql-rw\> exit

31. The second port of MySQL Router is used for read only sessions.
    Close session and re open on port 6447 (read only port).\
    To which server are you currently connected?
    \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\
    Can you change the content?
    \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

shell-app-srv\> mysql -uadmin -p -h127.0.0.1 -P**6447**

mysql-ro\> SELECT @@hostname, @@port;

mysql-ro\> use newdb;

mysql-ro\> SELECT \* from newtable;

mysql-ro\> INSERT INTO newtable VALUES(3);

mysql-ro\> show variables like \'%read_only\';

mysql-ro\> exit

32. Reconnect to primary instance through the router. Please keep this
    session open!

shell-app-srv\> mysql -uadmin -p -h127.0.0.1 -P**6446**

mysql-rw\> SELECT @@hostname, @@port;

**\
**

33. **Open a second SSH connection** to mysql1 and simulate a crash
    killing primary instance. To do so retrieve process ID with one of
    these commands

shell-app-srv\> ssh -i \$HOME/sshkeys/id_rsa_mysql1 mysql1

shell-mysql1\> cat /mysql/data/\*.pid

a.  the kill the process of primary instance to simulate a crash

shell-mysql1\> sudo kill -9 **\<**process id from previous step**\>**

b.  Return to mysql connection previously opened and verify if it works.
    It may requires 20/25 seconds to be online.

mysql-rw\> SELECT @@hostname, @@port;

mysql-rw\> SELECT @@hostname, @@port;

mysql-rw\> INSERT INTO newdb.newtable VALUES(30);

mysql-rw\> SELECT \* from newdb.newtable;

34. From the shell where you killed the instance use MySQL Shell to
    verify cluster status (of course connect to a living instance)

shell-app-srv\> mysqlsh

MySQL JS \> \\c admin@mysql1:3307

MySQL JS \> var cluster = dba.getCluster(\'testCluster\')

> MySQL JS \> cluster.status()

35. Optional: restart \"crashed\" instance and verify with MySQL Shell
    how it changes the status

> MySQL JS \> cluster.status()

# 8a) Open subnet ports for MySQL Enterprise Monitor

Objectives: Open the MySQL Enterprise Monitor port (18443) from internal
subnet and internet

NOTE:

- We use Security Rules

1. Login in your OCI tenancy dashboard

2. If are using a dedicated compartment, select it

3. On the Navigation Menu, select Networking -\> Virtual Cloud
    Networks.

![ ](media/image16.png){width="5.833333333333333in"
height="2.7554735345581802in"}

4. Select mysqlvn

![Graphical user interface, text, application, email Description
automatically generated](media/image38.png){width="6.147826990376203in"
height="2.9775535870516188in"}

5. Select "Security Lists" from left side menu

![Graphical user interface, text, application Description automatically
generated](media/image39.png){width="5.895048118985127in"
height="2.85869094488189in"}

6. Setip script create a dedicated security list for app-srv. We use it
    now.\
    Select "app-srv_sl" security list.

![Graphical user interface, application Description automatically
generated](media/image40.png){width="5.843478783902012in"
height="2.836628390201225in"}

7. Click the button "Add Ingress Rules"

![Graphical user interface, text, application Description automatically
generated](media/image54.png){width="6.1043482064741905in"
height="2.9503423009623795in"}

8. In the form insert these values and then confirm

**Source:** CIDR

**Source CIDR:** 0.0.0.0/0

**IP Protocol:** TCP

**Source Port Range:** \<leave it empty\>

**Destination port range:** 18443

**Description:** MySQL Enterprise Monitor

![Graphical user interface, application Description automatically
generated](media/image55.png){width="6.139130577427822in"
height="2.967153324584427in"}

9. Now we have a rule that let connect to our MySQL Enterprise Monitor
    service

![A screenshot of a computer Description automatically
generated](media/image56.png){width="6.060870516185477in"
height="2.9452132545931757in"}

# 8b) MySQL Enterprise Monitor - Install Service Manager

Objective: Install MySQL Enterprise Monitor Service Manager

Server:

- App-srv for Enterprise Monitor

Note:

- References

  - <https://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-install-tuning.html>

  - <https://dbtut.com/index.php/2018/10/25/installation-of-mysql-enterprise-monitor/>

![](media/image2.png){width="1.6417913385826772in"
height="1.5522397200349956in"}![](media/image3.png){width="1.6417913385826772in"
height="1.5522397200349956in"}

![](media/image57.png){width="1.4141786964129484in"
height="1.467257217847769in"}![](media/image1.wmf){width="1.4141786964129484in"
height="1.467257217847769in"}

![](media/image2.png){width="1.7313429571303587in"
height="1.5489227909011374in"}![](media/image3.png){width="1.7313429571303587in"
height="1.5489227909011374in"}![](media/image59.png){width="0.6840277777777778in"
height="0.5055555555555555in"}

1. Now we install the service. If not already connected, connect to
    app-srv with your SSH client

2. Install the MySQL Enterprise Monitor Service Manager on app-srv

shell-app-srv\> cd /workshop/linux/monitor

shell-app-srv\> sudo ./mysqlmonitor-8.0.\*-linux-x86_64-installer.bin

Here a summary of the installer questions:

(Except for the Password Entry \[ using Welcome1! \], all other INPUTs
are DEFAULT -- Just hit \<ENTER\>)

Language Selection

Please select the installation language

\[1\] English - English

\[2\] Japanese - 日本語

\[3\] Simplified Chinese - 简体中文

Please choose an option \[1\] : 1

Info: During the installation process you will be asked to enter
usernames and

passwords for various pieces of the Enterprise Monitor. Please be sure
to make

note of these in a secure location so you can recover them in case they
are

forgotten.

Press \[Enter\] to continue:

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Welcome to the setup wizard for the MySQL Enterprise Monitor

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Please specify the directory where the MySQL Enterprise Monitor will be

installed

Installation directory \[/opt/mysql/enterprise/monitor\]:

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Select Requirements

Select Requirements

Please indicate the scope of monitoring this installation will initially
encompass so we can configure memory usage accordingly. NOTE: This
setting may have a big impact on overall performance. The manual
contains instructions for updating the configuration later, if needed.
This installation will monitor a:

System Size

\[1\] Small system: 1 to 5 MySQL Servers monitored from a laptop
computer or low-end server with no more than 4 GB of RAM

\[2\] Medium system: Up to 100 MySQL Servers monitored from a
medium-size but shared server with 4 GB to 8 GB of RAM

\[3\] Large system: More than 100 MySQL Servers monitored from a
high-end server dedicated to MEM with more than 8 GB RAM

Please choose an option \[2\] : 1

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Tomcat Server Options

Please specify the following parameters for the bundled Tomcat Server

Tomcat Server Port \[18080\]:

Tomcat SSL Port \[18443\]:

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Service Manager User Account

You are installing as root, but it\'s not good practice for the Service
Manager

to run under the root user account. Please specify the name of a user
account

to use for the Service Manager below. Note that this user account will
be

created for you if it doesn\'t already exist.

User Account \[mysqlmem\]:

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Database Installation

Please select which database configuration you wish to use

\[1\] I wish to use the bundled MySQL database

\[2\] I wish to use an existing MySQL database \*

Please choose an option \[1\] :

\* We will validate the version of your existing MySQL database server
during the

installation. See documentation for minimum version requirements.

\* Important: If your existing MySQL database server already has another
MySQL

Enterprise Monitor repository in it that you want to keep active, be
sure to

specify a unique name in the \"MySQL Database Name\" field on the next
screen.

Visit the following URL for more information:

<http://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-install-server.html>

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Repository Configuration

Please specify the following parameters for the bundled MySQL server

Repository Username \[service_manager\]:

Password : Welcome1!

Re-enter : Welcome1!

MySQL Database Port \[13306\]:

MySQL Database Name \[mem\]:

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Setup is now ready to install MySQL Enterprise Monitor on your computer.

Do you want to continue? \[Y/n\]: Y

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Please wait while Setup installs MySQL Enterprise Monitor on your
computer.

Installing

0% \_\_\_\_\_\_\_\_\_\_\_\_\_\_ 50% \_\_\_\_\_\_\_\_\_\_\_\_\_\_ 100%

\#########################################

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Completed installing files

Setup has completed installing the MySQL Enterprise Monitor files on
your

computer

Uninstalling the MySQL Enterprise Monitor files can be done by invoking:

/opt/mysql/enterprise/monitor/uninstall

To complete the installation, launch the MySQL Enterprise Monitor UI and

complete the initial setup. Refer to the readme file for additional
information

and a list of known issues.

Press \[Enter\] to continue:

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Completed installing files

WARNING: To improve security, all communication with the Service Manager
uses

SSL. Because only a basic self-signed security certificate is included
when the

Service Manager is installed, it is likely that your browser will
display a

warning about an untrusted connection. Please either install your own

certificate or add a security exception for the Service Manager URL to
your

browser. See the documentation for more information.

<http://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-ssl-installation.html>

Press \[Enter\] to continue:

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Setup has finished installing MySQL Enterprise Monitor on your computer.

View Readme File \[Y/n\]: n

Info: To configure the MySQL Enterprise Monitor please visit the
following page:

<https://localhost:18443>

Press \[Enter\] to continue:

3. On app-srv: Check the status of the MySQL Monitor

shell-app-srv\> sudo /opt/mysql/enterprise/monitor/mysqlmonitorctl.sh
status

4. On app-srv: After the successful installation connect to the newly
    installed service with a web browser on the address from your laptop
    (please use the public IP and be patient, startup may require few
    minutes depending on VM resources)

https://\<app-srv_public_ip\>:18443\
\
![](media/image60.png){width="6.480476815398076in"
height="4.406977252843395in"}

5. Fill then Admin user and Agent user settings

Admin user : admin - Admin password: Welcome1!

Agent user : agent - Agent password: Welcome1!

6. Click 'Complete Setup' button

7. Choose your time zone and keep "English" for locale

![](media/image61.png){width="6.582302055993001in"
height="4.174418197725284in"}

8. Now you are logged in, start exploring the interface

9. Connect your MEM to use mysql-advanced in agentless mode

    a.  On left side menu expand "Configuration" and select "Mysql
        Instances".\
        Click button "Add MySQL Instance" and fill

Monitor From: MEM Built-in Agent

Instance Address: mysql1\
Port: 3307\
Admin User: admin\
Admin password: Welcome1!\
Auto-Create Less Privileged Users: No

> ![](media/image62.png){width="3.704861111111111in" height="2.825in"}

10. \# Do you see statistics on NIC, disks, etc? \# You should not (!)

11. \# Check the monitoring status on the top right \[Dolphin Logo\]

12. \# How many server (Hosts) are you monitoring? How many MySQL
    Instances (Monitored, not Monitored etc.) are there? \# Do not add
    this/these servers yet!

# 8c) MySQL Enterprise Monitor - Install Agent

Objective: Install MySQL Enterprise Monitor Agent

Server:

- App-srv for Enterprise Monitor

- Mysql1 for Enterprise Agent

Note:

- Note down the IP address here.

  - app-srv Public IP address :
        \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

> The Public IP Address is used on your Local Browser https://\<public
> ip\>:18443

- app-srv Private IP address :
    \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\
    Used during Agent configuration

- mysql1 Private IP address :
    \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\
    This is used when you Add Instance as Remote Monitoring using
    agentless option

```{=html}
<!-- -->
```

- References

  - <https://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-install-tuning.html>

  - <https://dbtut.com/index.php/2018/10/25/installation-of-mysql-enterprise-monitor/>

![](media/image2.png){width="1.31621062992126in"
height="1.4498403324584428in"}

![](media/image57.png){width="1.4141786964129484in"
height="1.467257217847769in"}![](media/image1.wmf){width="1.4141786964129484in"
height="1.467257217847769in"}

![](media/image3.png){width="0.7787215660542433in"
height="0.6917989938757655in"}

![](media/image2.png){width="1.3879286964129485in"
height="1.9795877077865267in"}![](media/image3.png){width="0.821152668416448in"
height="0.9445702099737533in"}![](media/image59.png){width="0.6840277777777778in"
height="0.5055555555555555in"}

1. If not already connected, connect to app-srv and retrieve the
    Private IP with the OCI dashboard or the linux command. This IP will
    be used to connect the agent to the Monitor Service

shell-app-srv\> ifconfig \| grep 10.0.0

App-srv **PRIVATE** ip:
\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
(**client_ip**)

2. **On mysql1** : Install the MEM agent and configure it

Here a summary of the questions (from command installation in linux).
Note Linux requires a manual first start

shell-mysql1\> cd /workshop/linux/agent

shell-mysql1\> sudo
./mysqlmonitoragent-8.0.\*-linux-x86-64bit-installer.bin

Language Selection

Please select the installation language

\[1\] English - English

\[2\] Japanese - 日本語

\[3\] Simplified Chinese - 简体中文

Please choose an option \[1\] : 1

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Welcome to the MySQL Enterprise Monitor Agent Setup Wizard.

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Installation directory

Please specify the directory where MySQL Enterprise Monitor Agent will
be

installed

Installation directory \[/opt/mysql/enterprise/agent\]:

How will the agent connect to the database it is monitoring?

\[1\] TCP/IP

\[2\] Socket

Please choose an option \[1\] : 1

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Monitoring Options

You can configure the Agent to monitor this host (file systems, CPU,
RAM, etc.)

and then use the Monitor UI to furnish connection parameters for all
current and

future running MySQL Instances. This can be automated or done manually
for each

MySQL Instance discovered by the Agent. (Note: scanning for running
MySQL

processes is not available on Windows, but you can manually add new
connections

and parameters from the Monitor UI as well.)

Visit the following URL for more information:

<http://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-qanal-using-feeding.html>

Monitoring options:

\[1\] Host only: Configure the Agent to monitor this host and then use
the Monitor UI to furnish connection parameters for current and future
running MySQL Instances.

\[2\] Host and database: Configure the Agent to monitor this host and
furnish connection parameters for a specific MySQL Instance now. This
process may be scripted. Once installed, this Agent will also
continuously look for new MySQL Instances to monitor as described above.

Please choose an option \[2\] : 2

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Setup is now ready to begin installing MySQL Enterprise Monitor Agent on
your

computer.

Do you want to continue? \[Y/n\]: y

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Please wait while Setup installs MySQL Enterprise Monitor Agent on your

computer.

Installing

0% \_\_\_\_\_\_\_\_\_\_\_\_\_\_ 50% \_\_\_\_\_\_\_\_\_\_\_\_\_\_ 100%

\#########################################

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

MySQL Enterprise Monitor Options

Hostname or IP address \[\]: \<private IP address app-srv\>

Tomcat SSL Port \[18443\]:

The following are the username and password that the Agent will use to
connect

to the Monitor. They were defined when you installed the Monitor. They
can be

modified under Settings, Manage Users. Their role is defined as
\"agent\".

Agent Username \[agent\]: agent

Agent Password : Welcome1!

Re-enter : Welcome1!

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Monitored Database Configuration Options

Validate hostname, port, and Admin account privileges \[Y/n\]: y

Configure encryption settings for user accounts \[y/N\]: n

Configure less privileged user accounts \[y/N\]: n

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Monitored Database Information

IMPORTANT: The Admin user account specified below requires special MySQL

privileges.

Visit the following URL for more information:

<http://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-agent-rights.html>

MySQL hostname or IP address \[localhost\]: 127.0.0.1

MySQL Port \[3306\]: 3307

Admin User \[\]: admin

Admin Password : Welcome1!

Re-enter Password : Welcome1!

Monitor Group \[\]:

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Configuration Report

MySQL Enterprise Monitor Agent (Version 8.0....)

The settings you specified are listed below.

Note that if you are using a Connector to collect Query Analyzer data,

you will need some of these settings to configure the Connector. See

the following for more information:

<http://dev.mysql.com/doc/mysql-monitor/8.0/en/mem-qanal-using-feeding.html>

Installation directory: /opt/mysql/enterprise/agent

MySQL Enterprise Monitor UI:

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Hostname or IP address: \<the ip\>

Tomcat Server Port: 18443

Use SSL: yes

Press \[Enter\] to continue:

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Start MySQL Enterprise Monitor Agent

Info to start the MySQL Enterprise Monitor Agent

The MySQL Enterprise Monitor Agent was successfully installed. To start
the

Agent please invoke:

/etc/init.d/mysql-monitor-agent start

Press \[Enter\] to continue:

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Setup has finished installing MySQL Enterprise Monitor Agent on your
computer.

View Agent Readme File \[Y/n\]: n

3. Start the agent

shell-mysql1\> sudo /etc/init.d/mysql-monitor-agent start

4. Open your MySQL Monitor mysql-advanced connection (left menu
    Configuration\\MySQL Instances) and change the "Monitor from"
    choosing your agent instead of the MEM Built-in Agent

5. \# Do you see statistics on NIS, disks, etc.?

**[OPTIONAL: add workload]{.underline}**

6. OPTIONAL: Try to add some load on your server to watch graphics
    change

    a.  From mysql1 run the test tool "mysqlslap" (available in all
        MySQL Server installations):

shell-mysql1\> mysqlslap \--user=admin \--password \--host=mysql1
\--port=3307 \--concurrency=20 \--iterations=5000 \--number-int-cols=5
\--number-char-cols=20 \--auto-generate-sql
\--auto-generate-sql-guid-primary

b.  Check behavior in MEM, can you see the peaks?

# 9a) MySQL HeatWave Database Service - Deploy

Objective: Configure a MySQL Database Service

Note:

- We focus on a single instance

1. Login in your OCI tenancy dashboard

2. If are using a dedicated compartment, select it

3. On the Navigation Menu, select Databases -\> MySQL, DB Systems.

![](media/image63.png){width="6.46875in" height="3.992813867016623in"}

4. Click Create MySQL DB System

![ ](media/image64.png){width="5.833333333333333in"
height="2.762836832895888in"}

5. Insert the required information to create our database service.

    - Basic information for the DB System

> **Create in compartment**: (keep the default, root or yoiur)
>
> **Name**: MDS-SA
>
> **Description**: MySQL Database Service Standalone instance
>
> **Keep "Standalone" selection**

![ ](media/image65.png){width="5.833333333333333in"
height="3.6434733158355206in"}

- Create Administrator credentials

> **Username**: admin
>
> **Password**: Welcome1!
>
> **Confirm Password**: Welcome1!

![ ](media/image66.png){width="5.833333333333333in"
height="1.38707895888014in"}

- Configure networking (keep the defaults)

> **Virtual Cloud Network**: MDS-VCN
>
> **Subnet**: Private Subnet-mysqlvcn (Regional)

![](media/image67.png){width="5.776744313210848in"
height="1.2779571303587052in"}

- Configure placement

> **Availability Domain**: (keep the default)
>
> **Choose a Fault Domain**: (keep unselected)

![ ](media/image68.png){width="5.833333333333333in"
height="1.5116426071741031in"}

- Configure hardware

> **Select a Shape**: (keep the default MySQL.VM.Standard.E3.1.8GB)
>
> **Data Storage Size (GB)**: (keep default value 50)

![ ](media/image69.png){width="5.833333333333333in"
height="2.1307108486439197in"}

- Configure Backups

> **Enable Automatic Backups**: OFF

![ ](media/image70.png){width="5.833333333333333in"
height="1.235990813648294in"}

- Expand "Show Advanced Options".\
    > Select "Networking" tab and enter

> **Hostname**: mds-sa

![](media/image71.png){width="6.810416666666667in"
height="2.339583333333333in"}

- Click the Create button

6. The state will be shown as **Creating**. The New MySQL DB System
    will be ready to use after a few minutes.

![ ](media/image72.png){width="5.833333333333333in"
height="2.7506517935258095in"}

7. The state **Active** indicates that the DB System is ready to use.\
    Take a note of your private IP and FQDN in Endpoint section.

![ ](media/image73.png){width="5.833333333333333in"
height="2.6016786964129484in"}

# 9b) MySQL HeatWave Database Service - Use

Objective: Configure a MySQL Database Service

Note:

- We focus on a single instance

1. Now we can test the new service.\
    If not already connected, connect to app-srv

shell\> ssh -i \<private_key_file\> opc@\<your_compute_instance_ip\>

2. Connect to your instance

> shell-app-srv\> mysql -uadmin -p -h \<mds_ip_address\>

3. Now we execute some commands to interact with our instance.

    - Show the database version, current_date, and user

> mysql\> SELECT VERSION(), CURRENT_DATE, USER();

- Create a database with a table

> mysql\> CREATE DATABASE mydb;
>
> mysql\> SHOW DATABASES;
>
> mysql\> use mydb;
>
> mysql\> CREATE TABLE mytable (id INT, PRIMARY KEY(id));
>
> mysql\> INSERT INTO mytable VALUES(1);
>
> mysql\> INSERT INTO mytable VALUES(2);
>
> mysql\> SELECT \* FROM mytable;

# Addendum

## A1) Software used in this lab guide

MySQL Community Yum Repository:

- mysql80-community-release-el7-3.noarch.rpm

MySQL Enterprise Server:

- mysql-commercial-8.0.*XX*-el7-x86_64.tar.gz

MySQL Enterprise Shell:

- mysql-shell-commercial-8.0.*XX*-1.1.el7.x86_64.rpm

MySQL Enterprise Client

- mysql-commercial-client-8.0.*XX*.el7.x86_64.rpm

- mysql-commercial-common-8.0.*XX*.el7.x86_64.rpm

- mysql-commercial-libs-8.0.*XX*.el7.x86_64.rpm

- mysql-commercial-libs-compat-8.0.*XX*.el7.x86_64.rpm

MySQL Enterprise Monitor:

- mysqlmonitor-8.0.*XX*-linux-x86_64-installer.bin

- mysqlmonitoragent-8.0.*XX*-linux-x86-64bit-installer.bin

MySQL Enterprise Router:

- mysql-router-commercial-8.0.*XX*.el7.x86_64.rpm

Where *XX* is the actual release.

## A2) Content of file my.cnf.mysql1

\[mysqld\]

\# General configurations

port=3307

mysqlx_port=33070

server_id=10

socket=/mysql/temp/mysql.sock

mysqlx_socket=/mysql/temp/mysqlx.sock

user=mysqluser

\# File locations

basedir=/mysql/mysql-latest

plugin-dir=/mysql/mysql-latest/lib/plugin

datadir=/mysql/data

tmpdir=/mysql/temp

log-error=/mysql/log/err_log.log

general_log_file=/mysql/log/gl_log.log

slow_query_log_file=/mysql/log/sq_log.log

\# Maximum limits

max-connections=200

open-files-limit=5000

\# Security setting for file load

secure-file-priv=/mysql/data

\# InnoDB settings

innodb_flush_log_at_trx_commit=1

innodb_buffer_pool_size=512M

\# MyISAM settings

key_buffer_size=124M

\# Enable binary logs

log-bin=/mysql/binlog/binlog

binlog-format=row

sync_binlog = 1

\# These two variables are deprecated with MySQL 8

master-info-repository=TABLE

relay-log-info-repository=TABLE

\# Enable GTID

gtid-mode=on

enforce-gtid-consistency=true

\# Performance Monitor

performance_schema_consumer_events_statements_history_long = ON

\# Plugin load example (MySQL Enterprise Thread Pool)

plugin-load=thread_pool.so

## A3) Content of file my.cnf.mysql2

\[mysqld\]

\# General configurations

port=3307

mysqlx_port=33070

server_id=20

socket=/mysql/temp/mysql.sock

mysqlx_socket=/mysql/temp/mysqlx.sock

user=mysqluser

\# File locations

basedir=/mysql/mysql-latest

plugin-dir=/mysql/mysql-latest/lib/plugin

datadir=/mysql/data

tmpdir=/mysql/temp

log-error=/mysql/log/err_log.log

general_log_file=/mysql/log/gl_log.log

slow_query_log_file=/mysql/log/sq_log.log

\# Maximum limits

max-connections=200

open-files-limit=5000

\# Security setting for file load

secure-file-priv=/mysql/data

\# InnoDB settings

innodb_flush_log_at_trx_commit=1

innodb_buffer_pool_size=512M

\# MyISAM settings

key_buffer_size=124M

\# Enable binary logs

log-bin=/mysql/binlog/binlog

binlog-format=row

sync_binlog = 1

\# These two variables are deprecated with MySQL 8

master-info-repository=TABLE

relay-log-info-repository=TABLE

\# Enable GTID

gtid-mode=on

enforce-gtid-consistency=true

\# Performance Monitor

performance_schema_consumer_events_statements_history_long = ON

\# Plugin load example (MySQL Enterprise Thread Pool)

plugin-load=thread_pool.so;audit_log.so

audit_log=FORCE_PLUS_PERMANENT

audit_log_rotate_on_size=20971520

audit_log_policy=Login

## A4) Content of file my.cnf.mysql3

\[mysqld\]

\# General configurations

port=3307

mysqlx_port=33070

server_id=30

socket=/mysql/temp/mysql.sock

mysqlx_socket=/mysql/temp/mysqlx.sock

user=mysqluser

\# File locations

basedir=/mysql/mysql-latest

plugin-dir=/mysql/mysql-latest/lib/plugin

datadir=/mysql/data

tmpdir=/mysql/temp

log-error=/mysql/log/err_log.log

general_log_file=/mysql/log/gl_log.log

slow_query_log_file=/mysql/log/sq_log.log

\# Maximum limits

max-connections=200

open-files-limit=5000

\# Security setting for file load

secure-file-priv=/mysql/data

\# InnoDB settings

innodb_flush_log_at_trx_commit=1

innodb_buffer_pool_size=512M

\# MyISAM settings

key_buffer_size=124M

\# Enable binary logs

log-bin=/mysql/binlog/binlog

binlog-format=row

sync_binlog = 1

\# These two variables are deprecated with MySQL 8

master-info-repository=TABLE

relay-log-info-repository=TABLE

\# Enable GTID

gtid-mode=on

enforce-gtid-consistency=true

\# Performance Monitor

performance_schema_consumer_events_statements_history_long = ON

\# Plugin load example (MySQL Enterprise Thread Pool)

plugin-load=thread_pool.so;audit_log.so

## A5) Content of mysqld-advanced.service

\[Unit\]

Description=MySQL Server

Documentation=man:mysqld(8)

Documentation=<http://dev.mysql.com/doc/refman/en/using-systemd.html>

After=network.target

After=syslog.target

\[Install\]

WantedBy=multi-user.target

\[Service\]

User=mysqluser

Group=mysqlgrp

\# Have mysqld write its state to the systemd notify socket

Type=notify

\# Disable service start and stop timeout logic of systemd for mysqld
service.

TimeoutSec=0

\# Start main service

ExecStart=/mysql/mysql-latest/bin/mysqld
\--defaults-file=/mysql/etc/my.cnf \$MYSQLD_OPTS

\# Use this to switch malloc implementation

EnvironmentFile=-/etc/sysconfig/mysql-advanced-advanced

\# Sets open_files_limit

LimitNOFILE = 10000

Restart=on-failure

RestartPreventExitStatus=1

\# Set environment variable MYSQLD_PARENT_PID. This is required for
restart.

Environment=MYSQLD_PARENT_PID=1

PrivateTmp=false

## A6) Content of file mysqlbackup_user_grants.sql

GRANT RELOAD ON \*.\* TO \'mysqlbackup\'@\'%\';

GRANT BACKUP_ADMIN, SELECT ON \*.\* TO \'mysqlbackup\'@\'%\';

GRANT CREATE, INSERT, DROP, UPDATE ON mysql.backup_progress TO
\'mysqlbackup\'@\'%\';

GRANT CREATE, INSERT, SELECT, DROP, UPDATE ON mysql.backup_history TO
\'mysqlbackup\'@\'%\';

GRANT REPLICATION CLIENT ON \*.\* TO \'mysqlbackup\'@\'%\';

GRANT SUPER ON \*.\* TO \'mysqlbackup\'@\'%\';

GRANT PROCESS ON \*.\* TO \'mysqlbackup\'@\'%\';

GRANT CREATE TEMPORARY TABLES on mysql.\* TO \'mysqlbackup\'@\'%\';

## A7) Putty configuration

Steps to configure putty connection to OCI compute instances.

1. Open putty

2. Insert the public IP of your server and a mnemonic session name

![](media/image74.png){width="4.58in" height="4.52in"}

3. Choose \"Connection SSH Auth\" and provide the id_rsa.ppk path

![](media/image75.png){width="4.67in" height="4.52in"}

4. Select \"Connection Data\" and insert \"opc\" in \"Auto-login
    username\"

![](media/image76.png){width="4.581080489938758in"
height="4.520129046369203in"}

5. Choose Connection and insert \"60\" in \"Seconds between
    keepalives\"

![](media/image77.png){width="4.58in" height="4.52in"}

6. Return to \"Session\" and click save

![](media/image74.png){width="4.58in" height="4.52in"}

## A8) How to create and use Compartments

Notes:

- Two Compartments, named Oracle Account Name (root) and a compartment
    for PaaS, were automatically created by the Oracle Cloud

- For more information on Managing Compartments, please visit:
    <https://docs.cloud.oracle.com/iaas/Content/Identity/Tasks/managingcompartments.htm>.

1. Login in your OCI tenancy dashboard

2. On the Navigation Menu, under "Identity and Security", select
    Identity -\> Compartments.

> ![](media/image78.png){width="5.867361111111111in" height="3.6875in"}

3. On Compartments Page, click on "Create
    Compartment".![](media/image79.png){width="5.0in"
    height="3.129861111111111in"}

4. On Create Compartment, enter Name, Description, select Parent
    Compartment, and click on Create Compartment.

> ![](media/image80.png){width="5.800148731408574in"
> height="3.5833333333333335in"}

5. Completed Compartments

![](media/image81.png){width="6.028208661417323in"
height="3.8161843832020996in"}

6. Now to work in your compartment, choose it from left side menu when
    you create services.\
    Here a screenshot from "Compute/Instances"

![](media/image82.png){width="6.5625in" height="4.121408573928259in"}

##
