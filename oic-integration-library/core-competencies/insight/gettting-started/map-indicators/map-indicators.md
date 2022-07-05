# Associate an Indicator to a Model 

## Introduction

The Lab will cover how to map an Integration to Indicators and Activate a Model.

Estimated Time: 10 minutes

## Prerequisites

This lab assumes you have:
 - Completed Labs 1 through 8

## Learning Objective

In this lab, you will learn how to create the following:

- Map Indicators to an Integration
- Modify your Draft into a Configured state
- Activate your Insight Model

You can associate an Insight Model to a business process implementation in integrations.

To associate a Model to a business process implementation in Integrations, you must map Indicators to Integrations actions.  Mapping Indicators involves identifying execution points that best represent when the milestone has been passed.

As seen in Lab 6, part of the mapping process you must also define extraction criteria for the Indicators. Extraction criteria define the rules to extract information from runtime messages and is expressed using XPath expressions. Before you can activate a model, the extraction criteria must be defined.

First practice the steps to familiarize yourself with the commands and then do the exercise.

### Deactivate a Model

    A. Click on the **DeActivate** button, you will receive deactivate confirmation box and click **Deactivate".  This may take upto 5 minutes to accomplish. 
        1. Click on your model name
        2. Click on **Open Draft**

### How to Map an Indicator

    A. Click your Indicator Tab, this will expand the view area **or** click the orange Messages circle  (the circle will display how many indicators are missing mapping) 
        1. Once expanded, under Extraction Criteria click on the working **Open mapped integration to define extraction criteria**
            Note: you may receive a Save dialog box, click **Save**
        2. This will open the Integrations, that was previously used, for you to map 
        3. You will see your Indicator on the right hand side
            a. Under Milestone you will see Extraction Criteria
                1. Click on Define extraction Criteria
                2. This will open the expression page
                    a. Under Source click on the expression you wish to use and drag and drop to the Expression box, located on the right side 
                    Hint - You can use the search tool to locate the expression 
            c. You may click "Validate" to confirm its readiness to use and click "Close" to return to the integration mapping page.
        4.  Repeat for each Indicator you wish to map.
        5. Click Save, this will return you to the model.
        
Once Integration has been mapped to the Indicator, it's time to change the Draft Model into a Configured State <br />

### How to Place Draft Model into Configured State

    A. Click **Save** and you will receive a confirmation box stating **Succesfully saved the change**
    B. Exit and return to your Models listing. You will now see your Status as **Configured**

Activating a Model allows it to be tested or used. Active models showcase status of a green dot that says "Activated". <br />

### How to Activate a Model

    A.  At the Model's list page, locate your Model
        1. Hover your mouse over the Last Updated Date and 3 buttons will appear
        2. Click on the center button named **Activate**
        3. Display window will appear click **Activate**
        4. This may take a few minutes to generate or you may click the refresh symbol
        5. Status will now display a green dot and word **Activated**

 <br />

Now your turn to try!

 You will map your Indicators to an existing integration. The Integration you will use is called **Order Processing Lab**. You will move your active model into a draft mode. After completing mapping the Indicators you will move your draft model into a configured model state and then re-active model state. 

## Task 1: Map Indicators

Access your active model and de-active it to return to a Draft model state. You will map 5 Indicators.<br />
![deactivate](./images/deactivate.jpg " ") <br />
Open the Draft 
![draft](./images/draft.jpg " ")  <br />
Let's start with the **Order Received** Milestone Indicators. Set the **Country** Indicator Extraction Criteria to **$Country**.<br />
![indicatorproduct](./images/indicator-product.jpg " ")
 Set the **Product** Indicator Extraction Criteria to **$Product**. Set the **Quantity** Indicator Extraction Criteria to **$Quantity**. <br />
Set the **UnitPrice** Indicator Extraction Criteria to **$UnitPrice**. Set the **Total** Indicator Extraction Criteria to **$Total**. <br />
Now let's map the new milestone and Identifier <br />

## Task 2: Map Milestone and Identifiers  

Map your **Shipped** Milestone **On Exit** event to the **PrepareShipping** activity. <br />
Now onto the Identifier. Set your **Order Number** Identifier Extraction Criteria for the **Shipped** Milestone to **$OrderNumber**.<br />
Set your **Order Number** Identifier Extraction Criteria for the **Order Completed** Milestone to **$OrderNumber**.
![indicator product](./images/shipped-milestone.jpg " ")
 Go to Task 3 in order to save your work.<br />
     
## Task 3: Draft to Configured State 

You may now click **Save** and ensure you receive the message box **Successfully saved the changes** and close your model. To activate the model, go to Task 4. 
    
## Task 4: Configured State to Active State 

Access your Insight Models, locate your model and ensure it says Configured. Now Activate your model by clicking **Activate** button. 

You will receive an Activation Confirmation box, click **Activate**. You will see a system response.
![reactivate](./images/reactivate.jpg " ")  <br />
![active map indicators](./images/activate-map-indicators.jpg " ")  <br />



Congratulation on completing Mapping Indicators! The next exercise will test the mapping and showcase the Console/Dashboards.

## Learn More

More about indicators can be found at [https://docs.oracle.com/en/cloud/paas/integration-cloud/user-int-insight-oci/work-models-integration-insight.html](http://docs.oracle.com)

## Acknowledgements

* **Author** - Lucy Cortez, Product Enablement Management - Oracle Integration
* **Last Updated By/Date** - Lucy Cortez, April 2022