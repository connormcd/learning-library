# How do I download files in Object Storage?

Duration: 3 minutes

## Download files in an object storage

Enure you are in the correct region to your file(s) in object storage. Follow the steps below to download a file in a public bucket:

1. Open the navigation menu on the left in the Oracle Cloud console, click **Storage**, and then click **Buckets** under Object Storage & Archive Storage.

2. Click on the **Compartment** drop-down under List Scope and choose the Compartment where your file is.

3. In the Compartment, look for the bucket that has your file and then look at the status under visibility - Public or Private.

4. If your bucket is private, you need to [create Pre-Authenticated Request](https://oracle.github.io/learning-library/sprints/oci/sprint-create-par-link/) to download the files in the bucket.

5. If your bucket is public, click on the bucket name that has your file.

6. In the Bucket Details page, scroll down to the Objects region and click on the three dots to the extreme right for the file you want to download.

7. From the menu, click on **View Object Details**.

8. Click **Download** in the Object Details dialog box to download the file from the Oracle Cloud console.

9. Or, in the Object Details dialog box, copy the **URL Path (URI)** link and save it for later to download the file anytime without navigating to the bucket in the Oracle Cloud console. Click **Cancel** to close the Object Details dialog box.

10. To verify, paste the URL Path (URI) link copied earlier in a new tab in the browser and hit enter. This will download the file.

## Learn More

* [Explore more about Object Storage in Oracle Cloud.](https://docs.oracle.com/en-us/iaas/Content/Object/home.htm)
* [Using Pre-authenticated Requests](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/usingpreauthenticatedrequests.htm)