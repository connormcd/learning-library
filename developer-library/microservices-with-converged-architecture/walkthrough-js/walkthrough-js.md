# Switch to the MLE JavaScript Microservice Implementation

## Introduction

This lab will walk through the Grabdish application functionality written in JavaScript.

Estimated Time: 10 minutes

### Objectives

-   Access the microservices
-   Learn how they work

### Prerequisites

* The Grabdish application you deployed in Lab 2

## Task 1: Switch the Microservices to the JavaScript Implementation

1.  Run the switch script in the cloud shell:

    ```
    <copy>switch js js</copy>
    ```

    **Note** The switch script parameters select the microservice implementation.  The first parameter is the Order microservice implementation - js or plsql.  The second parameter is the Inventory microservice implementation - js or plsql.  All combinations are supported.

2.  The switch script will ask you to enter an admin password for the database that you chose in Lab 2.

3.  The switch script performs the following actions:
    * Deploys the Order microservice in the database
    * Deploys the Inventory microservice in the database

4.  Once the switch script has successfully completed the status will be displayed.

   ![GrabDish is DEPLOYED Status is Displayed](images/switched.png " ")

## Task 2: Verify the Order and Inventory Functionality of GrabDish Store

   1. Navigate back to the GrabDish UI and confirm that the functionality is the same with the JavaScript implementation.

You may now proceed to the next lab.

## Acknowledgements
* **Author** - Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
* **Contributors** - Paul Parkinson, Architect and Developer Evangelist
* **Last Updated By/Date** - Richard Exley, April 2022
