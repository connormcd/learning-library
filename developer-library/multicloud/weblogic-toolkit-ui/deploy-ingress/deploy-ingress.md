# Deployment of Ingress Controller to the Oracle Container Engine for Kubernetes (OKE) on Oracle Cloud Infrastructure (OCI) From WebLogic Kubernetes Toolkit UI

## Introduction

In this lab, we install the *Traefik* Ingress Controller. Later, we updates the *Ingress Routes* to access the application and admin server.

### Objectives

In this lab, you will:

* Install Ingress Controller on Kubernetes Cluster.
* Update the Ingress Routes.


## Task 1: Installtion of Ingress Controller to the Oracle Kubernetes Cluster

In this task, we install the *Ingress Controller*.

1. Click *Ingress Controller*. You can see some pre-filled values, let it remain the same and click *Install Ingress Controller*.
    ![Install Ingress Controller](images/install-ingress-controller.png)
    > **For your information only:**<br>
    > This successfully install the *traefik-operator* ingress controller to Kubernetes namespace *traefik-ns*. 

2. Once you see *Ingress Controller Installation Complete*, click *Ok*.
    ![Ingress Controller Installed](images/ingress-controller-installed.png)


## Task 2: Update the Ingress Routes to Access the Application

In this task, we add the Ingress routes for Accessing the Admin Console, Application. At the end, we get the accessible endpoints.

1. Scroll down and click on *+* icone to add the *Ingress Route Configuration*. 
    ![Add Ingress Routes](images/add-ingress-routes.png)

2. Click on Edit icon as shown to modify the values.
    ![Edit Ingress](images/edit-ingress.png)

3. Enter the following details and click on *OK*.<br>
        Name: console<br> 
        Path Expression: /console<br>
        Target Service Namespace: test-domain-ns<br>
        Target Service: test-domain-admin-server<br>
        Target Port: 7001<br>

    ![Console Ingress](images/console-ingress.png)

4. In the similar way, add the following *opdemo* Ingress Routes as well:<br>
        Name: opdemo<br>
        Path Expression: /opdemo<br>
        Target Service Namespace: test-domain-ns<br>
        Target Service: test-domain-cluster-cluster-1 <br>
        Target Port: 8001<br>
    ![Opdemo Ingress](images/opdemo-ingress.png)

5. In the similar way, add the following *remote-console* Ingress Routes as well:<br>
        Name: remote-console<br>
        Path Expression: / <br>
        Target Service Namespace: test-domain-ns<br>
        Target Service: test-domain-admin-server<br>
        Target Port: 7001<br>
        ![Remote Console Ingress](images/remote-console-ingress.png)

6. To update the Inress Routes, click *Update Ingress Routes*.
    ![Update Ingress Routes](images/update-ingress-routes.png)

7. Once you see *Ingress Routes Update Complete* window, Click *Ok*.
    ![Update Ingress Complete](images/update-ingress-complete.png)
    
    > You need to notedown this IP and save it in text file.

## Acknowledgements

* **Author** -  Ankit Pandey
* **Contributors** - Maciej Gruszka, Sid Joshi
* **Last Updated By/Date** - Kamryn Vinson, March 2022