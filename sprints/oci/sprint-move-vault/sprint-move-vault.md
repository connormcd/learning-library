# How do I move a vault to a different compartment?
Duration: 2 minutes

The Vault service lets you create vaults in your tenancy as containers for encryption keys and secrets. If needed, a virtual private vault provides you with a dedicated partition in a hardware security module (HSM), offering a level of storage isolation for encryption keys that’s effectively equivalent to a virtual independent HSM.

## Move a Vault to a Different Compartment

Perform the following prerequisite steps as necessary:
* Open the navigation menu, click **Identity & Security**, and then click **Vault**.
* Under **List Scope**, in the **Compartment** list, click the name of the compartment where you want to create the vault.

To move your vault:
1. Find the vault in the list, click the the Actions menu, and then click **Move Resource**.
2. Choose the destination compartment from the list.
3. Click **Move Resource**.

To move a vault through the Command Line Interface (CLI), run the following command:

```
<copy>
oci kms management vault change-compartment --vault-id <target_vault_id> --compartment-id <new_compartment_id>
</copy>
```

## Learn More

* [OCI Command Line Interface](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm)
* [OCI CL Command Reference](https://docs.oracle.com/en-us/iaas/tools/oci-cli/2.9.5/oci_cli_docs/index.html)
* [Key and Secret Management Concepts](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm#concepts)
* [Resource Tags](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/resourcetags.htm#Resource_Tags)
