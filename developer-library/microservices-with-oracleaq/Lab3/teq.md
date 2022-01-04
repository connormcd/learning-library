**AQ Migration**

This lab will explain the migration from Oracle AQ classic Queues to Oracle AQ Transactional Event Queues(TEQ) using PL/SQL and later using Java. 

**Task 1: Create TEQ**

- Multi-consumer TEQ with Payload as RAW using PL/SQL.

- Multi-Consumer TEQ with Payload as Object Type using PL/SQL.

- Multi-Consumer TEQ with Payload as JSON Type using PL/SQL.

        
        cd $WORKFLOW_HOME; source teqBasicCreate.sh;

  
    

**Task 2: Basic Enqueue in TEQ**

- Enqueue for multi-consumer TEQ with Payload as RAW using PL/SQL.

- Enqueue for multi-Consumer TEQ with Payload as Object Type using PL/SQL.
        

        cd $WORKFLOW_HOME; source teqBasicEnqueue.sh;

       

**Task 3: Basic Dequeue in TEQ**

- Enqueue for multi-consumer TEQ with Payload as RAW using PL/SQL.

- Enqueue for multi-Consumer TEQ with Payload as Object Type using PL/SQL.
        

        cd $WORKFLOW_HOME; source teqBasicDequeue.sh;

       

**Task 4: Clean ups**

- Stop classic Queues
   
- Drop classic Queues 
   

        cd $WORKFLOW_HOME; source teqBasicCleanups.sh;
        

**Task 5: Creation of required queues i.e., Customer, Deliverer, Application**

      cd $WORKFLOW_HOME; source teqWorkflowCreate.sh;
      
**Task 6: Place Order by Customer and application will generate OTP**

- Order placed updates to Customer: Enqueue User( OrderId, username, OTP, deliveryLocation, deliveryStatus)

- Order delivery updates to Deliverer: Enqueue Deliverer(OrderId, deliveryLocation, deliveryStatus)

- Update DB tables to maintain Order track

       cd $WORKFLOW_HOME; source teqWorkflowEnqueue.sh;
       
**Task 7: Deliverer meets Customer**

- Deliverer meets Customer: Dequeue from Deliverer

- Deliverer collects OTP from Customer: Dequeue browse from Customer

- Deliverer requests to validate OTP by Application's DB: Enqueue by Deliverer(orderId, OTP, deliveryLocation, deliveryStatus)

        cd $WORKFLOW_HOME; source teqWorkflowDequeue.sh;
    
**Task 8: Application Validates the OTP shared by Deliverer: DequeueBrowse from Application.**

- Application validation is successful:

  1. Deliver the item: Dequeue from Customer, Dequeue from Application.

  2. Update the Delivery status as "Success"
 
- Application validation is failed:

  1. Declined delivery: Dequeue from Customer, Dequeue from Application.

  2. Update the Delivery status as "Failed".
  
**Task 9: Clean ups: Drop the QueueTables(Customer, Deliverer, Application)**

- Stop user, deliverer, application Queues

- Drop user, deliverer, application Queues

        cd $WORKFLOW_HOME; source teqWorkflowCleanups.sh;
    
    
    
**Acknowledgements**

**Author -** Mayank Tayal, Developer Advocate 

**Last Updated By/Date -** Mayank Tayal, December 2021


