## Use Oracle Database Sagas with PL/SQL Microservices

This lab will show you how to deploy and run PL/SQL Microservices that use  Oracle Database Sagas

Estimated lab Time - 10 minutes
  
## Task 1: Deploy the PL/SQL Microservices

1. Deploy the PL/SQL Microservices including their compensation logic.

    ```
    <copy>cd $GRABDISH_HOME/osaga-plsql.sh;./install.sh</copy>
    ```


## Task 2: Run the application

1. Identify the EXTERNAL-IP address of the Grafana LoadBalancer by executing the following command:

       ```
       <copy>rn the app command</copy>
       ```

     ![](images/grafana-loadbalancer-externalip.png " ")


Proceed to the next lab.

## Want to Learn More?

* [Multitenant Database–Oracle 19c](https://www.oracle.com/database/technologies/multitenant.html)
* [Oracle Advanced Queuing](https://docs.oracle.com/en/database/oracle/oracle-database/19/adque/aq-introduction.html)
* [Microservices Architecture with the Oracle Database](https://www.oracle.com/technetwork/database/availability/trn5515-microserviceswithoracle-5187372.pdf)
* [https://developer.oracle.com/](https://developer.oracle.com/)

## Acknowledgements
* **Author** - Paul Parkinson, Architect and Developer Advocate
