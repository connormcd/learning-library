# How do I enable OLTP table compression?
Duration: 10 minutes

Oracle's OLTP Table Compression uses a unique compression algorithm specifically designed to work with OLTP applications. The algorithm eliminates duplicate values within a database block, even across multiple columns. Compressed blocks contain a structure called a symbol table that maintains compression metadata. When a block is compressed, duplicate values are eliminated by first adding a single copy of the duplicate value to the symbol table. Each duplicate value is then replaced by a short reference to the appropriate entry in the symbol table. 

## Enable OLTP table compression 

1. Create table Emp with OLTP table compression

      ```
      <copy>
      CREATE TABLE emp  (
               emp_id NUMBER , first_name VARCHAR2(128) , last_name VARCHAR2(128) 
            ) COMPRESS FOR OLTP;
      </copy>
      ```  

2. Verify compression.

      ```
      <copy>
      SELECT table_name, compression, compress_for FROM user_tables where table_name = 'EMP' ;
      </copy>
      ```  

      ![View EMP Table Compression](images/emp-table.png "View EMP Table Compression") 
     
 
## Learn More
* [DBMS_COMPRESSION](https://docs.oracle.com/cd/E11882_01/appdev.112/e40758/d_compress.htm )
