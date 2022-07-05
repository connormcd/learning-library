# How do I get the URI for a bucket in Object Storage?

Duration: 3 minutes

## Get URI for a bucket in object storage

Ensure you are in the correct region to access the bucket in object storage. Follow the steps below to get the URI for your bucket:

1. Open the navigation menu on the left in the Oracle Cloud console, click **Storage**, and then click **Buckets** under Object Storage & Archive Storage.

2. Click on the **Compartment** drop-down under List Scope and choose the Compartment where your file is.

3. In the Compartment, click on the bucket name for which you want to get the URI.

4. In the Bucket Details page, scroll down to the Objects region and click on the three dots to the extreme right for a file.

5. From the menu, click **View Object Details**.

6. The Bucket URI is the URL path without the file name suffix. Copy the **URL Path (URI)** link without the file name in the Object Details dialog box.

    The Bucket URI link should look like this:

    ```
    https://objectstorage.<region name>.oraclecloud.com/n/<namespace name>/b/<bucket name>/o
    ```

7. Click **Cancel** to close the Object Details dialog box.

## Learn More

* [Explore more about Object Storage in Oracle Cloud.](https://docs.oracle.com/en-us/iaas/Content/Object/home.htm)
