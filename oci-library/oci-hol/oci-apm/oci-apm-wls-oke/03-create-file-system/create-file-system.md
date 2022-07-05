# Create and configure a file system

## Introduction

In this lab, you will create a file system in the Oracle Cloud Infrastructure. You will also create security rules to allow network traffic and mount the file system to the Kubernetes pods.  

Estimated time: 30 minutes

### Objectives

* Create a file system in the Oracle Cloud
*	Create security rules in the network
*	Create a YAML file, which defines Storage Class, Persistent Volume and Persistent Volume Claim
*	Mount the volume to the Kubernetes cluster by applying the YAML, which recreates the Kubernetes pods with the new storage configuration

### Prerequisites

* OCI quota and permissions to create a file system and associated resources. See **[Creating File Systems](https://docs.oracle.com/en-us/iaas/Content/File/Tasks/creatingfilesystems.htm)** and **[Service Limits](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm#top)** in the Oracle Cloud documentation.
* Completion of the Task 1 and Lab 2

## Task 1: Create a file system in the Oracle Cloud

1.	From the OCI menu, select **Storage** > **File Systems**.

   ![Oracle Cloud console, Navigation Menu](images/3-1-1-menu.png " ")

2.	Click **Create File System**

   ![Oracle Cloud console, file systems](images/3-1-2-filesystem.png " ")

3. On the Create File System page, in the **File System Information** section, click **Edit Details**.

   ![Oracle Cloud console, file systems](images/3-1-3-filesystem.png " ")

4.	On the Create File System page, enter ***apmlab-fss*** into the **Name** field.
<br><br>
Then drop down and select the **Compartment** where the cluster is running. You can find this information in the Cluster page (**Developer Services** > **Kubernetes Clusters (OKE)**). Leave the other fields with default values.

   ![Oracle Cloud console, file systems](images/3-1-4-filesystem.png " ")

5. Scrolling down the Create File System page, in the **Export Information** section, verify that the **Export Path** is set to /apmlab-fss. This is where the file system will be mounted. You will provision APM Java agent at this location.

6. In the **Mount Target Information** section, click **Edit Details** (upper right side) to expand the section. Then click the link **Click here to enable compartment selections**.

   ![Oracle Cloud console, file systems](images/3-1-5-filesystem.png " ")

7. In the Mount Target Information section, locate the **Create in Compartment** field, ensure the same compartment that the cluster uses, is selected.

8. Next, then check that the **Create New Mount Target** is selected. Select the same **Virtual Cloud Network** that the cluster is using. Select ***oke-k8sApiEndpoint-subnet..*** for **Subnet**. Leave the other fields by default and click **Create**.

   ![Oracle Cloud console, file systems](images/3-1-6-filesystem.png " ")

    > ***NOTE***: Ensure that oke-k8sApiEndpoint-subnet.. is selected for the Subnet.
    ![Oracle Cloud console, file systems](images/3-1-7-filesystem.png " ")

9.	A new File System is created.  Scroll down to find **Exports** section. Click the link to the **Mount Target** just created.

   ![Oracle Cloud console, file systems](images/3-1-8-filesystem.png " ")

10.	Click **Copy** next to the **OCID**. Save the value in a text file on your computer. Also, take a note of the **IP Address** as you will need these values in the next steps.

   ![Oracle Cloud console, file systems](images/3-1-9-filesystem.png " ")

## Task 2: Create security rules in the network

1. In the Mount Target Information section point your mouse cursor over the **“i”**  icon next to **Subnet** and review the message. As the message indicates, security rules must be configured before mounting the file system, and that is what you will be doing next.

   ![Oracle Cloud console, Security Rules](images/3-2-1-securityrules.png " ")

2.	Click the **Subnet** link to open the Subnet page.

   ![Oracle Cloud console, Security Rules](images/3-2-2-securityrules.png " ")

    >***NOTE***: If the click does not land at the subnet page properly, copy the subnet name and paste into the search box at the top of the Oracle Cloud console.  Find the correct link shows up under **Resources** and click.
   ![Oracle Cloud console, Security Rules](images/3-2-3-securityrules.png " ")

3.	In the **Subnet Details page**, scroll down and find **Security Lists** section, then click the link to the security list.

   ![Oracle Cloud console, Security Rules](images/3-2-4-securityrules.png " ")

4.	Click **Add Ingress Rules** button

   ![Oracle Cloud console, Security Rules](images/3-2-5-securityrules.png " ")

5.	In the **Add Ingress Rules** dialog, enter the following information:

     *	Stateless: **No**
     *	Source Type: **CIDR**
     *	Source CIDR: **0.0.0.0/0**
     *	IP Protocol: **TCP**
     *	Source Port Range:  leave as default (All)
     *	Destination Port Range: **111,2048-2050** 	
     *	Description: **Ingress security rule for apmlab-fss**

   ![Oracle Cloud console, Security Rules](images/3-2-6-securityrules.png " ")

6.	Click **+ Another Ingress Rule** button and create additional rule for **UDP**, with the destination port range **111,2048**. Use the same values with the rule created above for the rest of the fields.<br><br> Click **Add Ingress Rules** button which creates 4 ingress rules in the security list.

   ![Oracle Cloud console, Security Rules](images/3-2-7-securityrules.png " ")

7.	After the configuration, your **Ingress Rules** have 4 additional security rules as in the image below.

   ![Oracle Cloud console, Security Rules](images/3-2-8-securityrules.png " ")

8.	Click **Egress Rules**, which is located at the left side of the screen.

   ![Oracle Cloud console, Security Rules](images/3-2-9-securityrules.png " ")

9.	Click **Add Egress Rules** button.

   ![Oracle Cloud console, Security Rules](images/3-2-10-securityrules.png " ")

10.	In the **Add Egress Rules** dialog, enter the following information:

    *	Stressless: **No**
    *	Source Type: **CIDR**
    *	Source CIDR: **0.0.0.0/0**
    *	IP Protocol: **TCP**
    *	Source Port Range:  leave as default (All)
    *	Destination Port Range: **111,2048-2050**
    *	Description: **Egress security rule for apmlab-fss**

   ![Oracle Cloud console, Security Rules](images/3-2-11-securityrules.png " ")

11.	Click **+ Another Egress Rule** button and create additional rule for **UDP**, with the destination port **111**. Use the same values with the rule created above for the rest of the fields.<br><br> Click **Add Egress Rules** button which creates 3 egress rules in the security list.

   ![Oracle Cloud console, Security Rules](images/3-2-11-2-securityrules.png " ")

12.	After the configuration, your **Egress Rules** has 3 additional security rules as in the image below.

   ![Oracle Cloud console, Security Rules](images/3-2-12-securityrules.png " ")

## Task 3: Mount the file system to Kubernetes pods

1. Click the **>..**  icon from the top right corner in the Oracle Cloud console menu bar, to start a Cloud Shell environment which will appear at the bottom of your page.
   ![Oracle Cloud console, Menu](images/3-3-1-menu.png " ")

    >	***NOTE***: If the Cloud Shell is already running but the window is minimized, you can restore the window by clicking the bar icon or the arrow icon at the toolbar.
      ![Oracle Cloud console, Menu](images/3-3-2-menu.png " ")

2.  Run the oci ce (Container Engine) command that you saved in the Lab 1, Task1, step6.

   ![Oracle Cloud console, Cloud Shell](images/1-7-cloudshell.png " ")

3.	Create a YAML file in your home directory, by running the command below.


    ``` bash
    <copy>
    touch ~/apmlab-fss.yaml
    </copy>
    ```

4.	Use any text editor (such as vi editor tool) to open the file for editing.

    ``` bash
    <copy>
    vi ~/apmlab-fss.yaml
    </copy>
    ```

    >***NOTE***: If you are using the vi editor, type ***i*** to enter Insert mode, and make the text editable. Use allow keys to navigate the text and make changes to where you set the cursor. To save a file, press Esc key, then type ***:wq*** to write and quit the file. If you do not wish a change, press Esc then type ***:q!*** to discard your changes. Please refer to the editor references for more usages.

5. Manually copy the contents below and paste it to the file just created. Ensure to replace the **mntTargetID** and **server IP** with the values copied in the Lab 3, Task 1, step 10 in this Workshop.

        apiVersion: storage.k8s.io/v1
        kind: StorageClass
        metadata:
          name: apmlab-fss
        provisioner: oracle.com/apmlab-fss
        parameters:
          mntTargetId: <OCID of your Mount Target >
        ---
        apiVersion: v1
        kind: PersistentVolume
        metadata:
          name: apmlab-fsspv
        spec:
          storageClassName: apmlab-fss
          capacity:
            storage: 10Gi
          accessModes:
            - ReadWriteMany
          mountOptions:
            - nosuid
          nfs:
            server: <Server IP of your Mount Target>
            path: "/apmlab-fss"
            readOnly: false
        ---
        apiVersion: v1
        kind: PersistentVolumeClaim
        metadata:
          name: apmlab-fsspv
        spec:
          storageClassName: apmlab-fss
          accessModes:
          - ReadWriteMany
          resources:
            requests:
              storage: 10Gi
          volumeName: apmlab-fsspv

     >***Suggested Editing Tips***:
   	* Use your mouse to select the text above, and manually copy and paste it into a text file.
    * Auto copy is not provided as it may break the indentation.
    * Replace the ***mntTargetId*** and the ***Server IP***, then copy the modified text into the YAML file.
   	* Make sure to keep the syntax of 2 space indentation.
   	* Refer to the screenshot image below to see how it should look like after the file is modified. Verify that the Kubernetes objects, such as StorageClass, PersistentVolume and PersistentVolumeClass are configured in the YAML file.
       	![yaml](images/3-3-2-yaml.png " ")

## Task 4: Recreate Kubernetes pods

1.	From the home directory, execute the following command to add the storage objects to the Kubernetes cluster.

    ``` bash
    <copy>
    cd ~; kubectl apply -f apmlab-fss.yaml -n sample-domain1-ns
    </copy>
    ```

   ![Oracle Cloud console, Cloud Shell](images/3-3-3-cloudshell.png " ")

     >***NOTE***: If you need to modify the YAML file after once applied, first run the command below to remove the objects, modify the file, then rerun the above command to re-apply the YAML. <br>kubectl delete -f apmlab-fss.yaml -n sample-domain1-ns

2.	Open ***domain.yaml*** file that locates in the home directory, with any editor, such as vi tool.

    ``` bash
    <copy>
    vi ~/domain.yaml
    </copy>
    ```

3.	Find the **volumes:** section. At this point, the section is commented out.

   ![Oracle Cloud console, Cloud Shell](images/3-3-4-cloudshell.png " ")

4.	Uncomment the **volume** section, then replace the values as below, then save the file.

        volumes:
        - name: apmlab-nfs
          persistentVolumeClaim:
            claimName: apmlab-fsspv
        volumeMounts:
        - mountPath: "/apmlab-fss"
          name: apmlab-nfs

   ![Oracle Cloud console, Cloud Shell](images/3-3-5-cloudshell.png " ")

    >***NOTE***: ensure that the line “volumes:” is set with the same indentation level with the line “env:”.

5.	Run the following command. This will recreate the pods, with the new object configurations.

    ``` bash
    <copy>
    kubectl apply -f domain.yaml -n sample-domain1-ns
    </copy>
    ```

   ![Oracle Cloud console, Cloud Shell](images/3-3-6-cloudshell.png " ")

6.	Run the following command to ensure the pods are in the running state. You may need to wait for a few minutes to see all the pods are restarted and their status updated.

    ``` bash
    <copy>
    kubectl get pods -n sample-domain1-ns
    </copy>
    ```

    ![Oracle Cloud console, Cloud Shell](images/3-3-7-cloudshell.png " ")

    >***NOTE***: Verify the **AGE** column to ensure the pods are restarted. It typically takes 5 to 7 minutes to have all the pods restarted.

7.	Execute the following command to access the Kubernetes pods.

    ``` bash
    <copy>
     kubectl exec -it sample-domain1-admin-server -n sample-domain1-ns -- /bin/bash
    </copy>
    ```

8.	Go to the root directory and hit ls. Make sure that you see ***apmlab-fss*** directory that is the file system mounted to this location.

    ``` bash
    <copy>
    cd /; ls
    </copy>
    ```

    ![Oracle Cloud console, Cloud Shell](images/3-3-8-cloudshell.png " ")

9.	Move to the ***apmlab-fss*** and create a directory ***apmagent***

    ``` bash
    <copy>
    cd apmlab-fss; mkdir apmagent
    </copy>
    ```

10.	Ensure the ***apmagent*** directory is created

    ``` bash
    <copy>
    ls
    </copy>
    ```

    ![Oracle Cloud console, Cloud Shell](images/3-3-9-cloudshell.png " ")

11.	Go back to the Cloud Shell.


    ``` bash
    <copy>
    exit
    </copy>
    ```

    ![Oracle Cloud console, Cloud Shell](images/3-3-10-cloudshell.png " ")

    >***Debugging TIPS***: If you cannot find the apmlab-fss directory, or the pods do not start running, execute the following command from the Cloud Shell to troubleshoot. <br> kubectl get events --sort-by=.metadata.creationTimestamp -n sample-domain1-ns

## Acknowledgements

* **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,<br>
David Le Roy, Director, Product Management,<br>
Mahesh Sharma, Consulting Member of Technical Staff,<br>
Avi Huber, Senior Director, Product Management
* **Last Updated By/Date** - Yutaka Takatsu, January 2022
