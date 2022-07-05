# Process Integration Test

## Introduction

The Lab will cover how to test the process integration mapped Milestones/Identifiers. How to view the test in the Insight Console and some of the standard dashboard views.

Estimated Time: 10 minutes

## Prerequisites

This lab assumes you have:
- Completed Labs 1 through 6

## Learning Objectives

In this lab, you will learn how to create the following:
- Console Views
- Standard Dashboards
- Map Testing

Insight automatically creates and associated Console when a model, with defined business processes, has been activated.

The Consoles page shows the status of all business processes and includes a high-level visualization of the metrics collected over the past day for all activated business processes.

Consoles can be accessed either fromm the Oracle Integration navigational pane or from the Insight tile on the Oracle Integration home page. Consoles names are the same as the Model name or Business Process that was mapped.

Double-click on a dashboard to open the Business Transaction Details dashboard for that dashboard. The following dashboards support drilling down into the transaction details:
* **Passed Milestones**: Double-click any milestone bar to show the business transactions (instances) that have passed that milestone.
* **Milestones Summary**: Double-click any milestone bubble to show the business transactions (instances) associated with the milestone.
* **Active Transactions**: Double-click any business transaction bar to show the active business transactions. Because a business transaction state may change between the time the dashboard displayed and the time you clicked a bar, you may not see the same business transactions on the Business Transaction Details dashboard.
* **Transaction Errors**: Double-click any slice on the pie chart to show the business transactions in Error state.
* **Avg. Transaction Completion Time**: Double-click any bubble on the bubble chart to show the business transactions in Successful or Failed state, depending on the bubble you clicked.
### Access the Console
    A. Go to Integration Insight    
        1. Click Insight
        2. Click Console
        3. Double Click the Console to reach the Dashboards
Testing your mappings is vital. Ensuring that the mapped item function correctly and provide needed information in the console.  

### Map Testing
    A.  Access Integrations  
        1. Hover over the Status and the Run icon (forward arrow) will appear
            a. Select from dropdown the Operation you wish to test. 
        2. Click on the icon and message box will appear, click on the word "Test"
        3. Now you need to configure your request properties.
            a. Under the Request area, click on Tab named "Body" 
            b. Click "File" and choose your saved file 
                OR 
            c. Click text and copy the json file information
        4. Click "Test", located far center right of screen
        5. You will receive a message box and then see the Activity stream 
            a. Activity stream will showcase in Ascending order and will show green if successful
            b. Activity stream will showcase yellow or red, if unsuccessful

Now your turn to try!

 You will test you mapping and then view the results of the order in the created Console and Dashboard. 

## Task 1: Test Mapping

Open the Integration named **Order Processing Lab** in Test. Copy the following information:

```
    <copy>
{  
"orderId": "1000",  
"product": "Laptop", 
"quantity": 5, 
"unitPrice": 1500,  
"discount": 0,  
"country": "US"  
} 
    </copy>
```

You will need to open the Console page to verify.

## Task 2: Console View

Access the Console to view your Console named ***My Order Process**. Click on Console Manifest to view the names of the dashboards. You wil see both the dropdowns for the Dashboard names and the Filter Details which showcases the Milestones and the Identifier.
    
## Task 3: Dashboard View

Review the 5 Preconfigured Dashboards named **Milestone Summary**, **Passed Milestones**, **Active Business Transactions**, **Business Transaction**, **Errors** and **Avg. Business transaction Completion Time**.

Congratulation on completing the Process Mapping Test and Console View.
You may now **proceed to the next lab**.

## Want to Learn More

More info on Insight Models can be found [here](https://docs.oracle.com/en/cloud/paas/integration-cloud/user-int-insight-oci/work-models-integration-insight.html).

## Acknowledgements

* **Author** - Lucy Cortez, Product Enablement Management - Oracle Integration
* **Last Updated By/Date** - Lucy Cortez, April 2022