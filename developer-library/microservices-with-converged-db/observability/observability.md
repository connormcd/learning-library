# Enable Observability with Database Metrics, Logs Exporters

## Introduction

This lab will show you how you can trace microservice activity using Jaeger.

Estimated Time: 25 minutes

Watch the video below for a quick walk through of the lab.

[](youtube:MuoMHJ54PHE)

### Objectives

* Install and configure Grafana, Prometheus, Loki, Promtail, and Jaeger
* Understand single-pane-of glass unified observability using Grafana to analyze metrics, logs, and tracing of the microservices architecture across the application and Oracle database tier.

### Prerequisites

- This lab presumes you have already completed the earlier labs.
 

## Task 1: Install and Configure Observability Software and Metrics with Log Exporters

1. Run the install script to install Jaeger, Prometheus, Loki, Promtail, Grafana and an SSL secured LoadBalancer for Grafana

    ```
    <copy>cd $GRABDISH_HOME/observability;./install.sh</copy>
    ```

2. Run the `/createMonitorsAndDBAndLogExporters.sh` script. This will do the following:
   - Create Prometheus ServiceMonitors to scrape the Frontend, Order, and Inventory microservices.
   - Create Prometheus ServiceMonitors to scrape the Order PDB, and Inventory PDB metric exporter services.
   - Create configmpas, deployments, and services for PDB metrics exporters.
   - Create configmaps, deployments, and services for PDB log exporters.

    ```
    <copy>cd $GRABDISH_HOME/observability;./createMonitorsAndDBAndLogExporters.sh</copy>
    ```

## Task 2: Configure Grafana

1. Identify the EXTERNAL-IP address of the Grafana LoadBalancer by executing the following command:

       ```
       <copy>services</copy>
       ```

     ![](images/grafana-loadbalancer-externalip.png " ")

     Note, it will take a few minutes for the LoadBalancer to provision during which time it will be in a `pending` state

2. Open a new browser tab and enter the external IP URL:

     `https://<EXTERNAL-IP>`

      Note, for convenience a self-signed certificate is used to secure this https address and so you will be prompted by the browser to allow access.

3. Login using the default username `admin` and password `prom-operator`

      ![](images/grafana_login_screen.png " ")

4. View pre-configured Prometheus data source:

    Select the `Configuration` gear icon on the left-hand side and select `Data Sources`.

      ![](images/configurationdatasourcesidemenu.png " ")

    Click `select` button of Prometheus option.

      ![](images/selectprometheusdatasource.png " ")

    The URL for Prometheus should be pre-populated

      ![](images/prometheusdatasourceurl.png " ")

    Click `Test` button and verify success.

      ![](images/saveandtestdatasourceisworking.png " ")

    Click the `Back` button.

5. Select the `Data sources` tab and select `Jaeger`

    Click `Add data source`.

      ![](images/adddatasourcebutton.png " ")

    Click `select` button of Jaeger option.

      ![](images/addjaegerdatasource.png " ")

    Enter `http://jaeger-query.msdataworkshop:8086/jaeger` in the URL field.

      ![](images/jaegerdatasourceurl.png " ")

    Click the `Save and test` button and verify successful connection message.
      ![](images/confirmjaeger.png " ")

    Click the `Back` button.

6. Add and configure Loki data source:

    Click `Add data source`.

      ![](images/adddatasourcebutton.png " ")

    Click `select` button of Loki option.

      ![](images/lokidatasource.png " ")

    Enter `http://loki-stack.loki-stack:3100` in the URL field

      ![](images/lokidatasourceurl.png " ")

    Create the two Derived Fields shown in the picture below.
    The values are as follows:

       ```
       <copy>services
        Name: traceIDFromSpanReported
        Regex: Span reported: (\w+)
        Query: ${__value.raw}
        Internal link enabled and `Jaeger` selected from the drop-down list.
        (Optional) Debug log message: Span reported: dfeda5242866aceb:b5de9f0883e2910e:ac6a4b699921e090:1

        Name: traceIDFromECID
        Regex: ECID=(\w+)
        Query: ${__value.raw}
        Internal link enabled and `Jaeger` selected from the drop-down list
        (Optional) Debug log message: ECID=dfeda5242866aceb
        </copy>
       ```
       
      ![](images/traceidfromspan.png " ")

      ![](images/traceIdFromEcid.png " ")

    Click the `Save & Test` button and verify successful connection message.

      ![](images/lokiconnectedandlabelsfound.png " ")

    Click the `Back` button.

