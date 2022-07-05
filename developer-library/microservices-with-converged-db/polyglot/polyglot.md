# Polyglot Microservices

## Introduction

The illustration below shows four microservices: Order, Inventory, Delivery, Supplier, and the infrastructure required to run them.

![Microservices Architecture](images/architecture.png " ")

For more information on microservices visit http://developer.oracle.com/microservices

In this workshop, you'll switch the Inventory microservice to a Python, Node.js, .NET, Go, Spring Boot or Java Helidon SE implementation while retaining the same application functionality.

Estimated Time: 10 minutes

The following video provides a quick walk-through of how to switch the Inventory microservice to Python while retaining the same application functionality.

[](youtube:zltpjX721PA)

### Objectives

-   Undeploy the existing Java Helidon MP Inventory microservice
-   Deploy an alternate implementation of the Inventory microservice and test the application functionality

### Prerequisites

This lab assumes you have already completed the earlier labs.

## Task 1: Undeploy the Java Helidon MP Inventory Microservice

1. To undeploy the Inventory Helidon MP service, open Cloud Shell and go to the   inventory-helidon folder, using the following command.

    ```
    <copy>
    cd $GRABDISH_HOME/inventory-helidon ; ./undeploy.sh
    </copy>
    ```

   ![Undeploy Inventory Service](images/undeploy-inventory-helidon-mp.png " ")

## Task 2: Deploy an Alternate Implementation of the Inventory Microservice

In this step you can choose between six different implementations of the Inventory Microservice: PL/SQL, Python, NodeJS, .NET, Go, or Java Helidon SE.

1. Select one of the alternate implementations and deploy the service for the selected implementation.  

  If you selected **PL/SQL**, deploy this service:

    ```
    <copy>cd $GRABDISH_HOME/inventory-plsql; ./deploy.sh</copy>
    ```

   If you selected **Python**, deploy this service:

    ```
    <copy>cd $GRABDISH_HOME/inventory-python; ./deploy.sh</copy>
    ```

   If you selected **Node.js**, deploy this service:

    ```
    <copy>cd $GRABDISH_HOME/inventory-nodejs; ./deploy.sh</copy>
    ```

   If you selected **.NET**, deploy this service:

    ```
    <copy>cd $GRABDISH_HOME/inventory-dotnet; ./deploy.sh</copy>
    ```

   If you selected **Go**, deploy this service:

    ```
    <copy>cd $GRABDISH_HOME/inventory-go; ./deploy.sh</copy>
    ```

   If you selected **Java Helidon SE**, deploy this service:

    ```
    <copy>cd $GRABDISH_HOME/inventory-helidon-se; ./deploy.sh</copy>
    ```

   If you selected **Micronaut**, deploy this service:

    ```
    <copy>cd $GRABDISH_HOME/inventory-micronaut; ./deploy.sh</copy>
    ```

   If you selected **Quarkus**, deploy this service:

    ```
    <copy>cd $GRABDISH_HOME/inventory-quarkus; ./deploy.sh</copy>
    ```

   If you selected **GraalVM Native Image**, you will need to build the image in an environment/machine that has more memory/space than the cloud console.
   Refer to the `Task 11: ` in Lab 2 for details on how to do this and run the following command to build and push the image from that environment:

    ```
    <copy>cd $GRABDISH_HOME/inventory-micronaut; ./build-native-image.sh</copy>
    ```

   Then run the following command to deploy. This can be done from either the same environment/machine as the build or the cloud shell.

    ```
    <copy>cd $GRABDISH_HOME/inventory-micronaut; ./deploy-native-image.sh</copy>
    ```

## Task 3: Verify Application Functionality

1. Repeat **Lab 2: Step 3** to verify that the functionality of the GrabDish store remains the same while using the new implementation. You will need to use different order ID's, for example 166 and 167.

## Task 4: Re-deploy the Java Helidon MP Inventory Microservice

1. To undeploy any other inventory services and then deploy the Inventory Helidon MP service, issue the following commands:

    ```
    <copy>
    for i in inventory-plsql inventory-helidon-se inventory-python inventory-nodejs inventory-dotnet inventory-go inventory-springboot inventory-micronaut inventory-quarkus; do cd $GRABDISH_HOME/$i; ./undeploy.sh; done
    cd $GRABDISH_HOME/inventory-micronaut ; ./undeploy-native-image.sh
    cd $GRABDISH_HOME/inventory-helidon ; ./deploy.sh
    cd $GRABDISH_HOME
    </copy>
    ```

You may now proceed to the next lab.

## Learn More

* Ask for help and connect with developers on the [Oracle DB Microservices Slack Channel](https://bit.ly/oracle-database-microservices-slack)   
Search for and join the `oracle-db-microservices` channel.

## Acknowledgements
* **Authors** - Richard Exley, Maximum Availability Architecture; Curtis Dinkel, Maximum Availability Architecture; Rena Granat, Maximum Availability Architecture; Paul Parkinson, Developer Evangelist; Mayank Tayal, Developer Advocate
* **Adapted for Cloud by** -  Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Irina Granat, March 2022
