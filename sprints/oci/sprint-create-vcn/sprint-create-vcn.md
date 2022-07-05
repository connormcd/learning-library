# How do I create a VCN using OCI CLI?
Duration: 1 minute

## Create a virtual cloud network (VCN) using OCI CLI

Before you can launch any instances, you have to create a virtual cloud network (VCN) and related resources. The following tasks are used to prepare the network environment:

1. Create the VCN, specifying a DNS name and a CIDR block range. To create the VCN, run the following command.

```
<copy>
oci network vcn create --compartment-id <compartment_id> --display-name "<friendly_name>" --dns-label <dns_name> --cidr-block "<0.0.0.0/0>"
</copy>
```

## Learn More

* [Creating a Virtual Cloud Network](https://docs.oracle.com/en-us/iaas/Content/GSG/Tasks/gettingstartedwiththeCLI.htm)
