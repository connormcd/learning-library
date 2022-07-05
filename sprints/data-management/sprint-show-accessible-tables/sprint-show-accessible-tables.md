# How do I show tables that are accessible by the current user in the Oracle Database?
Duration: 1 minute

## Show tables that are accessible by the current user
* Data dictionary tables are not directly accessible, but you can access information in them through data dictionary views.
* An ALL_ view displays all the information accessible to the current user, including information from the current user's schema as well as information from objects in other schemas, if the current user has access to those objects by way of grants of privileges or roles.
* To show all tables that are accessible by the current user, regardless of owners, query from the all_tables view:

  ```
  <copy>
  SELECT table_name
  FROM all_tables
  ORDER BY table_name;
  </copy>
  ```

## Learn More

* [Overview of the Data Dictionary](https://docs.oracle.com/en/database/oracle/oracle-database/21/cncpt/data-dictionary-and-dynamic-performance-views.html#GUID-9B9ABE1C-A1E3-464F-8936-978250DC3E1F)
* [About Static Data Dictionary Views](https://docs.oracle.com/en/database/oracle/oracle-database/21/refrn/about-static-data-dictionary-views.html#GUID-10024282-6729-4C66-8679-FD653C9C7DE7)
