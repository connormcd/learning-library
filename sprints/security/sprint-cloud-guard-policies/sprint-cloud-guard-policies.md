# How do I enable policies to run Cloud Guard?
Duration: 5 minutes

You can utilize Oracle Cloud Guard policies to control who has access to Cloud Guard and the type of access each group has. 

To enable Cloud Guard, you need to add the proper IAM policies below. From there, you must create new policies to provide users outside of the Administrator group with access. 

1. Launch the Cloud dashboard and navigate to the <b> Identity & Security </b> and click on <b> Cloud Guard </b> 

2. On the <b>Cloud Guard</b> page, click the <b>Enable Cloud Guard</b> button on the top right 

3. The <b>Enable Cloud Guard</b> dialog box will appear. In the <b>Tenancy Policies</b> section, click one of the <b>enable</b> links. 

4. If all the required policies are successfully created, the link text will change to <b>enabled</b> 

5. The following IAM policies are automatically added to the "Cloud Guard Policies" policy group when you click <b>Enable</b> at the bottom of the <b>Enable Cloud Guard</b> dialog box

![A list of the Cloud Guard IAM policies](images/guard-policies.png "Example of clod guard policies")



## Learn More

* [Cloud Guard Policies](https://docs.oracle.com/en-us/iaas/cloud-guard/using/policies.htm)
* [Policy Reference](https://docs.oracle.com/en-us/iaas/Content/Identity/Reference/policyreference.htm)
* [How policies work](https://docs.oracle.com/en-us/iaas/Content/Identity/Concepts/policies.htm)



