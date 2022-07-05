# How do I back up a vault?
Duration: 5 minutes

Currently, the only type of vault you can back up is a virtual private vault. Similarly, the only type of encryption key that you can back up is a master encryption key protected by a hardware security module (HSM). You cannot back up master encryption keys protected by software. You also cannot back up secrets.

You might want to back up a vault or encryption key before deleting either if you don't need them now, but think you might need to use the key for decryption later. Deleting a vault and key otherwise means losing the ability to decrypt any resource or data that the key was used to encrypt. Restoring a key lets you resume using a resource that was previously encrypted by the key.

You might also create a backup of a vault to use in a disaster recovery scenario. You can restore a backup in any region within the realm, making it possible to access encrypted resources even in disaster recovery scenarios where the region of the backed-up resource is no longer available.

## Back Up a Vault

Perform the following prerequisite steps as necessary:
* Open the navigation menu, click **Identity & Security**, and then click **Vault**.
* Under **List Scope**, in the **Compartment** list, click the name of the compartment where you want to create the vault.
* From the list of vaults in the compartment, click the name of the vault.

To back up a vault:
1. On the **Vault Details** page, click **Back Up Vault**.
2. Choose a source: export a backup to either an **Existing Object Storage Bucket** (recommended) or a pre-authenticated Object Storage **URL** for an object that you can write to.
3. Do one of the following, depending on what you chose in the previous step:

Choose a bucket from the dropdown menu. If needed, you can change the compartment to find a bucket in a different compartment. Then, specify the Backup Name. Avoid entering confidential information.

OR

Click Object Storage URL, and then provide a pre-authenticated URL for an object.

4. Optionally, to back up only the vault without any keys, select the **Back up vault metadata only** check box.
5. When you are finished, click **Back Up Vault**. (Note the compartment so that you can restore this resource to the right compartment later.)

## Learn More

* [OCI Command Line Interface](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm)
* [OCI CL Command Reference](https://docs.oracle.com/en-us/iaas/tools/oci-cli/2.9.5/oci_cli_docs/index.html)
* [Key and Secret Management Concepts](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm#concepts)
* [Resource Tags](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/resourcetags.htm#Resource_Tags)
