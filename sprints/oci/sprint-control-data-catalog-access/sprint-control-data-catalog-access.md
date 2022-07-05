# How do I control users access to a Data Catalog instance?
Duration: 5 minutes

Compartments allow you to organize and control access to your cloud resources.

### Prerequisites
* An Oracle Cloud Account.

## Control Users' Access to a Data Catalog Instance

To control who has access to Data Catalog, and the type of access for each group of users, you must create policies. By default, only the users in the Administrators group have access to all Data Catalog resources. For everyone else who's involved with Data Catalog, an administrator users must create policies that give them proper rights to Data Catalog resources. In this lab, it is assumed that you are an administrator performing the steps in this workshop such as creating the Data Catalog instance.

If you are not an administrator user, then your administrator user must grant you the policies listed below.

Let's say you are not an Administrator but you do need to use and manage Data Catalog. Your Administrator can create a Data Catalog Group and add you and other non-Administrator users to this group. Assume that all of the resources that you will need to perform your job are in compartment named `training-dcat-compartment`. The following policy statements are required for the `training-dcat-users-group` group.

To allow a group named `training-dcat-users-group` to perform all operations on all data catalog resources in a compartment named `training-dcat-compartment`:

```
allow group training-dcat-users-group to manage data-catalog-family in compartment training-dcat-compartment
```

To allow the specified group to access the virtual network resources:

```
allow group training-dcat-users-group to manage virtual-network-family in compartment training-dcat-compartment
```

To allow the specified group to view Oracle Cloud Infrastructure users in the specified compartment who performed various actions in Data Catalog:

```
allow group training-dcat-users-group to inspect users in compartment training-dcat-compartment
```

## Learn More

* [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm).
* [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Data Catalog Policies](https://docs.oracle.com/en-us/iaas/data-catalog/using/policies.htm)
