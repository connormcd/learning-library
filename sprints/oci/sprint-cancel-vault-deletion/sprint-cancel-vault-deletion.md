# How do I cancel the deletion of a vault?
Duration: 2 minutes

The Vault service lets you create vaults in your tenancy as containers for encryption keys and secrets. If needed, a virtual private vault provides you with a dedicated partition in a hardware security module (HSM), offering a level of storage isolation for encryption keys that’s effectively equivalent to a virtual independent HSM.

## Cancel Vault Deletion

Perform the following prerequisite steps as necessary:
* Open the navigation menu, click **Identity & Security**, and then click **Vault**.
* Under **List Scope**, in the **Compartment** list, click the name of the compartment where you want to create the vault.

To cancel the deletion of a vault:
1. From the list of vaults in the compartment, click the name of the vault.
2. On the **Vault Details** page, click **Cancel Deletion**.
3. To confirm that you want to cancel deletion of the vault, click **Cancel Deletion**.

To cancel the deletion of a vault through the Command Line Interface (CLI), run the following command:

```
<copy>
oci kms management vault cancel-deletion --vault-id <target_vault_id>
</copy>
```

## Learn More

* [OCI Command Line Interface](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm)
* [OCI CL Command Reference](https://docs.oracle.com/en-us/iaas/tools/oci-cli/2.9.5/oci_cli_docs/index.html)
* [Key and Secret Management Concepts](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm#concepts)
* [Resource Tags](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/resourcetags.htm#Resource_Tags)
