**Classic Queues**

Oracle Advanced queue with classic queue examples to demonstrate classic queue creation using different payloads, Enqueue , dequeue and cleanups.

    Estimated Time: 10 minutes

**Objectives**

- Create classic Queues
- Multi-consumer Enqueue 
- Multi-consumer Dequeue


**Task 1: Create classic queues**

- Single consumer classic queue with Payload as RAW and  ADT using PL/SQL and Java.

- Multi-Consumer classic queue with Payload as RAW and  ADT using PL/SQL and Java.
    
        

        cd $WORKFLOW_HOME; source basicCreateQueue.sh;

  
    

**Task 2: Basic Enqueue**

- Enqueue for Single consumer classic queue with Payload as RAW using PL/SQL and Java.

- Enqueue for multi-consumer classic queue with Payload as RAW using PL/SQL and Java.
    
        

        cd $WORKFLOW_HOME; source basicEnqueue.sh;

       

**Task 3: Basic Dequeue**

- Dequeue for Single consumer classic queue with Payload as RAW using PL/SQL and Java.

- Dequeue for multi-consumer classic queue with Payload as RAW using PL/SQL and Java.
    
        

        cd $WORKFLOW_HOME; source basicDequeue.sh;

       

**Task 4: Clean ups**

- Stop classic Queues
   
- Drop classic Queues 
   
- Drop Queue Tables

       

        cd $WORKFLOW_HOME; source basicCleanups.sh;

        
    
    
    
**Acknowledgements**

**Author -** Mayank Tayal, Developer Advocate 

**Last Updated By/Date -** Mayank Tayal, December 2021
