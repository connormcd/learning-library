# Create a Model

## Introduction

The Lab will cover how to build a simple model by reading the learning objectives, and participating in labs.

Estimated Time: 15 minutes

To use Insight to monitor a business process in Oracle Integration, there are several tasks to complete before you can track business metrics on the Insight dashboards.

The high-level workflow is as follows:
Create a model, defining milestones, a unique instance identifier, indicators, and alerts.
Associate the model to a business process implementation by mapping model milestones to the business process implementation.
Activate the model to allow business executives to view and analyze business processes in real time using dashboards.

## Prerequisites

This lab assumes you have:

* Completed Labs 1 thru 4

## Learning Objectives

In this lab, you will learn how to create the following:

* Draft Model
* Initial and Terminal Milestones
* Identifier mapped to one of the Milestones through a data type

First practice the steps to familiarize yourself with the commands and then do the Labs.

The Model has Milestone(s), and an Identifier which is mapped to one, or more, of the milestone(s). The Initial creation of a Model is called a Draft; which is not activated and can be modified, but not visible in the Console.

### Model Steps

    A. Open Oracle Insight
        1. Click on <Models>
        2. Click on <Create>
            a. In Name field type "Model Name"
            b. In Description field type "Model Description" 
            c. Click on "Create"
        3. This will open the Draft Model page, at the Milestones Process.

A Milestone is a key component of a Model. Milestone(s) define point(s) in a business process that represent progress. Your Model requires an Initial Milestone and a Terminal Milestone. <br />

### Milestones Steps

    A. Initial Milestone (Rocket symbol) 
        1. Enter the milestone name "Initial Milestone name"
        2. Enter the milestone description "Initial Milestone Description"
    B. Terminal Milestone (Finish Flag Symbol)
        1. Enter the milestone name "Terminal Milestone Name"
        2. Enter the milestone description "Terminal Milestone Description"

Every Model must have a Unique Instance Identifier defined. This identifier describes a value that is extracted at runtime for every instance (business transaction) of the business process defined by the model. <br />

### Identifier Steps

    A.  Click tab named <Identifier>, located between 
        1. Enter the Identifier Name "Identifier Name"
        2. Click on the Option Enter the Identifier Description. This will open the Milestone mapping area.
            a. From the Milestone dropdown select <It will show your current Milestones available to map>
            b. Select a Data Type of <String>
                i. Note: The selected data type must match the data type of the value that will be extracted at runtime, as defined by the associated identifier extraction criteria that you will specify later. Otherwise, the identifier will show an empty value in Insight dashboards.
            c. Click <Save>
        3. Click <Save> on the upper right corner

When a business process implementation spans more than one integration or process, or both, you must assign the model's unique instance identifier to mapped milestones to establish the correlation between the actions in the same instance of the business process and extract the unique instance identifier value when the specified milestone is passed. <br />

Let's get you to create your first Insight Model! In the Labs there are 3 tasks that will need to be followed, in order, to accomplish creating a Model.

You will create an Insight Model with 2 Milestones, an Initial and a Terminal, and an identifier. Your model will be kept in Draft form thru several iterations.

## Task 1: Create Model

1. Open Insight and create your Draft Model.
2. Name the Draft Model **My Order Processing** and provide the description of **My First Model**.
3. You will need to click **Create** to finish. When you've completed it; it will open the Milestone Process for you.

## Task 2: Create A Milestone

As taught, each Model needs an Initial and Terminal Milestone. For your Initial Milestone (Rocket Symbol), enter Milestone name **Order Received** and for the Description enter **My First Orders Received**. For your Terminal Milestone (Finish Line Flag Symbol), Enter milestone name **Order Completed** and enter Milestone description **Orders Completed via System**.

## Task 3: Create an Identifier

Finish your Draft Model by creating an Identifier. The Identifier name is  **Order Number**,  for Milestone select  **Order Received**, the Data Type is **String** and **Order Completed** Milestones.
Save and Close your Draft Model.

Great job creating your Draft Model.<br />

You may now **proceed to the next lab**

## Learn More

More info on Insight Models can be found [here](https://docs.oracle.com/en/cloud/paas/integration-cloud/user-int-insight-oci/work-models-integration-insight.html).

## Acknowledgements

* **Author** - Lucy Cortez, Product Enablement Management - Oracle Integration
* **Last Updated By/Date** - Lucy Cortez, April 2022
