# How do I find a region identifier?
There are several ways to find out the region identifier which is associated with your region name that is displayed in the **Console** banner.

Duration: 2 minutes

### Prerequisites
* An Oracle Cloud Account.

## Find a Region Identifier

1. Sign in to the Oracle Cloud Infrastructure Console.

2. Examine your URL for your environment. It contains the region identifier. In the following example, the region name in the banner is **US West (Phoenix)**. You can find the region identifier that is associated with this region name in the URL which is **us-phoenix-1**.

  ![The region id in this example is displayed and highlighted in the Console banner, US West (Phoenix). The URL in the Address bar shows the region identifier for this region name, us-phoenix-1.](./images/region-id-url-method.png " ")

3. Alternatively, click the displayed region drop-down list on the banner to display the **Regions** drop-down menu. Click **Manage Regions**. On the **Infrastructure Regions** page, find and copy the region identifies that is associated with the region displayed on the banner which is **us-ashburn-1** in the following example.

  ![The region in this example is displayed and highlighted in the Console banner. On the Infrastructure Regions page, the region Identifier that is associated with the region displayed on the banner is highlighted.](./images/ll-regions-identifier.png " ")

4. If your region identifier that is associated with the region name displayed in the banner is not displayed in the above **Infrastructure Regions** page, see the [Regions and Availability Domains documentation](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm). Next, find and copy the region identifier that is associated with your region name.

  ![The partial Regions and Availability Domains documentation is displayed. The US East (Ashburn) region name and its associated region id, us-ashburn-1, are highlighted.](./images/regions-doc.png " ")

5. If you are running your workshop using a LiveLabs reservation, on the **Launch _workshop name_ Workshop** page, in the **Workshop Details** section, the **Region** row lists your region name and identifier. Copy the region identifier next to your assigned region name, **us-phoenix-1** in the following example.

    ![On the Launch workshop name page, the Workshop Details section, region name, and region identifier are highlighted.](./images/ll-region-id.png " ")

You can now paste your copied region identifier anywhere you need it.

## Learn More

* [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm).
* [Regions and Availability Domains documentation](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm).
* [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
