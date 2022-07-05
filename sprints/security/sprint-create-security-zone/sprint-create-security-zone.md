# How do I create a security zone?
Duration: 5 minutes

Security Zones let you be confident that your resources in the Oracle Cloud Infrastructure, including Compute, Networking, Object Storage, and Database resources, comply with Oracle security principles. 

## Creating a Security Zone
1. Open the navigation menu and click <b>Identity & Security</b>. Under <b>Security Zones</b>, click <b>Overview</b>

![Navigation menu showing the Identity & Security menu along with the Security Zone and Overview button](images/create-security-zone.png "Security Zone Button")

2. Click <b>Create Security Zone</b>.

3. Enter a name and description for the security zone.

    >**Note:** Oracle creates a <b> compartment</b> with the same name and assigns it to this security zone. Avoid entering any confidential information from your organization

4. For <b>Create in Compartment</b>, navigate to the compartment that you want to create the new compartment in.

5. Click <b>Create Security Zone</b>.

To create resources such as networks or compute instances in the new security zone, select the compartment with the same name when you create the resources

## Learn More

* [Overview of Security Zones](https://docs.oracle.com/en-us/iaas/security-zone/using/security-zones.htm)
* [Managing Security Zones](https://docs.oracle.com/en-us/iaas/security-zone/using/managing-security-zones.htm)


