# Introduction

## About this Workshop

This workshop walks you through how to configure a WebLogic-on-Kubernetes for monitoring with the Oracle Application Performance Monitoring (APM) service. This enables automatic OpenTracing instrumentation, and metrics collection that are used to provide full, end-to-end monitoring and diagnostics for the application.  

One way to deploy an APM Java agent in a Docker container-enabled Kubernetes cluster, is to first, provision the APM Java agent in the location where docker image was originally created, second, build a new Docker image with the APM Java agent, and third, push the image to the registry. You can then configure Kubernetes to use the new Docker image to enable the APM agent in the pods.

However, the above method assumes you have administrator access to the Docker working directory to recreate the image, which may not always be the case. In this workshop, we will use an alternative approach, to provision the APM Java agent in a file system mounted in the Oracle Cloud, and deploy it to the Kubernetes cluster, without updating the Docker image.

***PREREQUISITE:*** This workshop uses a simple WebLogic web application that runs on a Kubernetes cluster, as a target application to trace the user transactions. Prior to starting this workshop, be sure to complete the **[Migrating WebLogic Server to Kubernetes on OCI](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/workshop-attendee-2?p210_workshop_id=567&p210_type=2&session=102696148940850)** workshop Labs 1-4, to set up the application.

> ***NOTE***: The same approach demonstrated for WLS on Kubernetes can be used to configure other types of java application servers, such as Spring Boot, deployed on Kubernetes.

![](images/apm_wls_setup.png " ")

Estimated Workshop Time: 90 minutes

### About Oracle Cloud Infrastructure Application Performance Management (OCI APM)

The diagram below provides an overview of the OCI APM Service, its features, components, and some of the other OCI services it integrates with.

  ![](images/apm_diagram.png " ")

Among other capabilities, OCI APM includes an implementation of a Distributed Tracing system. It collects and processes transaction trace data (spans) from the monitored application and make it available for viewing, dashboarding, exploration, alerts, etc. For more information on APM and Trace Explorer please refer to Application Performance Monitoring > **[Use Trace Explorer](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/use-trace-explorer.html)** section in the OCI Documentation.

In the workshop, you will learn how to add the APM Java Agent on a file system mounted in the Oracle Cloud, to monitor a WebLogic application, deployed on a Kubernetes cluster. You will also learn how to create an APM domain in the Oracle Cloud and use Trace Explorer to search and view traces/spans in the APM User Interface.

### Objectives

In this workshop, you will:
* Create an APM domain, obtain Data Upload Endpoint and Data Keys
*	Create a file system in the Oracle Cloud Infrastructure, and mount it in the Kubernetes pods
*	Download, provision and deploy the APM Java Agent
* Apply custom storage configuration to the Kubernetes pods
*	Change the display name format of the spans by editing the agent configuration file
*	Use APM Trace Explorer to view traces, spans, and span dimensions

### Prerequisites

* An Oracle Free Tier with 30-day free trial or Paid Cloud Account
* Oracle Cloud resources and permissions to create a file system. See **[Creating File Systems](https://docs.oracle.com/en-us/iaas/Content/File/Tasks/creatingfilesystems.htm)** and **[Service Limits](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm#top)** in the Oracle Cloud documentation.
*	Oracle Cloud Account Administrator role or manage apm-domains permission in the target compartment. See **[Perform Oracle Cloud Infrastructure Prerequisites (APM)](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/perform-oracle-cloud-infrastructure-prerequisite-tasks.html)** in the Oracle Cloud documentation.
*	Completion of the **[Migrating WebLogic Server to Kubernetes on OCI](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/workshop-attendee-2?p210_workshop_id=567&p210_type=2&session=102696148940850)** workshop, Task 1 to Task 4.<br>(Tasks 5 to 7 are not required for the APM workshop.)

### Reference

*  **[Migrating WebLogic Server to Kubernetes on OCI](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/workshop-attendee-2?p210_workshop_id=567&p210_type=2&session=102696148940850)** workshop

### More APM Workshops

-	**[Use OpenTracing for Microservices with Helidon Utilizing Oracle Application Performance Monitoring](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=917&clear=180&session=14244965892057)**  Workshop
-	**[Trace a Native Cloud App Utilizing Oracle Application Performance Monitoring](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=916&clear=180&session=101657907800993)** Workshop

## Acknowledgements

- **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,<br>
David Le Roy, Director, Product Management,<br>
Mahesh Sharma, Consulting Member of Technical Staff,<br>
Avi Huber, Senior Director, Product Management
- **Last Updated By/Date** - Yutaka Takatsu, January 2022
