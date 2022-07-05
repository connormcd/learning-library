# How do I create user groups in Cloud Guard?
Duration: 5 minutes

Cloud Guard deals with security information globally and should only be available to a restricted audience within your organization. Utilize user groups in Oracle Cloud Guard to allow users to work within Cloud Guard and assign administrator priviliges. 

## Creating the Cloud Guard User Group
1. First, log in to the Oracle Cloud Infrastructure console as a tenancy administrator 
2. Open the navigation menu and click <b> Identity & Security</b>. Under <b> Identity</b>, click <b> Groups</b>. 


![The navigation window showing the Identity & Security menu along with the Identity and Grouops button](images/cloud-guard-user.png "Identity and security menu")

3. Click <b> Create Group</b>.
4. Fill in the required fields and then click <b> Create</b>. 
> **Note:** Provide a name that clearly identifies the group, such as  `"CloudGuardUsers"`. This name is unchangeable and must be unique across all groups in the tenancy. Avoid entering any confidential information from your organization


![The create group button and the corresponding pop up window showing where to input the group name and description](images/name-cloud-guard.png "Create group button")

## Learn More

* [Managing Oracle Identity Cloud Service Users in the OCI Console](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/addingidcsusersandgroups.htm#mapping)
* [Managing Groups](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managinggroups.htm)
* [Resource Identifiers](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/identifiers.htm#Resource_Identifiers)



