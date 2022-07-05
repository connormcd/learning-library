## Insight Roles and Personas 

This workshop walks you through the 3 roles of Personas and Permissions in Oracle Integration Insight.

Estimated Workshop Time: 5 minutes

### Objectives

In this workshop, you will:
* Explain Oracle Integration Insight Roles
* Understand the permissions of each Oracle Insight persona

### Roles

Permissions in Insight are defined by Oracle Integration roles. The role(s) that you are assigned define your persona in Insight. Individuals maybe one or more roles within the assigned permissions. During this training you were given all permissions and therefore were able to perform all areas of Oracle Insight. Please see your Oracle Integration Manager to see which permission(s) you may have in your production environment.


### *ServiceAdminstrator*

This is a super user who manages Insight. This user can purge Insight model data and has all the privileges of the other roles to view, create, manage, edit, and delete all the models and dashboards.

### *ServiceDeveloper*
This user can view, create, manage, edit, and delete Insight models.

The *Integration Architect* understands the end-to-end business process implemented in Oracle Integration and defines the mapping of the milestones to the appropriate location in the business process implementation and the extraction criteria of Insight indicators.

*Integration Architect* will work with the *ServiceUser*. The ServiceUser understands the business use case and defines business milestones and indicators in an Insight model. 

These users do not have access to Insight dashboards through the Consoles page.

### *ServiceUser*

This user understands how the business works and can use the Insight consoles, which provide preconfigured and custom dashboards, to gain insight into business process status and activity in real time. For example, this user might ask an integration architect and business analyst to build a model in Insight to provide a visualization of which products are selling best in which US state and if there are any models with a high return rate. This data helps to make decisions such as investing more marketing dollars in certain regions and if it makes sense to expand overseas.

This user can view, create, manage, edit, and delete Insight dashboards through the Consoles page. This user does not have access to models through the Models page or create Models.
*ServiceUser* will work with the *Integration Architect*.


## Learn More

* [https://docs.oracle.com/en/cloud/paas/integration-cloud/user-int-insight-oci/integration-insight-roles.html#GUID-206AFD0C-6F84-41E1-A598-A22BBAFAD2D4](http://docs.oracle.com)


## Acknowledgements
* **Author** - Lucy Cortez, Product Enablement Manager, OIC
* **Contributors** -  OIC Group 
* **Last Updated By/Date** - Lucy Cortez, OIC, April 2022
