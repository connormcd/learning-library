# How do I create a new vault?
Duration: 3 minutes

The Vault service lets you create vaults in your tenancy as containers for encryption keys and secrets. If needed, a virtual private vault provides you with a dedicated partition in a hardware security module (HSM), offering a level of storage isolation for encryption keys that’s effectively equivalent to a virtual independent HSM.

## Create a New Vault

Perform the following prerequisite steps as necessary:
* Open the navigation menu, click **Identity & Security**, and then click **Vault**.
* Under **List Scope**, in the **Compartment** list, click the name of the compartment where you want to create the vault.

To create a vault through the OCI console:
1. Click **Create Vault**.
2. In the **Create Vault** dialog box, click **Name**, and then enter a display name for the vault. Avoid entering confidential information.
3. (OPTIONAL) Make the vault a virtual private vault by selecting the **Make it a virtual private vault** check box.
4. When you are finished, click **Create Vault**.

To create a vault through the Command Line Interface (CLI), run the following command:

```
<copy>
oci kms management vault create --compartment-id <target_compartment_id> --display-name <vault_name> --vault-type <vault_type>
</copy>
```

To create a vault with **resource tags** through the Command Line Interface (CLI), run the following command:

```
<copy>
oci kms management vault create --compartment-id <target_compartment_id> --display-name <vault_name> --vault-type <vault_type> --defined-tags <JSON_formatted_defined_tag> --freeform-tags <JSON_formatted_freeform_tag>
</copy>
```

**Note:**
If you have permissions to create a resource, then you also have permissions to apply free-form tags to that resource. To apply a defined tag, you must have permissions to use the tag namespace. If you are not sure whether to apply tags, skip this option (you can apply tags later) or ask your administrator.

## Learn More

* [OCI Command Line Interface](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm)
* [OCI CL Command Reference](https://docs.oracle.com/en-us/iaas/tools/oci-cli/2.9.5/oci_cli_docs/index.html)
* [Key and Secret Management Concepts](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm#concepts)
* [Resource Tags](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/resourcetags.htm#Resource_Tags)
