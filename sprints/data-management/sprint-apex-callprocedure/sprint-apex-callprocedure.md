# How do I call a procedure in Oracle Apex on a button submit and pass page parameters?
Duration: 10 minutes

## Calling procedure on button click or submit

In Oracle Apex, we will have use cases where a procedure needs to be called after clicking on a submit button, also passing the page parameters into the procedure. In this sprint, we will take an example of calling a procedure that inserts a record into a database table.

### Create a package and procedure

1. Create a package pl\_newsletter\_pkg1 and procedure pl\_eventmail\_proc1

      ```
      <copy> 
            CREATE OR REPLACE PACKAGE pl_newsletter_pkg1
            IS
                  PROCEDURE pl_eventmail_proc1 ( v_eventname IN VARCHAR ); 
            END; 
      </copy>
      ``` 

2. The procedure pl\_eventmail\_proc1 inserts a record into CUSTOMER\_LIST table, taking the event name parameter from the apex page. optionally we can also send mail to customer's mailing address with event details

      ```
      <copy> 
            CREATE OR REPLACE PACKAGE BODY pl_newsletter_pkg1 
            AS 
                  PROCEDURE pl_eventmail_proc1(  v_eventname IN varchar)
                  IS
                        begin
                              -- assumption CUSTOMER_LIST already has been created
                              insert into CUSTOMER_LIST (eventname) values 
                                                            (v_eventname );
                              -- (optional) send mail to customers about the event details 
                        end;
                  END;
      </copy>
      ``` 

### Invoke the procedure from Apex on button click      
      
   1. On the Apex page on Submit button action, call the PLSQL Procedure passing the event name as parameter

      ```
      <copy> 
            DECLARE  
                  v_eventname varchar2(400); 
                  -- Get the event name from page parameter assign it to a variable,  
                  -- v_eventname varchar2(400) := :P1_EVENTNAME;
            BEGIN
                  -- get event name from Apex form parameters  
                  -- list of email ids can be fetched from a different table
                  pl_newsletter_pkg1.pl_eventmail_proc1( v_emailid, v_eventname );
            END;
      </copy>
      ```      
 
## Learn More

* [Creating Tables](https://docs.oracle.com/cd/B28359_01/server.111/b28310/tables003.htm)
