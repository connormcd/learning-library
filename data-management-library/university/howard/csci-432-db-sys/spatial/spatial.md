# Introduction

## About Oracle Spatial

Oracle’s mission is to help people see data in new ways, discover insights, and unlock endless possibilities. Spatial analysis is about understanding complex interactions based on geographic relationships – answering questions based on where people, assets, and resources are located. Spatial insights enable you to provide better customer service, optimize your workforce, locate retail and distribution centers, evaluate sales and marketing campaigns, and more. With Oracle’s spatial offerings, developers, database professionals, and analysts can use a comprehensive suite of spatial data management, analytics, and visualization tools to integrate spatial analysis and mapping into applications on enterprise grade data management infrastructure – Oracle Database and Oracle Exadata. Innovative technologies of Oracle Cloud Gen 2 and Oracle Autonomous Database, the industry’s only self-driving, self-securing, and self-repairing database, are available to spatial applications. 

As illustrated below, the spatial features of Oracle Database provide scalable and performant storage, processing and analysis of both basic and advanced spatial data types. A series of deployable Java EE components are also provided to support common mid-tier services. 

  ![img alt text](./images/spatial-platform.png)

For more information please visit [https://oracle.com/goto/spatial] (https://oracle.com/goto/spatial)

### Task Overview

In this task you will create and configure spatial data and perform some basic spatial queries.  The scenario involves WAREHOUSES, BRANCHES, and a COASTAL\_ZONE. The WAREHOUSES and BRANCHES are points, and the COASTAL\_ZONE is a polygon. You will create and configure these spatial tables, and then perform spatial queries to identify items on proximity and containment.

## Task 1: Connecting to your Oracle Cloud Database and APEX workspace

1. Log in to the Oracle Cloud at <a href="https://cloud.oracle.com">cloud.oracle.com</a>. Cloud Account Name is howarduniversity. Click "Next".
2. Click on "Direct Sign-In" and enter your Cloud Account email and password.

    ![](./images/direct-sign-in.png " ")

3. Once you are logged in, you are taken to the cloud services dashboard where you can see all the services available to you. Click the navigation menu in the upper left to show top level navigation choices.

    ![](./images/picture100-36.png " ")


4. Click **Autonomous Data Warehouse**.

    ![](https://raw.githubusercontent.com/oracle/learning-library/master/common/images/console/database-adw.png " ")

5. From the Compartment drop down on the left side of the page, expand howarduniversity->spring2022->student1xx and select you student number.

    ![](./images/hu-compartment.png " ")

6. Click on the database you created in lab 1.
   
    ![](./images/adb-compartment.png " ")

7. If your database icon is green and says running under it, proceed to Task 2 below. If your database is stopped, the ADW/ATP icon on the left is yellow says stopped under it then, under the More Actions drop down list, select “Start”, and confirm start.

    ![](./images/adw-stopped.png " ")

8. Confirm start.

    ![](./images/confirm-start.png " ")

9.  Wait a few moments until the icon on the left turns from yellow to green.

    ![](./images/yellow-to-green.png " ")

**Logging on to APEX**

1. On the Autonomous Database console page scroll down to the APEX Instance and click on the name next to the Instance Name (it’s the same name as your database).

    ![](./images/apex-instance-name.png " ")

2. This will open up the APEX Instance Details. Click on **Launch APEX**.

    ![](./images/click-launch-apex.png " ")

3. Enter your workspace name, user name, and password that you created when you did **Lab 3**. If you do not remember this information skip to the **Forgot your APEX Username or Password** section below.

    ![](./images/apex-login.png " ")

4. You will be logged in to your APEX Workspace. Proceed with the Lab.

    ![](./images/apex-main-screen.png " ")

**Note: Forgot your APEX Username or Password**

If you don’t remember your APEX user name and workspace name that you created for **Lab 3** (the user name and workspace name should be the same) then follow the these steps to reset the password for your APEX user name. If you did not do the APEX Lab Homework **(Lab 3)** then you will have to go back  to Lab 3 and complete **Task 1 and 2** from that lab before you can do this Lab. This is only for resetting the password for the user you created in that lab.

1. From the APEX Instance Details console click on **Launch Database Actions**.

    ![](./images/launch-database-actions.png " ")

2. On the Database Actions page click on Database Users under the Administration section.

    ![](./images/db-users.png " ")

3. Find the user you created for the APEX Lab (Lab 3). In that lab the instructions were to create a user with your name as the user name, so most likely that is the user you are looking for. The lab screenshots had TESTUSER as the default, so if you did not use your own name as the user name you may have used TESTUSER. After you find the user, **click on the 3 dots** on the top right of the user and a drop down list will appear. Click on **Edit**.

    ![](./images/click-edit.png " ")

4. On the Edit User screen, input your new password and confirm, then click on **Apply Changes**.

    ![](./images/apply-changes.png " ")

5. After your password change is done, go back to the tab that has the APEX instance details, click on **Launch APEX**.

    ![](./images/launch-apex.png " ")

6. Sign in.

    ![](./images/apex-login.png " ")

7. You will be on the logged in to your APEX Workspace. Proceed with the Lab.

    ![](./images/apex-main-screen.png " ")

## Task 2: Create Sample Data

### Introduction

This task walks you through the steps to create sample spatial data in Oracle Database. 

### About Spatial Data
Oracle Database stores spatial data (points, lines, polygons) in a native data type called  SDO_GEOMETRY.  Oracle Database also provides a native spatial index for high performance spatial operations. This spatial index relies on spatial metadata that is entered for each table and geometry column storing spatial data. Once spatial data is populated and indexed, robust APIs are available to perform spatial analysis, calculations, and processing.

The SDO_GEOMETRY type has the following general format: 
```
SDO_GEOMETRY( 
 [geometry type],           --ID for point/line/polygon
 [coordinate system],       --ID of coordinate system
 [point coordinate],        --for points only
 [line/polygon info],       --for lines/polygons only
 [line/polygon coordinates] --for lines/polygons only
  )
 ```

The most common geometry types are 2-dimensional:

  | ID |Type |
  | --- | --- | 
  | 2001 |Point |
  | 2002 |Line |
  | 2003 |Polygon |

The most common coordinate systems are:

  | ID |Coordinate System |
  | --- | --- | 
  | 4326 |Latitude/Longitude|
  | 3857 |World Mercator|

  When using latitude/longitude, note that latitude is the Y coordinate and longitude is the X coordinate. Since coordinates are listed as X,Y pair, the values are actually in the order longitude, latitude.

  The following is an example point geometry using latitude/longitude coordinates  :

```
SDO_GEOMETRY( 
 2001,               --2D point
 4326,               --latitude/longitude
 SDO_POINT_TYPE(     
    -100.123, 20.456 --coordinate
    ),         
 NULL,               --for lines/polygons only
 NULL                --for lines/polygons only
  )
```

  The following is an example polygon geometry using latitude/longitude coordinates  :

```
SDO_GEOMETRY( 
 2003,                  --2D polygon
 4326,                  --latitude/longitude
 NULL,                  --for points only       
 SDO_ELEM_INFO_ARRAY(
      1, 1003, 1        --indicates simple exterior polygon
        ), 
 SDO_ORDINATE_ARRAY(   
    -98.789065,39.90973, -- coordinates
    -101.2522,39.639537,
    -99.84374,37.160316,
    -96.67987,35.460699,
    -94.21875,39.639537,
    -98.789025,39.90973
      )
    )
);
```

### Objectives

In this task, you will:
* Create tables with a geometry column
* Populate geometries
* Create spatial metadata and indexes

### Prerequisites

As described in the workshop introduction, you need access to an Oracle Database and SQL Client. If you do not have these, then go back to the sections on Oracle Cloud Account, Autonomous Database, and SQL Developer Web.

**Create Tables with Coordinates**

We begin by creating tables with latitude, longitude coordinates. This is a common starting point for creating spatial data, for example coordinates from GPS, or from geocoding street address or IP address.

The instructions and screen shots refer to SQL Developer Web, however the same steps apply for other SQL clients.

1. Download the SQL script [here](files/create-sample-data.sql).

2. Navigate to **SQL Workshop** and click on **SQL Scripts**.

    ![](./images/click-sql-scripts.png " ")

3. Click the **Upload** > button to open the Upload Script dialog. Then drag-and-drop the SQL script you downloaded, enter a script name of your choosing, and then click **Upload** at the bottom of the dialog.

    ![](./images/drag-and-drop.png " ")

4. Click the **Run** button.

    ![](./images/click-run.png " ")

5. Click **Run Now**.

    ![](./images/click-run-now.png " ")

6. Once complete, in the **SQL Workshop** pull-down menu select **Object Browser** and observe the BRANCHES and WAREHOUSES tables have been created.

    ![](./images/branches-warehouses.png " ")

**Create Geometries from Coordinates**

Geometries can be populated with SQL, for example by specifying the coordinates of point geometries based on  latitude and longitude columns.

1. In the **SQL Workshop** pull-down menu, select **SQL Commands**.

2. Add geometry columns by running the following. Highlight the first command and click run. 

    ```
    <copy> 
    ALTER TABLE WAREHOUSES ADD (
     GEOMETRY SDO_GEOMETRY
    );

    ALTER TABLE BRANCHES ADD (
       GEOMETRY SDO_GEOMETRY
    );
    </copy>
    ```

    ![](./images/run-commands.png " ")

3. Highlight the second command and click run.
   **Note**: Only one command can be highlighted at a time, then click run.
   
4. Populate geometry columns by running the following. Highlight the first command and click run.

    ```
    <copy> 
    UPDATE WAREHOUSES
    SET
        GEOMETRY = SDO_GEOMETRY(
            2001, 4326, SDO_POINT_TYPE(
                LON, LAT, NULL
            ), NULL, NULL
        );
     UPDATE BRANCHES
     SET
        GEOMETRY = SDO_GEOMETRY(
            2001, 4326, SDO_POINT_TYPE(
                LON, LAT, NULL
            ), NULL, NULL
        );
    </copy>
    ```

    ![](./images/populate-columns.png " ")

5. Highlight the second command and click run.
   **Note**: Only one command can be highlighted at a time, then click run.

**Create Table with Polygon**

Lines and polygons can be created in the same way. While a point geometry requires one coordinate, lines and polygons require all of the coordinates that define the geometry. In this case we create a table to store a polygon.

1. Create table and insert row by running the following. Highlight the first command and click **Run**.
   
	```
    <copy>
    CREATE TABLE COASTAL_ZONE (
        ZONE_ID   NUMBER,
        GEOMETRY  SDO_GEOMETRY
    );       

    INSERT INTO COASTAL_ZONE VALUES (
        1,
        SDO_GEOMETRY(
            2003, 4326, NULL, SDO_ELEM_INFO_ARRAY(
                1, 1003, 1
            ), SDO_ORDINATE_ARRAY(
                -93.719934, 30.210638,
                -95.422592, 29.773714, 
                -95.059698, 29.322204, 
                -96.013892, 28.787021, 
                -96.660964, 28.925638, 
                -97.528688, 28.042050, 
                -97.858501, 27.447461, 
                -97.497364, 25.880056, 
                -96.977826, 25.969716, 
                -97.211445, 27.054605, 
                -96.870226, 27.816077, 
                -93.794290, 29.535729, 
                -93.719934, 30.210638
            )
        )
    );
    </copy>
    ```
    ![](./images/create-polygon.png " ")

2. Repeat for second command.

**Add Spatial Metadata and Indexes**
Oracle Database provides a native spatial index for high performance spatial operations. Our sample data is so small that a spatial index is not really needed. However we perform the following steps since they are important for typical production data volumes. A spatial index requires a row of metadata for the geometry being indexed. We create this metadata and then the spatial indexes.


1. Add spatial metadata by running the following. Highlight the first command and click **Run**.

    ```
    <copy> 
    INSERT INTO USER_SDO_GEOM_METADATA VALUES (
       'WAREHOUSES',
       'GEOMETRY',
       SDO_DIM_ARRAY(
           SDO_DIM_ELEMENT(
               'x', -180, 180, 0.05
           ), SDO_DIM_ELEMENT(
               'y', -90, 90, 0.05
           )
       ),
       4326
   );

   INSERT INTO USER_SDO_GEOM_METADATA VALUES (
       'BRANCHES',
       'GEOMETRY',
       SDO_DIM_ARRAY(
           SDO_DIM_ELEMENT(
               'x', -180, 180, 0.05
           ), SDO_DIM_ELEMENT(
               'y', -90, 90, 0.05
           )
       ),
       4326
   );

   INSERT INTO USER_SDO_GEOM_METADATA VALUES (
       'COASTAL_ZONE',
       'GEOMETRY',
       SDO_DIM_ARRAY(
           SDO_DIM_ELEMENT(
               'x', -180, 180, 0.05
           ), SDO_DIM_ELEMENT(
               'y', -90, 90, 0.05
           )
       ),
       4326
   );
    </copy>
    ```
    ![](./images/spatial-metadata.png " ")

3. Repeat for the other two commands.

4. Create spatial indexes metadata by running the following. Highlight the first command and click **Run**.

    ```
    <copy> 
   CREATE INDEX WAREHOUSES_SIDX ON
       WAREHOUSES (
           GEOMETRY
       )
           INDEXTYPE IS MDSYS.SPATIAL_INDEX;

   CREATE INDEX BRANCHES_SIDX ON
       BRANCHES (
           GEOMETRY
       )
           INDEXTYPE IS MDSYS.SPATIAL_INDEX;

   CREATE INDEX COASTAL_ZONE_SIDX ON
       COASTAL_ZONE (
           GEOMETRY
       )
           INDEXTYPE IS MDSYS.SPATIAL_INDEX;
    </copy>
    ```
    ![](./images/indexes-metadata.png " ")

5. Repeat for the other two commands.

    After the indexes are created, in the **SQL Workshop** pull-down menu, select **Object Browser**. You will see 3 tables having names beginning with MDRT_. These are artifacts of the spatial indexes and are managed by Oracle Database automatically. You should never manually manipulate these tables.
    ![Image alt text](images/object-browsers.png)


    Our sample data is now prepared and ready for spatial queries. 

    If you need to revert this task and remove the items created, run the following:

        DROP TABLE BRANCHES;   
        DROP TABLE WAREHOUSES;
        DROP TABLE COASTAL_ZONE;
        DELETE FROM USER_SDO_GEOM_METADATA;
        COMMIT;

## Task 3: Spatial Queries

### Introduction

This task walks you through basic spatial queries in Oracle Database.  You will use the sample data created in the previous task to identify items based on proximity and containment.

### About Spatial Queries
Oracle Database includes a robust library of functions and operators for spatial analysis. This includes spatial relationships, measurements, aggregations, transformations, and much more. These operations are accessible through native SQL, PL/SQL, Java APIs, and any other language that communicates with Oracle Database.

### Objectives

In this task, you will:
* Identify BRANCHES having proximity relationships to a WAREHOUSE
* Identify BRANCHES having containment and proximity relationships to a COASTAL_ZONE

### Prerequisites

* Completion of previous task; Create Sample Spatial Data

<!--  *This is the "fold" - below items are collapsed by default*  -->

### Spatial Queries 

Spatial queries in Oracle Database are just like any other traditional queries you are accustomed to. The only difference is a set of spatial functions and operators that are probably new to you.

**Identify 5 closest branches to the the Dallas Warehouse:**
```
<copy> 
SELECT
    BRANCH_NAME,
    BRANCH_TYPE
FROM
    BRANCHES    B,
    WAREHOUSES  W
WHERE
    W.WAREHOUSE_NAME = 'Dallas Warehouse'
    AND SDO_NN(
        B.GEOMETRY, W.GEOMETRY, 'sdo_num_res=5'
    ) = 'TRUE';
</copy>
```
![Image alt text](images/query1.png)
Notes:
    
* The ```SDO_NN``` operator returns the 'n nearest' branches to the Dallas Warehouse, where 'n' is the value specificed for ```SDO_NUM_RES```. The first argument to ```SDO_NN``` (```B.GEOMETRY``` in the example above) is the column to search. The second argument (```W.GEOMETRY``` in the example above) is the location you want to find the neighbors nearest to. No assumptions should be made about the order of the returned results. For example, the first row returned is not guaranteed to be the closest. If two or more branches are an equal distance from the warehouse, then either may be returned on subsequent calls to ```SDO_NN```.
* When using the ```SDO_NUM_RES``` parameter, no other criteria are used in the ```WHERE``` clause. ```SDO_NUM_RES``` takes only proximity into account. For example, if you added a criterion to the ```WHERE``` clause because you wanted the five closest branches having a specific zipcode, and four of the five closest branches have a different zipcode, the query above would return one row. This behavior is specific to the ```SDO_NUM_RES``` parameter. In an query below you will use an alternative parameter for the scenario of additional query criteria. 

**Identify 5 closest branches to the the Dallas Warehouse with distance:**
```
<copy>
SELECT
    BRANCH_NAME,
    BRANCH_TYPE,
    ROUND(
        SDO_NN_DISTANCE(
            1
        ), 2
    ) DISTANCE_KM
FROM
    BRANCHES    B,
    WAREHOUSES  W
WHERE
    W.WAREHOUSE_NAME = 'Dallas Warehouse'
    AND SDO_NN(
        B.GEOMETRY, W.GEOMETRY, 'sdo_num_res=5 unit=km', 1
    ) = 'TRUE'
ORDER BY
    DISTANCE_KM;
</copy>
```
![Image alt text](images/query2.png)
Notes:

* The ```SDO_NN_DISTANCE``` operator is an ancillary operator to the ```SDO_NN``` operator; it can only be used within the ```SDO_NN``` operator. The argument for this operator is a number that matches the number specified as the last argument of ```SDO_NN```; in this example it is 1. There is no hidden meaning to this argument, it is simply a tag. If ```SDO_NN_DISTANCE()``` is specified, you can order the results by distance and guarantee that the first row returned is the closest. If the data you are querying is stored as longitude and latitude, the default unit for ```SDO_NN_DISTANCE``` is meters.
* The ```SDO_NN``` operator also has a ```UNIT``` parameter that determines the unit of measure returned by ```SDO_NN_DISTANCE```.
* The ```ORDER BY DISTANCE``` clause ensures that the distances are returned in order, with the shortest distance first.

**Identify 5 closest WHOLESALE branches to the the Dallas Warehouse with distance:**
```
<copy>
SELECT
    BRANCH_NAME,
    BRANCH_TYPE,
    ROUND(
        SDO_NN_DISTANCE(
            1
        ), 2
    ) DISTANCE_KM
FROM
    BRANCHES    B,
    WAREHOUSES  W
WHERE
    W.WAREHOUSE_NAME = 'Dallas Warehouse'
    AND B.BRANCH_TYPE = 'WHOLESALE'
    AND SDO_NN(
        B.GEOMETRY, W.GEOMETRY, 'sdo_batch_size=5 unit=km', 1
    ) = 'TRUE'
    AND ROWNUM <= 5
ORDER BY
    DISTANCE_KM;
</copy>
```

![Image alt text](images/query3.png)
Notes:
* ```SDO_BATCH_SIZE``` is a tunable parameter that may affect your query's performance. ```SDO_NN``` internally calculates that number of distances at a time. The initial batch of rows returned may not satisfy the constraints in the WHERE clause, so the number of rows specified by ```SDO_BATCH_SIZE``` is continuously returned until all the constraints in the WHERE clause are satisfied. You should choose a ```SDO_BATCH_SIZE``` that initially returns the number of rows likely to satisfy the constraints in your WHERE clause.
* The ```UNIT``` parameter used within the ```SDO_NN``` operator specifies the unit of measure of the ```SDO_NN_DISTANCE``` parameter. The default unit is the unit of measure associated with the data. For longitude and latitude data, the default is meters.
* ```B.BRANCH_TYPE = 'WHOLESALE' AND ROWNUM <= 5``` are the additional constraints in the ```WHERE``` clause. The rownum  clause is necessary to limit the number of results returned to 5.
* The ```ORDER BY DISTANCE_KM``` clause ensures that the distances are returned in order, with the shortest distance first and the distances measured in miles.

**Identify branches within 50km of Houston Warehouse:**
```
<copy>
SELECT
    B.BRANCH_NAME,
    B.BRANCH_TYPE
FROM
    BRANCHES    B,
    WAREHOUSES  W
WHERE
    W.WAREHOUSE_NAME = 'Houston Warehouse'
    AND SDO_WITHIN_DISTANCE(
        B.GEOMETRY, W.GEOMETRY, 'distance=50 unit=km'
    ) = 'TRUE';
</copy>
```
![Image alt text](images/query4.png)
Notes:
* The first argument to ```SDO_WITHIN_DISTANCE``` is the column to search. The second argument is the location you want to determine the distances from. No assumptions should be made about the order of the returned results. For example, the first row returned is not guaranteed to be the customer closest to warehouse 3.
* The DISTANCE parameter used within the ```SDO_WITHIN_DISTANCE``` operator specifies the distance value; in this example it is 100.
* The UNIT parameter used within the ```SDO_WITHIN_DISTANCE``` operator specifies the unit of measure of the DISTANCE parameter. The default unit is the unit of measure associated with the data. For longitude and latitude data, the default is meters; in this example, it is miles.

**Identify branches within 50km of Houston Warehouse with distance:**

```
<copy>
SELECT
    B.BRANCH_NAME,
    B.BRANCH_TYPE,
    ROUND(
        SDO_GEOM.SDO_DISTANCE(
            B.GEOMETRY, W.GEOMETRY, 0.05, 'unit=km'
        ), 2
    ) AS DISTANCE_KM
FROM
    BRANCHES    B,
    WAREHOUSES  W
WHERE
    W.WAREHOUSE_NAME = 'Houston Warehouse'
    AND SDO_WITHIN_DISTANCE(
        B.GEOMETRY, W.GEOMETRY, 'distance=50 unit=km'
    ) = 'TRUE'
ORDER BY
    DISTANCE_KM;
</copy>
```
![Image alt text](images/query5.png)
Notes:
* The ```SDO_GEOM.SDO_DISTANCE``` function computes the distance between branch locations and the Houston Warehouse. 
* The first 2 arguments to ```SDO_GEOM.SDO_DISTANCE``` are BRANCH and WAREHOUSE locations for distance computation.
* The third argument to ```SDO_GEOM.SDO_DISTANCE ``` is the tolerance value. The tolerance is a round-off error value used by Oracle Spatial. The tolerance is in meters for longitude and latitude data. In this example, the tolerance is 50 mm.
* The UNIT parameter used within the ```SDO_GEOM.SDO_DISTANCE``` parameter specifies the unit of measure of the distance computed by the ```SDO_GEOM```.```SDO_DISTANCE``` function. The default unit is the unit of measure associated with the data. For longitude and latitude data, the default is meters. In this example it is miles.
* The ```ORDER BY DISTANCE_IN_MILES``` clause ensures that the distances are returned in order, with the shortest distance first and the distances measured in miles.

**Identify branches in the coastal zone:**

```
<copy>
SELECT
    B.BRANCH_NAME,
    B.BRANCH_TYPE
FROM
    BRANCHES      B,
    COASTAL_ZONE  C
WHERE
    SDO_ANYINTERACT(
        B.GEOMETRY, C.GEOMETRY
    ) = 'TRUE';
</copy>
```
![Image alt text](images/query6.png)
Notes:
* The ```SDO_ANYINTERACT``` operator accepts 2 arguments, geometry1 and geometry2. The operator returns ```TRUE``` for rows where geometry1 is inside or on the boundary of geometry2.
* In this example geometry1 is ```B.GEOMETRY```, the branch geometries, and geometry2 is ```C.GEOMETRY```, the coastal zone geometry. The COASTAL_ZONE table has only 1 row so no additional criteria is needed.

## Task 4: Homework

**Perform Tasks 1-3**

**Show the results of a spatial query in an APEX map.**

1. In the **App Builder** pull-down menu, select **Create**. Then click on **New Application**.
    ![Image alt text](images/click-app-builder.png)

2. Click **Add Page** and then select **Blank**.
    ![Image alt text](images/blank-page.png)

3. Enter **Map** as the page name and click **Add Page**.
    ![Image alt text](images/add-page.png)

4. Enter **Spatial lesson homework** as the application name and click **Create Application**.
    ![Image alt text](images/create-application.png)

5. Click **Run Application**.
    ![Image alt text](images/run-application.png)

6. Log in with your APEX username and password.
    ![Image alt text](images/login-apex.png)

7. Click on the tile to navigate to your **Map** page.
    ![Image alt text](images/map-page.png)

8. The page is initially blank. Click on the **Page 2** button at the bottom to edit the page.
    ![Image alt text](images/click-edit-page.png)

9. Drag a **Map** region into the **REGION BODY**.
    ![Image alt text](images/drag-map.png)

10. Set the title to **My Map**.
    ![Image alt text](images/my-map.png)

11. Under Layers, click on **New**.
    ![Image alt text](images/click-new.png)

12. Update the layer title to **Coastal Zone** and layer type to **Polygons**. Under Source, set the table name to **COASTAL_ZONE**.
    ![Image alt text](images/under-layers.png)

13. Scroll down the Layer panel on the right. Under Column Mapping set geometry column type to **SDO_GEOMERY**, geometry column to **GEOMETRY**.  Under Appearance set fill color to #18079d or a color of your choosing, and set fill opacity to **0.5**.
    ![Image alt text](images/sdo-geometry.png)

14. In the page tree on the left, right click on Layers and select **Create Layer**.
    ![Image alt text](images/create-layer.png)

15. In the Layer panel on the right, set the layer name to **Branches**, layer type to **Points** and table name to **BRANCHES**.
    ![Image alt text](images/branches-points.png)

16. Scroll down the Layer panel on the right. Under Column Mapping set geometry column type to **SDO_GEOMERY**, geometry column to **GEOMETRY**.  Under Appearance set fill color to #00ff00 or a color of your choosing.
    ![Image alt text](images/fill-color.png)
    
17. Again, in the Page tree on the left, right-click on Layers and select **Create Layer**. In the Layer panel on the right, set the new layer name to **Branches in zone** and Layer Type to **Points**. Under Source, set Type to **SQL Query**. Enter the following **into SQL Query**:
    ```
    <copy>
    SELECT
    B.BRANCH_NAME,
    B.BRANCH_TYPE,
    B.GEOMETRY
  FROM
    BRANCHES      B,
    COASTAL_ZONE  C
  WHERE
    SDO_ANYINTERACT(
        B.GEOMETRY, C.GEOMETRY
    ) = 'TRUE';
    </copy>
    ```
    This is the query from Task 3 titled **Identify branches in the coastal zone**, with the addition of GEOMETRY so that the result can be rendered on a map.

    ![Image alt text](images/query-branches.png)

17. Scroll down the Layer panel on the right. Under Column Mapping set geometry column type to **SDO_GEOMERY**, geometry column to **GEOMETRY**. Under Appearance set fill color to #ff0000.
    ![Image alt text](images/set-fill-color.png)

18. On the top right, click **Save** and then **Run**.
    ![Image alt text](images/save-and-run.png)

**Take a screenshot of your APEX page and upload to Blackboard.**
![Image alt text](images/final-map.png)





