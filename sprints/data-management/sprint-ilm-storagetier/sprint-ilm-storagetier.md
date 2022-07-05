# How do I add storage tier policy to move old data to a different tablespace?
Duration: 10 minutes

USER\_ILMPOLICIES displays details about Automatic Data Optimization policies owned by the user. The view contains common details relevant to all types of Automatic Data Optimization policies, not just details relevant to the data movement-related Automatic Data Optimization policies. Its columns are the same as those in DBA\_ILMPOLICIES. ILM Policies are often seen in data compression use cases such as adding a row-level compression policy after considerable days of no data modifications, such as no data modification in 30 days. The other use cases are adding a storage tier policy to move old data to a different tablespace or just to view the existing policies on a table. You may have a business requirement to move old data to a different tablespace with a comparatively lower cost.  

## ILM POLICIES

 Login to SQLPlus and run the following statements: 
 
### Create table with range partition 

1.  Create table sales\_range\_partition 

    ```
    <copy>
    CREATE TABLE sales_range_partition ( 
        product_id       NUMBER(6), 
        customer_id      NUMBER, 
        channel_id       CHAR(1), 
        promo_id         NUMBER(6), 
        sale_date        DATE, 
        quantity_sold    INTEGER, 
        amount_sold      NUMBER(10,2) 
        ) 
        PARTITION BY RANGE (sale_date) 
        ( PARTITION sales_q1_2020 VALUES LESS THAN (TO_DATE('01-APR-2020','dd-MON-yyyy')), 
        PARTITION sales_q2_2020 VALUES LESS THAN (TO_DATE('01-JUL-2020','dd-MON-yyyy')), 
        PARTITION sales_q3_2020 VALUES LESS THAN (TO_DATE('01-OCT-2020','dd-MON-yyyy')), 
        PARTITION sales_q4_2020 VALUES LESS THAN (TO_DATE('01-JAN-2020','dd-MON-yyyy')) 
    );
    </copy>
    ```  

2. Create tablespace.

    ```
    <copy>
    CREATE TABLESPACE my_tablespace 
        DATAFILE 'tbs_f2.dat' SIZE 20M 
        ONLINE;  
    </copy>
    ```

3. Enable IML Policy to add storage tier policy to move old data to a different tablespace    

    ```
    <copy>
    ALTER TABLE sales_range_partition MODIFY PARTITION sales_q1_2020 
    ILM ADD POLICY
    TIER TO my_tablespace; 
    </copy>
    ```

4. View ILM Policies    

    ```
    <copy>
    select * from user_ilmpolicies; 
    </copy>
    ```
 

## Learn More
* [USER_ILMPOLICIES](https://docs.oracle.com/database/121/REFRN/GUID-50ADFAF7-C9E2-45AB-BBB8-B273986B5D4E.htm)
* [Adding ILM ADO Policies](https://docs.oracle.com/database/121/VLDBG/GUID-DE4C9EB5-FBDC-4621-AA7B-17EBD11FBF27.htm)
