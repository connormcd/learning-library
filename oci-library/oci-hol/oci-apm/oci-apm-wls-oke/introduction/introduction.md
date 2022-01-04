# Introduction

## About this Workshop

This workshop walks you through how to enable OpenTracing for a WebLogic container-packaged web application deployed on Kubernetes cluster, using Oracle Application Performance Monitoring (APM).

One way to deploy an APM Java agent in a Docker container-enabled Kubernetes cluster, is to first, provision the APM Java agent in the location where docker image was originally created, second, build a new Docker image with the APM Java agent, and third, push the image to the registry. You can then configure Kubernetes to use the new Docker image to enable the APM agent in the pods.

However, this method assumes you have administrator access to the Docker working directory to recreate the image, which may not always be the case. In this workshop, we will use an alternative approach, to provision the APM Java agent in a file system mounted in the Oracle Cloud, and deploy it to the Kubernetes cluster, without updating the Docker image.

In this workshop, we will use a simple WebLogic web application that runs on a Kubernetes cluster, as a target application to trace the user transactions.  As a prerequisite, please complete [Migrating WebLogic Server to Kubernetes on OCI](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/workshop-attendee-2?p210_workshop_id=567&p210_type=2&session=102696148940850) workshop up to Lab 4, whereyou can set up the application, prior to starting this workshop.



Estimated Workshop Time: 75 minutes

### About Oracle Cloud Infrastructure Application Performance Management (OCI APM)

The diagram below provides an overview of the OCI APM Service, its features, components, and some of the other OCI services it integrates with.

  ![](images/apm_diagram.png " ")

Among other capabilities, OCI APM includes an implementation of a Distributed Tracing system. It collects and processes transaction trace data (spans) from the monitored application and make it available for viewing, dashboarding, exploration, alerts, etc. For more information on APM and Trace Explorer please refer to Application Performance Monitoring > **[Use Trace Explorer](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/use-trace-explorer.html)** section in the OCI Documentation.

In the workshop, you will learn how to add APM Java Agent to a WebLogic application, deployed on a Kubernetes cluster. You will also learn how to create an APM domain and use Trace Explorer to search and view traces/spans in the APM User Interface.



### Objectives

In this workshop, you will:
* Create an APM domain, obtain Data Upload Endpoint and Data Keys
*	Create a file system in the Oracle Cloud Infrastructure, and mount it in the Kubernetes pods
*	Download, provision and deploy the APM Java Agent
* Apply custom storage configuration to the Kubernetes pods
*	Change the display name of the spans by editing the agent configuration file
*	Use APM Trace Explorer to view traces, spans, and span dimensions




### Prerequisites

* An Oracle Free or Paid Cloud Account
*	Oracle Cloud Account Administrator role or manage apm-domains permission in the target compartment
*	Completion of the [Migrating WebLogic Server to Kubernetes on OCI](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/workshop-attendee-2?p210_workshop_id=567&p210_type=2&session=102696148940850) workshop, Lab 1 to Lab4.<br>(Labs 5 to 7 are not required for the APM workshop.)



### Reference
*  Oracle LiveLabs **[Migrating WebLogic Server to Kubernetes on OCI](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/workshop-attendee-2?p210_workshop_id=567&p210_type=2&session=102696148940850)** workshop

### Learn More
-	**[Create an APM Domain](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/create-apm-domain.html)**
- **[Obtain Data Upload Endpoint and Data Keys](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/obtain-data-upload-endpoint-and-data-keys.html)**
- **[Configure Application Performance Monitoring Data Sources](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/configure-application-performance-monitoring-data-sources.html)**
- **[Use Trace Explorer](https://docs.oracle.com/en-us/iaas/application-performance-monitoring/doc/use-trace-explorer.html)**



You may now [proceed to the next lab](#next).

## Acknowledgements

- **Author** - Yutaka Takatsu, Product Manager, Enterprise and Cloud Manageability
- **Contributors** - Steven Lemme, Senior Principal Product Manager,<br>
David Le Roy, Director, Product Management,<br>
Avi Huber, Senior Director, Product Management
- **Last Updated By/Date** - Yutaka Takatsu, December 2021
