# Performance Monitoring Use Case

## Introduction

This lab will show you how to set up alerts for metrics conditions and trigger them so that Slack notifications are sent as appropriate.

![Place Order Panel](images/alertrulerelationship.png " ")

Estimated Time:  10 minutes

### Objectives

-   Configure alert for when `PlaceOrder` average response time exceeds a given value.
-   Load test the application to induce the alert
-   Notice the health state of the metric in Grafana and the messages sent to Slack channel.
  
  
### Prerequisites

- This lab presumes you have already completed the earlier labs.

## Task 1: Notice perf metrics and create alert for response time threshold

1. Notice `PlaceOrder average time` metric panel in `Order Service` section of the Grabdish dashboard, select the drop down menu of the panel and click `edit`.

    ![Place Order Panel](images/placeorderpanel.png " ")
   
2. Select the `alert` tab and click the `Create alert rule from this panel` button

    ![Create Alert](images/creatalertrulefromthispanel.png " ")
       
3. Enter the rule type fields as shown below.

    ![Add Alert Rule](images/ruletype.png " ")
       
4. `Create a query to be alerted on` entering the fields as shown below and click `Run queries` button.

    ![Add Alert Rule](images/createquery.png " ")

   #### Different environments may have different response times and so it may be necessary to tweak the rules, etc. accordingly to trigger an alert.
   #### Notice the current average placeOrder response time and adjust the rule's `is above` value if necessary such it is greater than the (green) average response time.

   If there is no current average response time (ie green line), even after clicking the icon underneath the graph, re-run a (curl) request to placeOrder as was done in the `Deploy and Test Data-centric Microservices Application` lab.

5. Define the alert conditions as show below (you may reduce the 1m and 5m `Evaluate` values to induce the notification sooner).

    ![Test Rule](images/definealertcondition.png " ")

6. Optionally, add details for the alert.

    ![Test Rule](images/adddetailsforalert.png " ")
       
7. Click `Save and exit` 


## Task 2:  Run load test. Notice metrics and Slack message from alert due to rule condition being exceeded.

1. Run the `curlpod` command from the Cloud Shell in order to access a shell prompt running within the Kubernetes cluster as was done in the `Deploy and Test Data-centric Microservices Application` lab.  

    ```
    <copy>curlpod</copy>
    ```
    
2. Execute a load test using the following command.  

    ```
    <copy>while true; do curl -u grabdish:[REPLACE_WITH_PASSWORD] -X POST -H "Content-type: application/json" -d  "{\"serviceName\" : \"order\" , \"commandName\" : \"placeOrder\", \"orderId\" : \"66\", \"orderItem\" : \"sushi\",  \"deliverTo\" : \"101\"}"  "http://frontend.msdataworkshop:8080/placeorderautoincrement"; sleep 2; done</copy>
    ```

3. Notice the health/heart of the PlaceOrder panel in Grafana console turn to yellow and then eventually to red.

   ![Health Yellow](images/yellowheart.png " ")
     
   ![Health Red](images/redheart.png " ")
     
4. Also notice a Slack message being sent with information about the alert.
     
   ![Slack Failure](images/slackmessagerror.png " ")

   Optionally the alert can be viewed in dashboard as well as shown here in the `AQ Monitor` dashboard.
   ![Slack Failure](images/alertinaqdashboard.png " ")

   As well as in `Alerting rules` tab of the `Alerting` page .
   ![Slack Failure](images/alertingalertrulesalert.png " ")

5. It may be necessary to increase the load by either running multiple `curlpod` shells or simply running the curl loop in the background by issuing the following multiple times within the `curlpod` shell.

 ```
 <copy>while true; do curl -u grabdish:[REPLACE_WITH_PASSWORD] -X POST -H "Content-type: application/json" -d  "{\"serviceName\" : \"order\" , \"commandName\" : \"placeOrder\", \"orderId\" : \"66\", \"orderItem\" : \"sushi\",  \"deliverTo\" : \"101\"}"  "http://frontend.msdataworkshop:8080/placeorderautoincrement"; sleep 2; done &</copy>
 ```

## Task 3: Stop load test. Notice return to healthy state and Slack message sent indicating response time is acceptable.

1. Delete `curlpod` with the following shortcut command to insure all load test threads are terminated.

   ```
   <copy>deletepod curlpod</copy>
   ```

2. Start `curlpod` again and issue curl command to delete all existing records.

   ```
   <copy>curlpod</copy>
   ```

   ```
   <copy>curl -u grabdish:[REPLACE_WITH_PASSWORD] -X POST -H "Content-type: application/json" -d  "{\"serviceName\" : \"order\" , \"commandName\" : \"deleteallorders\", \"orderId\" : \"-1\", \"orderItem\" : \"\",  \"deliverTo\" : \"\"}"  "http://frontend.msdataworkshop:8080/command"</copy>
   ```

3. Issue single request(s) as done earlier. 

    ```
    <copy>curl -u grabdish:[REPLACE_WITH_PASSWORD] -X POST -H "Content-type: application/json" -d  "{\"serviceName\" : \"order\" , \"commandName\" : \"placeOrder\", \"orderId\" : \"66\", \"orderItem\" : \"sushi\",  \"deliverTo\" : \"101\"}"  "http://frontend.msdataworkshop:8080/placeorderautoincrement"</copy>
    ```

5. Notice the health/heart of the PlaceOrder panel in Grafana console turn back to green.

   ![Health Normal](images/placeorderhealthbacktonormal.png " ")
   
6. Also notice a Slack message being sent confirming the condition is resolved.
   
   ![Slack OK](images/resolved.png " ")

You may now **proceed to the next lab.**.

## Learn More

* Ask for help and connect with developers on the [Oracle DB Microservices Slack Channel](https://bit.ly/oracle-db-microservices-help-slack)   

## Acknowledgements
* **Author** - Paul Parkinson, Architect and Developer Advocate
* **Last Updated By/Date** - Paul Parkinson, August 2021
