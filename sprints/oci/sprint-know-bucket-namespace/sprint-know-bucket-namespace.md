# How do I know the namespace of my bucket in Object Storage?

Duration: 3 minutes

## Know the namespace of a bucket in object storage

Follow the steps below to know your bucket namespace:

1. Open the navigation menu on the left in the Oracle Cloud console, click **Storage**, and then click **Buckets** under Object Storage & Archive Storage.

2. Click on the **Compartment** drop-down under List Scope and choose a Compartment with a bucket.

3. Click on a bucket name to navigate the bucket details page.

4. In the Bucket Details page, under the bucket information General section, view your bucket namespace.

5. An alternative way to know your namespace is, you need to scroll down to the Objects region and click on the three dots to the extreme right for a file.

6. From the menu, click **View Object Details**. The URL Path(URI) looks like this:

    ```
    https://objectstorage.<region name>.oraclecloud.com/n/<namespace name>/b/<bucket name>/o

    ```

7. Copy the value after */n/*, which is your bucket namespace. Click **Cancel** to close the Object Details dialog box.

## Learn More

* [Explore more about Object Storage in Oracle Cloud.](https://docs.oracle.com/en-us/iaas/Content/Object/home.htm)
