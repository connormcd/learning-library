# Create your Virtual Cloud Network and Related Components

## Introduction

This lab will guide you throught the procees to create your Virtual Cloud Network (VCN) and related components

Estimated time: x minutes

### Ojectives

* Create your VCN
* Configure Security List to allow HTTP inbound connections
* Configure Security List to allow MySQL inbound connections

## Task 1: Create your VCN

Set up a VCN to connect your Linux instance to the internet. You will configure all the components needed to create your virtual network.

1. Open the navigation menu. Under Core Infrastructure, go to Networking and click Virtual Cloud Networks.

    Ensure that a compartment (or the compartment designated for you) is selected in the Compartment list on the left.

2. Click **Start VCN Wizard**.

3. Select VCN with Internet Connectivity, and then click **Start VCN Wizard**.

4. Enter the following (descriptions are italicized. replace with the values for your scenario):

* Name: *Enter a name for your cloud network*
* COMPARTMENT: *select the desired compartment*
* VCN CIDR BLOCK: *10.0.0.0/16*
* PUBLIC SUBNET CIDR BLOCK: *10.0.0.0/24*
* PRIVATE SUBNET CIDR BLOCK: *10.0.1.0/24*
* DNS RESOLUTION: *checked*

Note: Notice the public and private subnets have different CIDR blocks.

4. Click Next. 

    The Create a VCN with Internet Connection configuration dialog will be displayed, confirming all the values you just entered and listing additional components that will be created.

5. Click **Create** to start the workflow.

6. After the workflow completes, click on **View Virtual Cloud Networks** and you will be directed to the details page of the VCN you created.

## Task 2: Configure Security List to allow HTTP inbound connections

Create the rules in the default security list that will allow incomming comnections on ports 80/TCP and 443/TCP

1. Click View Virtual Cloud Network to view your new VCN.

2. With your new VCN displayed, click on your Public subnet link.

    The public subnet information is displayed with the Security Lists at the bottom of the page. There should be a link to the Default Security List for your VCN.

3. Click the **Default Security List** link.
    
    The default Ingress Rules for your VCN are displayed.
4. Click Add Ingress Rules.

    An **Add Ingress Rules** dialog is displayed.

5. Enter the following:

* Stateless: *Checked*
* Source Type: *CIDR*
* Source CIDR: *0.0.0.0/0*
* IP Protocol: *TCP*
* Source port range: *(leave-blank)*
* Destination Port Range: *80*
* Description: *Allow HTTP connections*
        
Once you click Add Ingress Rule, inbound HTTP connections are allowed.

6. Repeat the steps from 1-4 and enter the following:

* Stateless: *Checked*
* Source Type: *CIDR*
* Source CIDR: *0.0.0.0/0*
* IP Protocol: *TCP*
* Source port range: *(leave-blank)*
* Destination Port Range: *443*
* Description: *Allow HTTPS connections*

Once you click Add Ingress Rule, inbound HTTPS connections are allowed.


## Task 3: Configure Security List to allow MySQL inbound connections

Create a rule in the **Security List for Private Subnet-*VCN Name*** security list that will allow incomming comnections on ports 3306/TCP and 33060/TCP

1. Click View Virtual Cloud Network to view your new VCN.

2. With your new VCN displayed, click on your Private subnet link.

    The private subnet information is displayed with the Security Lists at the bottom of the page. There should be a link to the **Security List for Private Subnet-*VCN Name*** for your private subnet.

3. Click the **Security List for Private Subnet-*VCN Name*** link.
    
    The default Ingress Rules for your VCN are displayed.

4. Click Add Ingress Rules.

    An **Add Ingress Rules** dialog is displayed.

5. Enter the following:

* Stateless: *Checked*
* Source Type: *CIDR*
* Source CIDR: *10.0.0.0/24*
* IP Protocol: *TCP*
* Source port range: *(leave-blank)*
* Destination Port Range: *3306*
* Description: *Allow MySQL connections*
        
Once you click Add Ingress Rule, inbound MySQL connections from the public subnet are allowed.

6. Repeat the steps from 1-4 and enter the following:

* Stateless: *Checked*
* Source Type: *CIDR*
* Source CIDR: *10.0.0.0/24*
* IP Protocol: *TCP*
* Source port range: *(leave-blank)*
* Destination Port Range: *33060*
* Description: *Allow MySQL X connections*

Once you click Add Ingress Rule, inbound  MySQL X connections from the public subnet are allowed.

## Acknowledgements
* **Author** - Perside Foster, MySQL Solution Engineering, Orlando Gentil, Principal Training Lead and Evangelist
* **Contributors** - Frédéric Descamps, MySQL Community Manager 
* **Last Updated By/Date** - Perside Foster, MySQL Solution Engineering, March 2022