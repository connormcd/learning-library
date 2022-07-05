# Introduction

## About this Workshop
The ERP Cloud Business Event Workshop will cover the recommended steps to complete an end-to-end use case based on ERP Cloud Business Events in OCI  Integration. This workshop will leverage the Oracle ERP Cloud Adapter, which enables you to create an integration with Oracle Enterprise Resource Planning (ERP) applications. One of the key differentiators of this adapter is support for subscribing to business events raised by various modules in Oracle ERP Cloud and Oracle Supply Chain Cloud. 

This workshop will showcase the event subscription capabilities to create an App Driven i.e., real-time integration, with updates in ERP Cloud sent immediately to a file on a remote FTP server using orchestration with OCI  Integration (OAI). The steps outlined in this workshop can be used to demo the event-driven capabilities of the ERP Cloud adapter in OAI.

Estimated workshop time: 1 hour

## What is OCI Integration
With OCI Integration (OIC), you have the power to *integrate* your cloud and on-premises applications, *automate* business processes, *gain insight* into your business processes, *develop* visual applications, use an SFTP-compliant file server to *store* and *retrieve* files, and *exchange* business documents with a B2B trading partner—all in one place.

## Leveraging the ERP Adapter in OCI Integration
The Oracle ERP Cloud Adapter enables you to easily integrate on-premises or SaaS applications with Oracle ERP Cloud without having to know about the specific details involved in the integration. 

The Oracle ERP Cloud Adapter provides the following key benefits: 
- Provides declarative support for subscribing to business events raised by various modules in Oracle ERP Cloud and Oracle Supply Chain Management Cloud.
- Integrates easily with the Oracle ERP Cloud application’s WSDL file to produce a simplified, integration-centric WSDL. 
- Generates automatic mapping to the selected business object, event subscription, or business (REST) API.
- Simplifies connection creation by automatically identifying the required service resources based on the Oracle ERP Cloud host name you specify when creating a new connection on the **Connections** page.
- Supports several security policies for selection during Oracle ERP Cloud Adapter connection configuration:
    - Username Password Token With PGP Key Support
    - Username Password Token
    - OAuth Authorization Code Credentials
- Provides standard error handling capabilities.
- Enables you to upload a file in the Oracle ERP Cloud business tables. 
- Enables you to upload files to Oracle WebCenter Content (Universal Content Manager) in encrypted or unencrypted format. 


## Objectives
In this workshop, you will learn the following:
- Create Connections and Integrations in OIC
- Capture ERP Purchase Order events and orchestrate the data to a target database table

## Prerequisites
This lab assumes you have the following:
- Oracle Free Tier, Always Free, Paid or Live Labs Cloud Account
- Oracle Integration instance
- Oracle Autonomous Database environment (either ADW or ATP)
- Oracle ERP Cloud access


You may now **proceed to the next lab**.

## Want to Learn More?
* [Getting Started with OCI Application Integration](https://docs.oracle.com/en/cloud/paas/integration-cloud)
* [Using the Oracle ERP Cloud Adapter with OCI Application Integration](https://docs.oracle.com/en/cloud/paas/integration-cloud/erp-adapter)


## Acknowledgements
* **Author** - Ravi Chablani, Product Management - Oracle Integration
* **Last Updated By/Date** - Ravi Chablani, February 2022