7. Install the GrabDish Dashboard

    Select the `+` icon on the left-hand side and select `Import`

      ![](images/importsidemenu.png " ")

    Copy the contents of the [GrabDish Dashboard JSON](https://raw.githubusercontent.com/oracle/microservices-datadriven/main/grabdish/observability/dashboards/grabdish-dashboard.json)

    Paste the contents in the `Import via panel json` text field and click the `Load` button
      ![](images/jsondashboardupload.png " ")

    Confirm upload and click `Import` button.
      ![](images/confirmdashimport.png " ")


## Task 3: Open and Study the Main GrabDish Grafana Dashboard Screen and Metrics

1. Select the four squares icon on the left-hand side and select 'Dashboards'
      ![](images/dashboardsidemenu.png " ")

2. In the `Dashboards` panel select `GrabDish Dashboard`

      ![](images/dashboardlist.png " ")

3. Notice the collapsible panels for each microservices and their content which includes
    - Metrics about the kubernetes microservice runtime (CPU load, etc.)
    - Metrics about the kubernetes microservice specific to that microservice (`PlaceOrder Count`, etc.)
    - Metrics about the PDB used by the microservice (open sessions, etc.)
    - Metrics about the PDB specific to that microservice (inventory count)

      ![](images/frontenddashscreen.png " ")
      ![](images/orderdashscreen.png " ")
      ![](images/inventorydashscreen.png " ")

4. By default the status will show a value of `1` for `UP` status.

   This is corrected by selecting the `Edit` item in the/a `Status` panel dropdown
      ![](images/editstatus.png " ")

   Add a value mapping where `value` of `1` results in `text` of `UP`) under the `Field` tab as shown here:
      ![](images/valuetest1upfield.png " ")

   Click the `Apply` button in the upper right to apply changes.

5. If not already done, place an order using the application or run the scaling test in the earlier labs to see the metric activity in the dashboard.

6. Select the 'Explore' option from the drop-down menu of any panel to show that metric and time-span on the Explore screen

      ![](images/grabdishdashexplorebutton.png " ")

## Task 4: Use Grafana to Drill Down on Metrics, Tracing, and Log Correlation and Logs to Trace Feature

1. Click the `Split` button on the Explore screen.
      ![](images/grafanaexploresplitpanebutton.png " ")

2. Click the `Loki` option from the drop-down list on the right-hand panel.
      ![](images/explorerscreen.png " ")

3. Click the chain icon on either panel. This will result in the Prometheus metrics on the left and Loki logs on the right are of the same time-span.
      ![](images/syncchain.png " ")

4. Click the `Log browser` drop-down list on the right-hand panel and select the `app` label under "1. Select labels to search in"
      ![](images/logbrowser.png " ")

5. Select the `order` (microservice) and `db-log-exporter-orderpdb` values under "2. Find values for selected label" and click `Show logs` button.
      ![](images/ordermslabel.png " ")
      ![](images/dblogexporterorderpdblabel.png " ")

6. Select one of the green info log entries to expand it. Notice the `Jaeger` button next to the trace id.
      ![](images/spanreportedlogentry.png " ")

7. Click the `Jaeger` to view the corresponding trace information and drill down into detail.
      ![](images/traceinfo.png " ")

You may now **proceed to the next lab.**

## Acknowledgements
* **Author** - Paul Parkinson, Developer Evangelist
* **Last Updated By/Date** - Paul Parkinson, August 2021
