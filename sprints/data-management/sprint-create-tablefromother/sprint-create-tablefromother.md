# How do I create one table from another table including data?
Duration: 10 minutes

## Create table

To create a new table in your schema, you must have the CREATE TABLE system privilege. To create a table in another user's schema, you must have the CREATE ANY TABLE system privilege. Additionally, the owner of the table must have a quota for the tablespace that contains the table, or the UNLIMITED TABLESPACE system privilege.

### Create a new table from another sample table

1. Create customers360 table from a sales sample table in Autonomous Database

      ```
      <copy> 
            CREATE TABLE CUSTOMERS360 AS
            (SELECT a.CUST_ID, a.CUST_GENDER, a.CUST_MARITAL_STATUS,
             a.CUST_YEAR_OF_BIRTH, a.CUST_INCOME_LEVEL, a.CUST_CREDIT_LIMIT,
             b.EDUCATION, b.AFFINITY_CARD,
             b.HOUSEHOLD_SIZE, b.OCCUPATION, b.YRS_RESIDENCE, b.Y_BOX_GAMES
            FROM SH.CUSTOMERS a, SH.SUPPLEMENTARY_DEMOGRAPHICS b
            WHERE a.CUST_ID = b.CUST_ID); 
      </copy>
      ``` 
      
2. Grant CUSTOMERS360 table access to OMLUSER user

      ```
      <copy> 
      GRANT
            SELECT,
            INSERT,
            UPDATE,
            DELETE
            ON
            ADMIN.CUSTOMERS360
      TO
            OMLUSER; 
      </copy>
      ```      
 
## Learn More

* [Creating Tables](https://docs.oracle.com/cd/B28359_01/server.111/b28310/tables003.htm)
