# How do I create an access policy for a dynamic group?
Duration: 5 minutes

After you create a dynamic group, you need to create a policy to permit the dynamic group to access Oracle Cloud Infrastructure services.

### Prerequisites
* An Oracle Cloud Account.
* A compartment.
* A dynamic group.

## Create an Access Policy for a Dynamic Group         
Create a policy to allow any resource in _your dynamic group_ to access and manage _your Data Catalog_ in _your compartment_ (`training-dcat-compartment` in this example) using the aggregate resource-type **`data-catalog-family`** as follows:

1. Open the **Navigation** menu and click **Identity & Security**. Under **Identity**, select **Policies**.

2. On the **Policies** page, make sure that _your compartment_ is selected in the **List Scope** section, and then click **Create Policy**.  

    ![The Create Policy button is highlighted. The List Scope section shows the training-dcat-compartment selected in the compartment drop-down list.](./images/create-os-policy.png " ")

3. In the **Create Policy** dialog box, provide the following information:
    + Enter a unique name in the **Name** field (**`moviestream-data-catalog-policy`** in this example).
    + Enter an optional description in the **Description** field.
    + Select _your compartment_ from the **Compartment** drop-down list, if it's not already selected (**`training-dcat-compartment`**  in this example).
    + In the **Policy Builder** section, click and slide the **Show manual editor** slider to enable it. An empty text box is displayed in this section.
    + Allow any resource in the dynamic group (**`moviestream-dynamic-group`** in this example) such as ADB to access and manage _your Data Catalog_ in _your seclected compartment_ (`training-dcat-compartment` in this example). Click the **Copy** button in the following code box, and then paste it in the **Policy Builder** text box. This policy statement allows any resource in the dynamic group named `moveistream-dynamic-group` to access and manage the Data Catalog in compartment named `training-dcat-compartment`.

        ```
        <copy>allow dynamic-group moviestream-dynamic-group to manage data-catalog-family in compartment training-dcat-compartment</copy>
        ```

        ![On the completed Create Policy dialog box, the policy in the Policy Builder field and the Create button are highlighted.](./images/dynamic-group-instances-os-policy.png " ")

    + Click **Create**. The **Policy Detail** page is displayed Click **Policies** in the breadcrumbs to return to the **Dynamic Groups** page.

    ![The new policy details page is displayed. The Policies link in the breadcrumbs is highlighted.](./images/object-storage-policy-detail.png " ")

    The newly created policy is displayed on the **Policies** page.

    ![The new policy, the description, and number of statements (1) are displayed on the Policies page.](./images/moviestream-dcat-policy-created.png " ")


## Learn More

* [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm).
* [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Managing Dynamic Groups](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingdynamicgroups.htm)
* [Data Catalog Policies](https://docs.oracle.com/en-us/iaas/data-catalog/using/policies.htm)
* [Data Catalog Documentation](https://docs.oracle.com/en-us/iaas/data-catalog/home.htm)
