# Create the Graph

## Introduction

Now, the tables are created and populated with data. Let's create a graph representation of them.

Estimated time: 5 minutes

### Objectives

Learn how to create a graph from relational data sources by:
- Starting a client (Python shell) that connects to the Graph Server
- Using PGQL Data Definition Language (DDL) (e.g. CREATE PROPERTY GRAPH) to instantiate a graph

### Prerequisites

- This lab assumes you have successfully completed the lab - Create and populate tables.

## Task 1: Start the Python client

Connect to the compute instance via SSH as **opc** user, using the private key you created earlier.

```
<copy>
ssh -i <private_key> opc@<public_ip_for_compute>
</copy>
```

Example:

```
ssh -i key.pem opc@203.0.113.14
```

Start a Python client shell instance that connects to the server.

```
<copy>
opg4py -b https://localhost:7007 -u customer_360
</copy>
```

You should see the following if the client shell starts up successfully.

```
password:

Oracle Graph Client Shell 21.4.2
>>>
```

## Task 2: Create a graph

Set up the create property graph statement, which creates a graph from the existing tables.

```    
<copy>
statement = '''
CREATE PROPERTY GRAPH "customer_360"
  VERTEX TABLES (
    customer
  , account
  , merchant
  )
  EDGE TABLES (
    account
      SOURCE KEY(id) REFERENCES account
      DESTINATION KEY(customer_id) REFERENCES customer
      LABEL owned_by PROPERTIES (id)
  , parent_of
      SOURCE KEY(customer_id_parent) REFERENCES customer
      DESTINATION KEY(customer_id_child) REFERENCES customer
  , purchased
      SOURCE KEY(account_id) REFERENCES account
      DESTINATION KEY(merchant_id) REFERENCES merchant
  , transfer
      SOURCE KEY(account_id_from) REFERENCES account
      DESTINATION KEY(account_id_to) REFERENCES account
  )
'''
</copy>
```

For more about DDL syntax, please see [pgql-lang.org](https://pgql-lang.org/spec/1.4/#create-property-graph). Please note that *all columns of the input tables are mapped to the properties of vertices/edges [by default](https://pgql-lang.org/spec/1.4/#properties)*. For **owned_by** edge, only **id** property is given with **PROPERTIES** keyword for edge ID generation purpose, and the other properties are not given, because they are already hold by the account vertices. 

Now execute the PGQL DDL to create the graph.

```
>>> <copy>session.prepare_pgql(statement).execute()</copy>
False   # This is the expected result
```

## Task 3: Check the newly created graph

Check that the graph was created. Copy, paste, and run the following statements in the Python shell.

Attach the graph.

```
>>> <copy>graph = session.get_graph("customer_360")</copy>
```

Check that the graph was created.

```
>>> <copy>graph</copy>
PgxGraph(name: customer_360, v: 15, e: 24, directed: True, memory(Mb): 0)
```

Run some PGQL queries. E.g. the list of the vertex labels:

```
<copy>
graph.query_pgql("""
  SELECT DISTINCT LABEL(v) FROM MATCH (v)
""").print()
</copy>

+----------+
| LABEL(v) |
+----------+
| ACCOUNT  |
| CUSTOMER |
| MERCHANT |
+----------+
```

How many vertices with each label:
```
<copy>
graph.query_pgql("""
  SELECT COUNT(v), LABEL(v) FROM MATCH (v) GROUP BY LABEL(v)
""").print()
</copy>

+---------------------+
| COUNT(v) | LABEL(v) |
+---------------------+
| 5        | MERCHANT |
| 6        | ACCOUNT  |
| 4        | CUSTOMER |
+---------------------+
```

The list of the edge labels:
```
<copy>
graph.query_pgql("""
  SELECT DISTINCT LABEL(e) FROM MATCH ()-[e]->()
""").print()
</copy>

+-----------+
| LABEL(e)  |
+-----------+
| OWNED_BY  |
| PARENT_OF |
| PURCHASED |
| TRANSFER  |
+-----------+
```

How many edges with each label:
```
<copy>
graph.query_pgql("""
  SELECT COUNT(e), LABEL(e) FROM MATCH ()-[e]->() GROUP BY LABEL(e)
""").print()
</copy>

+----------------------+
| COUNT(e) | LABEL(e)  |
+----------------------+
| 4        | OWNED_BY  |
| 8        | TRANSFER  |
| 1        | PARENT_OF |
| 11       | PURCHASED |
+----------------------+
```

## Task 4: Publish the graph

The newly created graph is "private" by default, and is accessible only from the current session. To access the graph from new sessions in future, you can "publish" the graph.

Then create the graph again following the procedure above, then publish it.
```
<copy>
graph.publish()
</copy>
```

Next time you connect you can access the graph kept on memory without re-loading it, if the graph server has not been shutdown or restarted between logins.
```
<copy>
graph = session.get_graph("customer_360")
</copy>
```

Please note that you are allowed to publish graphs because **`PGX_SESSION_ADD_PUBLISHED_GRAPH`** role has been granted when the user is created. Otherwise, it has to be granted by **ADMIN** user and re-connect with the Python shell to pick up the updated permissions.

You may now proceed to the next lab.

## Acknowledgements

- **Author** - Jayant Sharma
- **Contributors** - Arabella Yao, Jenny Tsai
- **Last Updated By/Date** - Ryota Yamanaka, January 2022
