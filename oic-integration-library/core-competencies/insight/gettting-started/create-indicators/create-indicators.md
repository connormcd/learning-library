# Indicators

## Introductions

The Lab will cover how to add and map indicators to the existing draft model.

 Estimated Time: 15 minutes

## Prerequisites

This lab assumes you have:

* Completed Labs 1 through 7

## Learning Objectives

In this lab, you will lean how to create the following:

* Edit Draft Model
* Create an Indicator
* Add Measure to Indicator
* Select Data Type for Indicator
* Add a Standard Milestone

Indicators represent metrics that are unique to a business process, and are extracted when milestones are passed in a business process implementation.

### Define an Indicator

    A. On the Models page, Click the name or Edit (pencil icon) of the model for which you want to crate indicators. There are two ways to create an Indicator, one is going the Milestone page or going to Indicators page. In our sample, we will be doing the indicator's page. 
        1. Click on <Indicators> Tab (located between the Identifier and Alerts tab)
        You will notice that the page will say "You have no dimensions or measures"
        2. Read the following to see how to add Measures or Dimensions

There are two types of indicators, Measures and Dimensions, that can be used.

Measures, icon is a gastank, are numerical values that can be used by mathematical functions. They identify values that allow the state of a business process to be quantified.

Dimensions, icon is blocks provide a type of grouping and categorization of business transactions (instances), allowing for slicing and dicing of aggregate integration measures.

### Measures

    A. Measures
        1. Click on Measures <Gastank> Tab 
        2. Enter the Measure Name
        3. Enter the measure description, this will expand the field area
        4. From the Milestone dropdown select the Milestone         
        5. Select Data Type from dropdown (String, Integer,Float, or Decimal)
        6. Filterable: Mark the box if you want to use the indicator as filter criteria in dashboards

### Dimensions

    A. Dimensions
        1. Click on Dimensions <blocks> Tab 
        2. Enter the Dimensions Name
        3. Enter the Dimensions description, this will expand the field area
        4. From the Milestone dropdown select the Milestone         
        5. Select Data Type from dropdown (String, Integer,Float, or Decimal)
        6. Filterable: Mark the box if you want to use the indicator as filter criteria in dashboards

An indicator can be mapped to one or more milestones. Mapping an indicator to multiple milestones allows the value of the indicator to change during the execution of a business process, if necessary.

Now it's your turn!

## Task 1: De-Activate Model

You will need to De-Activate your current model. This will put your model back in Draft mode. Go to Task 2

## Task 2: Add a Milestone, Dimensions and Measures

Once that occurs, add **Order Received** Milestone Indicators and add the following 2 Dimensions and 3 Measures: <br />
    a. Product (Dimension of type String) <br />
    b. Country (Dimension of type String) <br />
    c. Quantity (Measure of type Integer) <br />
    d. Unit Price (Measure of type Decimal) <br />
    e. Total (Measure of type Decimal)  <br />


## Task 3: Standard Milestone

You will need to add a Standard Milestone named to **Shipped**.  

## Task 4: Map Milestone

Add the Shipped Milestone to the **Order Number** Identifier.
Save and Close your Model.

Congratulations, you've done it!
You may now **proceed to the next lab**.

## Want to Learn More

More info on Insight Models can be found [here](https://docs.oracle.com/en/cloud/paas/integration-cloud/user-int-insight-oci/work-models-integration-insight.html).

## Acknowledgements

* **Author** - Lucy Cortez, Product Enablement Management - Oracle Integration
* **Last Updated By/Date** - Lucy Cortez, April 2022
