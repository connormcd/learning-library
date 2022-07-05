# Run mongosh and use it to load and query some data in Autonomous Database (In progress)

## Introduction

Estimated Time: xx minutes

### Objectives

### Prerequisites

## Task 1: 

1. We need to connect from our local machine using the MongoDB tool **mongosh**. This can be installed from MongoDB's page [here](https://www.mongodb.com/try/download/shell).

2. Make sure you're not connecting through any kind of VPN or proxy server (which will alter your IP address and prevent you from connecting), and run mongosh from a command prompt with "-user admin" and the URL we modified in lab 1, enclosed in single quotes (Linux/Mac) or double quotes (Windows). So the command will look something like:

    ```
    mongosh -u admin -p MyPassword123 'mongodb://autonomousDatabaseAddress:27017/admin?authMechanism=PLAIN&authSource=$external&ssl=true&retryWrites=false&loadBalanced=true'
    ```

## Acknowledgements

- **Author** - Roger Ford, Principal Product Manager
- **Contributors** - Kamryn Vinson, Database Product Management
- **Last Updated By/Date** - Kamryn Vinson, March 2022
