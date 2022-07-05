# How do I show all tables in the Oracle Database?
Duration: 1 minute

## Show all tables in the Oracle Database
* Data dictionary tables are not directly accessible, but you can access information in them through data dictionary views.
* A DBA_ view displays all relevant information in the entire database. DBA_ views are intended only for administrators. They can be queried only by users with the SYSDBA system privilege or SELECT ANY DICTIONARY privilege, or SELECT_CATALOG_ROLE role, or by users with direct privileges granted to them. The SELECT ANY DICTIONARY privilege is assigned to the DBA role when the system is initially installed.
* To show all tables in the Oracle Database, query from the dba_tables view:

  ```
  <copy>
  SELECT table_name FROM dba_tables;
  </copy>
  ```

## Learn More

* [Overview of the Data Dictionary](https://docs.oracle.com/en/database/oracle/oracle-database/21/cncpt/data-dictionary-and-dynamic-performance-views.html#GUID-9B9ABE1C-A1E3-464F-8936-978250DC3E1F)
* [About Static Data Dictionary Views](https://docs.oracle.com/en/database/oracle/oracle-database/21/refrn/about-static-data-dictionary-views.html#GUID-10024282-6729-4C66-8679-FD653C9C7DE7)
