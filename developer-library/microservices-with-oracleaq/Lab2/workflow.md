**OracleAQ classic queue with OTP based workflow**
 
This Lab will help you to understand the workflow for OTP(one time password) based order delivery application using Oracle Advanced Queues with multiconsumer classic Queues. 

**Task 1: Understanding Delivery workflow and execution process by Image**

**Task 2: Creation of required queues i.e., Customer, Deliverer, Application**
  
          cd $WORKFLOW_HOME; source workflowCreateQueues.sh;
    

**Task 3: Place Order by Customer and application will generate OTP**

1. Order placed updates to Customer: Enqueue User( OrderId, username, OTP, deliveryLocation, deliveryStatus) 

2. Order delivery updates to Deliverer: Enqueue Deliverer(OrderId, deliveryLocation, deliveryStatus)

3. Update DB tables to maintain Order track
       
           cd $WORKFLOW_HOME; source workflowEnqueue.sh;
 

**Task 4: Deliverer meets Customer**

1. Deliverer meets Customer: Dequeue from Deliverer

2. Deliverer collects OTP from Customer: Dequeue browse from Customer

3. Deliverer requests to validate OTP by Application's DB: Enqueue by Deliverer(orderId, OTP, deliveryLocation, deliveryStatus)
    
        cd $WORKFLOW_HOME; source workflowDequeue.sh;

    

**Task 5: Application Validates the OTP shared by Deliverer: DequeueBrowse from Application.**

- Application validation is successful:

  1. Deliver the item: Dequeue from Customer, Dequeue from Application.

  2. Update the Delivery status as "Success"

- Application validation is failed:

  1. Declined delivery: Dequeue from Customer, Dequeue from Application.

  2. Update the Delivery status as "Failed".

**Task 6: Clean ups: Drop the QueueTables(Customer, Deliverer, Application)**

- Stop user, deliverer, application Queues
   
- Drop user, deliverer, application Queues 
   
- Drop user, deliverer, application Queue Tables


       cd $WORKFLOW_HOME; source workflowCleanups.sh;



**Acknowledgements**

**Author -** Mayank Tayal, Developer Advocate 

**Last Updated By/Date -** Mayank Tayal, December 2021
