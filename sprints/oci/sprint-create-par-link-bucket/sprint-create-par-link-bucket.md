# How can I create a Pre-Authenticated Request for a bucket?

Duration: 3 minutes

## Create Pre-Authenticated Request (PAR) for a bucket

Make sure you are in the region where your Bucket is to create a PAR link and then follow the steps below to create a PAR link for a bucket:

1. Open the navigation menu on the left in the Oracle Cloud console, click **Storage**, and then click **Buckets** under Object Storage & Archive Storage.

2. Click on the **Compartment** drop-down under List Scope and choose the Compartment where your Bucket is.

3. In the Compartment, click on the three dots to the extreme right of the bucket name for which you want to create the PAR link.

4. From the menu, click on **Create Pre-Authenticated Request**.

6. In the Create Pre-Authenticated Request dialog box:
    - **Name:** Give a name for the Pre-Authenticated Request
    - **Pre-Authenticated Request Target:** Choose **Bucket** as we are creating a PAR link for a bucket
    - **Access Type:** - Leave it to default, **Permit object reads**
    - **Enable Object Listing** - Check this box to list the objects in the Bucket
    - **Expiration:** Click the calendar icon to choose a date for the PAR link to expire

7. Click **Create Pre-Authenticated Request**.

8. In the Pre-Authenticated Request Details dialog box, click on the copy button for the Pre-Authenticated Request URL to copy and save it for later use. *Note that this link will not be generated again. Make sure to save it safely.*

9. Click **Close** to close the Pre-Authenticated Request Details dialog box.

10. To verify, paste the PAR link in a new tab in the browser and hit enter. You can view all the files in the Bucket. Copy the file name along with extension and paste it at the end of the PAR link of the bucket in a new tab in the browser to download the file.

## Learn More

* [Explore more about Object Storage in Oracle Cloud.](https://docs.oracle.com/en-us/iaas/Content/Object/home.htm)
* [Using Pre-authenticated Requests](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/usingpreauthenticatedrequests.htm)