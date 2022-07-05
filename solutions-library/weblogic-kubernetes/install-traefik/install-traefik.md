# Install and configure Traefik

## Introduction

The Oracle WebLogic Server Kubernetes Operator supports three load balancers: Traefik, Voyager, and Apache. Samples are provided in the [documentation](https://github.com/oracle/weblogic-kubernetes-operator/blob/v3.0.0/kubernetes/samples/charts/README.md).

This tutorial demonstrates how to install the [Traefik](https://traefik.io/) Ingress controller to provide load balancing for WebLogic clusters.

Estimated Lab Time: 10 minutes

## **STEP 1**: Install the Traefik operator with a Helm chart


1. Create a namespace for Traefik:
    ```bash
    <copy>kubectl create namespace traefik</copy>
    ```
    Install the Traefik operator in the `traefik` namespace with the provided sample values:

    ```bash
    <copy>helm repo add traefik https://helm.traefik.io/traefik</copy>
    ```

2. Get the value overrides from the github repository:
    ```bash
    <copy>
    curl -L -o traefik-values.yaml https://raw.githubusercontent.com/oracle/weblogic-kubernetes-operator/v3.0.0/kubernetes/samples/charts/traefik/values.yaml
    </copy>
    ```

    ```bash
    <copy>helm install traefik-operator \
    traefik/traefik \
    --namespace traefik \
    --values traefik-values.yaml \
    --set "kubernetes.namespaces={traefik}" \
    --set "serviceType=LoadBalancer"</copy>
    ```

    The output should be similar to the following:
    ```bash
    NAME: traefik-operator
    LAST DEPLOYED: Sun Dec 19 07:30:22 2021
    NAMESPACE: traefik
    STATUS: deployed
    REVISION: 1
    TEST SUITE: None
    NOTES:
    ```

3. The Traefik installation is basically done. Verify the Traefik (load balancer) services:
    ```bash
    <copy>kubectl get service -n traefik</copy>
    ```
    The output should be similar to the following:
    ```bash
    NAME               TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)                      AGE
    traefik-operator   LoadBalancer   10.96.25.22   132.226.153.42   80:30655/TCP,443:32269/TCP   96s
    ```
    >Please note the EXTERNAL-IP of the *traefik-operator* service. This is the public IP address of the load balancer that you will use to access the WebLogic Server Administration Console and the sample application.

4. To print only the public IP address, execute this command:
    ```bash
    <copy>kubectl describe svc traefik-operator --namespace traefik | grep Ingress | awk '{print $3}'</copy>
    ```
    The output should be similar to the following:
    ```bash
    132.226.153.42
    ```

5. Verify the `helm` charts:
    ```bash
    <copy>helm list -n traefik</copy>
    ```
    The output should be similar to the following:
    ```bash
    NAME                    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
    traefik-operator        traefik         1               2021-12-19 07:30:22.594021816 +0000 UTC deployed        traefik-10.7.1  2.5.4      
    ```

You may now **proceed to the next lab**.

## Acknowledgements
* **Author** -  Ankit Pandey
* **Contributors** - Maciej Gruszka, Peter Nagy
* **Last Updated By/Date** - Ankit Pandey, April 2022
