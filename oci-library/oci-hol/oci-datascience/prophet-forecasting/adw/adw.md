# Lab 2: Connect to OCI Data Science with ADW (optional)

## Introduction

This lab will guide you through a practical example of how to upload your dataset in Oracle Data Science directly from ADW (Autonomous Data Warehouse).

Oracle ADW is Oracle's premier easy-to use, fully autonomous database. It delivers fast query performance, while requiring no database administration.

Estimated lab time: 5 minutes

### Objectives

In this lab you will:
* Become familiar with Autonomous Data Warehouse.
* Become familiar with the OCI Data Science service.

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account (see prerequisites in workshop menu)

## Task 1: Locally Upload Dataset

This task shows you how to upload the dataset to the notebook session.

1. Locally Download Dataset 

   Download the S&P500 dataset from the link below. This specific CSV file continues to update over time, listing the daily index value at the market close every business day. Therefore, your graphs may look slightly different to our example one.

   https://fred.stlouisfed.org/series/SP500

2. Open your data science notebook and drag the csv file into your directory.

   ![](images/drag2.png)

3. Run the 5 cells under the header "Load data"

   The first cell reads the CSV file uploaded from the last step into the pandas dataframe called "market_data". The second cell prints the last five rows of the data frame, which is the most recent SP500 prices. The final cell first cleans the data by removing any rows that do not have a price listed, and then graphs the prices as a price vs time line graph.

   The graph should look similar to as follows.

   ![](images/graph.png)


[Proceed to the next section](#next).

## Acknowledgements
* **Authors** - Jeroen Kloosterman - Product Strategy Manager - Oracle Digital, Lyudmil Pelov - Senior Principal Product Manager - A-Team Cloud Solution Architects, Fredrick Bergstrand - Sales Engineer Analytics - Oracle Digital, Hans Viehmann - Group Manager - Spatial and Graph Product Management
* **Last Updated By/Date** - Jeroen Kloosterman, Oracle Digital, Jan 2021

