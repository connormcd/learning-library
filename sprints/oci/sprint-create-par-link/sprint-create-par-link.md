# How can I create a Pre-Authenticated Request for an object in the bucket?

Duration: 3 minutes

## Create Pre-Authenticated Request (PAR) for an object in the bucket

Make sure you are in the region where your file is to create a PAR link and then follow the steps below to download the files in a private bucket:

1. Open the navigation menu on the left in the Oracle Cloud console, click **Storage**, and then click **Buckets** under Object Storage & Archive Storage.

2. Click on the **Compartment** drop-down under List Scope and choose the Compartment where your file is.

3. In the Compartment, click on the bucket name to access the file for which you want to create the PAR link.

4. In the Bucket Details page, scroll down to the Objects region and click on the three dots to the extreme right for the file you want to create the PAR link.

5. From the menu, click on **Create Pre-Authenticated Request**.

6. In the Create Pre-Authenticated Request dialog box:
    - **Name:** Give a name for the Pre-Authenticated Request
    - **Pre-Authenticated Request Target:** Choose **Object** as we are creating a PAR link for a specific object
    - **Object Name:** - Ensure you are creating the PAR for the correct file
    - **Access Type:** - Leave it to default, **Permit object reads**
    - **Expiration:** Click the calendar icon to choose a date for the PAR link to expire

7. Click **Create Pre-Authenticated Request**.

8. In the Pre-Authenticated Request Details dialog box, click on the copy button for the Pre-Authenticated Request URL to copy and save it for later use. *Note that this link will not be generated again. Make sure to save it safely.*

9. Click **Close** to close the Pre-Authenticated Request Details dialog box.

10. To verify, paste the PAR link in a new tab in the browser and hit enter. This will download the file.

## Learn More

* [Explore more about Object Storage in Oracle Cloud.](https://docs.oracle.com/en-us/iaas/Content/Object/home.htm)
* [Using Pre-authenticated Requests](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/usingpreauthenticatedrequests.htm)