# How do I provision an OCI Data Catalog instance?
Duration: 5 minutes

### Prerequisites
* An Oracle Cloud Account.
* A compartment for your Data Catalog instance and resources.
* A policy to allow users to create, update, and delete data catalog instances in a  tenancy or a specific compartment.

## Create a Data Catalog Instance
Create a Data Catalog instance as follows:

1. Sign in to the Oracle Cloud Infrastructure Console.

2. Open the **Navigation** menu and click **Analytics & AI**. Under **Data Lake**, click **Data Catalog**.

3. On the **Data Catalog Overview** page, click **Go to Data Catalogs**.

4. On the **Data Catalogs** page, click **Create Data Catalog**.

5. Select your compartment where you would like to provision the Data Catalog instance. In this example, we selected a compartment named **`training-dcat-compartment`** from the **Create In Compartment** drop-down list.

6. Enter a name for your Data Catalog instance in the **Name** field, and then click **Create Data Catalog**.

    ![The completed Create Data Catalog dialog box is displayed. The Create Data Catalog button is highlighted.](./images/create-data-catalog.png " ")

7. The Data Catalog instance is created and displayed in the **Data Catalogs** page. To use your newly created Data Catalog instance, click the instance name link in the **Name** column.

    ![The newly created Data Catalog instance is displayed with an Active state.](./images/click-data-catalog.png " ")

## Learn More

* [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm).
* [Data Catalog Documentation](https://docs.oracle.com/en-us/iaas/data-catalog/home.htm)
* [Data Catalog Policies](https://docs.oracle.com/en-us/iaas/data-catalog/using/policies.htm)
* [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Access the Data Lake using Autonomous Database and Data Catalog Workshop](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=877)
