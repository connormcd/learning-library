# Oracle Integration Insight Key Concepts

## Introduction

The Lab will cover Oracle Integration Insight key concepts and terminology for each stage of building, activating, mapping a model and Console.

Estimated Time: 15 minutes.

### Objectives

In this lab, you will:

* Learn key terminology of Oracle Integration Insight
* Understand key concepts of Oracle Integration Insight

## Prerequisites

This lab assumes you have:

* Completed Labs 1 and 2 
* Oracle Integration - Enterprise edition
* An Oracle Cloud Account - Please view this workshop's LiveLabs landing page to see which environments are supported.

    > **Note:** If you have a **Free Trial** account, when your Free Trial expires, your account will be converted to an **Always Free** account. You will not be able to conduct Free Tier workshops unless the Always Free environment is available.
**[Click here for the Free Tier FAQ page.](https://www.oracle.com/cloud/free/faq.html)**

## Task 1: Model

A *Model* is a business process, comprising of *Milestone(s)*, a *Unique Instance Identifier*, *Indicator(s)*, and *Alert(s)*. A Model passes through several states during its lifecycle.

There are 8 Model states:

* **Draft**: A newly created model is in this state until the model is activated. In this state, changes can be made to the model and no metrics are collected. A draft model can be exported to later be imported into another Insight instance.
* **Configured**: A model moves into this state when its milestones, indicators, and unique instance identifier have been defined and milestones have been mapped to a business process. A model in this state is ready to activate.
* **Activation In Progress**: A model is in this state when activation has been initiated.
* **Timeout**: A model falls into this state when it times out after attempting to activate for five minutes.
* **Activated**: When a model is in this state, metrics are being collected, and changes are not possible. An activated model can be exported to later be imported into another Insight instance.
* **Deactivated**: A model moves into this state when you specifically deactivate it.
* **Failed**: A model falls into this state when it encounters issues during activation.
* **Unknown**: A model may move into this state when the state of the model cannot be determined as activated or deactivated. You can perform all lifecycle actions on a model in an unknown state.

    > **Note:** To make changes to an activated model, you must first create a draft version of the active model to edit the model without interrupting metrics collection in the active model. After editing, the model can be reactivated to apply the changes.

## Task 2: Milestones

A *Milestone* is a key component of an Insight Model. Milestone(s) define points in a business process that represent progress and map to at least one activity in the business process implementation.
Characteristics of a Milestone include:

* **Atomicity**: A Milestone has no entry or exit point. A milestone is considered to be passed or not passed, but you are never in a milestone. A milestone has no duration and is passed atomically. However, it is important to consider the duration from one milestone to another.
* **No enforced ordering**: Milestones can be passed in any order and repeatedly. However, Insight does maintain the natural ordering in which the milestones are defined in the model.
* **Semantic types**: A milestone may have one or more semantic classifications that describe the milestone’s role in the execution of a business process. See the list of milestone types below.
* **Mapping**: Milestones are mapped to points in a business process implementation that indicate that the milestone has been passed.
* **Indicators**: Milestones can have indicators associated with them whose values are extracted when the milestone is passed. These indicators represent the state of the instance when the milestone is passed, and have a variety of different semantic options.

Milestones are of the following types:

* **Initial**: This milestone is preceded in a newly created model. It is mandatory and cannot be removed from the model. A model instance is assumed to be valid when a milestone of type Initial is passed. This concept is key to filtering out instances that may already be in flight when Insight starts monitoring a runtime engine. An instance that has most recently passed an Initial milestone is in an Active state.
* **Standard**: Represents a milestone that is neither Terminal nor Error. An instance that has most recently passed a Standard milestone is in an Active state.
* **Error**: Represents a milestone that reflects some business error condition encountered in the execution of the business process. The business process implementation may account for and recover from errors, and thus Error milestones are not necessarily also Terminal. An instance that has most recently passed an Error milestone is in an Error state.
* **Terminal**: This milestone is preceded in a newly created model. It is mandatory and cannot be removed from the model. A terminal milestone represents an expected end to the model instance. For example, a milestone "Order Complete" that represents the completion of an order might be modeled as a Terminal milestone. Insight does not enforce the end of an instance after a Terminal milestone, and further milestones may be passed. An instance is in a Completed state when the last milestone passed was a Terminal milestone.
* **Terminal/Error**: Represents an Error milestone, which also represents the expected end of the business process processing. An instance that reaches a Terminal/Error milestone is in a Failed state.

## Lab 3: Unique Instance Identifier

Every *Instance* (unique business transaction) of the Model must pass through at least an Initial and a Terminal Milestone.

Every Insight *Model* must have a *Unique Instance Identifier* defined. This identifier describes a value that is extracted at runtime for every instance (business transaction) of the business process defined by the Model.

Insight uses the Unique Instance Identifier to grant you visibility into your entire business process, even if it is implemented in more than one integration or process.

The Unique Instance Identifier extraction criteria is defined in the context of a business process action that is mapped to a Milestone associated with the identifier. The extraction criteria is an XPath expression that defines how values are extracted from message payloads at the point that the Milestone is passed.

The Unique Instance Identifier value is extracted at runtime every time a milestone is passed and correlates the actions and data that belong to the same instance (business transaction) of the business process. Actions with the same unique instance identifier value are considered part of the same instance (for example, the same order). For example, a unique instance identifier of orderID specifies that each unique orderID value is considered to be a separate instance of your business process. Actions with the same orderID value are considered part of the same order, or instance.

When a business process implementation spans more than one integration or process, or both, you must assign the Model's Unique Instance Identifier to mapped milestones to establish the correlation between the actions in the same instance of the business process and extract the Unique Instance Identifier value when the specified Milestone is passed. For example, if your business process is implemented across two integrations, and the order number is extracted from the first integration, when the second integration is invoked you can extract the order number a second time to correlate its actions as part of the same order.

## Lab 4: Indicators

*Indicators* represent metrics that are unique to a business process, and are extracted when Milestones are passed in a business process implementation.

Indicators allow business users to gain insight into how a business process is functioning, and also allow comparisons between business transactions (instances), such as each order or service request. They help to quantify the performance of the business, and are used to create dashboards and reports for tracking business metrics.

The Indicator extraction criteria is defined in the context of a business process action that is mapped to a Milestone associated with the Indicator. The extraction criteria is an XPath expression that defines how values are extracted from message payloads at the point that the milestone is passed.

An Indicator can be mapped to one or more Milestones. Mapping an indicator to multiple Milestones allows the value of the indicator to change during the execution of a business process, if necessary. For example, in a business process that tracks an order, the value of an indicator may change as discounts are applied. When the "Order Received" Milestone is passed, the value extracted for an associated "Price" indicator may be $100. As the order progresses, a discount may be applied. When the "Discount Applied" Milestone is passed, the value extracted for the "Price" indicator may be reduced to $80. In dashboards and alerts that include the indicator, the value shown is the final value of the indicator in the business process.

There are two types of Indicators:

* **Measures** are numerical values that can be used by mathematical functions. They identify values that allow the state of a business process to be quantified. For example, a business process might define measures for "Total Order Value" or "Item Count". A single measure can change over the lifecycle of a Model. For example, the "Discount amount" may change during a business process because the "Quote Modified" Milestone can be passed more than once.

* **Dimensions** provide a type of grouping and categorization of business transactions (instances), allowing for slicing and dicing of aggregate integration measures. For example, a typical order in a business process might define dimensions for Geographic Region, Sales Channel, or Product Category.

Insight does not support duplicate Indicators.

## Lab 5: Alerts

*Alerts* define conditions for Milestones or Indicators to notify users when those conditions are met.

You can optionally define Alerts in your Model to notify users by email when:

* A Milestone is reached or not reached.

* An Indicator (dimension or measure) is equal to, greater than, or less than a specified value.

You can configure the Alert notification email to include the Unique Instance Identifier, indicator values, and a link to the associated Business Transactions dashboard in the body of the email.

## Lab 6: Model Instances

*Instances* represent the activity of the associated Insight Model. A single Instance is a unique occurrence of the business process that the Model defines. To a Business Executive, an instance is a *business transaction*.

An Instance always begins when the Model's Initial Milestone is passed and always ends when one of the Model’s Terminal or Terminal Error Milestones is passed. This activity is more commonly described using the model-specific **Business Transaction Label** and **Business Transactions Label** values that represent singular and plural terms, respectively, that are understandable by Business Executives, such as "Order" and "Orders".

You may now **proceed to the next lab**.

## Learn More

More about key concepts and terminology can be found at [https://docs.oracle.com/en/cloud/paas/integration-cloud/user-int-insight-oci/work-models-integration-insight.html](http://docs.oracle.com)

## Acknowledgements

* **Author** - Lucy Cortez, Product Enablement Management - Oracle Integration
* **Last Updated By/Date** - Lucy Cortez, April 2022
