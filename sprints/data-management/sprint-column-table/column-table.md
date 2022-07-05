# How can I get column names from a table in Oracle?

Duration: 5 minutes

## Retrieving Column Names

If you have a table named *EVENT\_LOG* that contains *eventID*, *eventType*, *eventDesc* and *eventTime* and you want to retrieve those field names from the query and nothing else, you can query the USER\_TAB\_COLUMNS for table column metadata as follows:

```
    <copy>SELECT table_name, column_name, data_type, data_length
    FROM USER_TAB_COLUMNS
    WHERE table_name = 'MYTABLE' <copy/>

```

## Learn More
* [List all Columns in Specific Table in Oracle Database] (https://dataedo.com/kb/query/oracle/list-columns-names-in-specific-table)
* [Managing Tables] (https://docs.oracle.com/cd/B19306_01/server.102/b14231/tables.htm#:~:text=Tables%20are%20the%20basic%20unit,and%20a%20set%20of%20columns.)
* [Database References] (https://docs.oracle.com/cd/B19306_01/server.102/b14237/statviews_2105.htm#REFRN20286)