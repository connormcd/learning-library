# Create an APEX app to view and update the data

## Overview

This lab will show you how to create APEX applications that will allow you to view and update the microservice data.

Estimated Time: 10 minutes

Watch the video below for a quick walk through the Task 1 and 2 of the lab.

[](youtube:fJqtSAHgj1Q)

### Objectives

* Create an APEX workspace in the Oracle Autonomous database
* Create an APEX app based on the inventory table
* Create an APEX Analytics app based on the order history data

### Prerequisites

* The Oracle Autonomous Transaction Processing database named DB2 (created in Lab 1)
* The Oracle Autonomous Transaction Processing database named DB1 (created in Lab 1)

## Task 1: Create a New Workspace in APEX

When you first access APEX you will need to log in as an APEX instance administrator to create a workspace. A workspace is a logical domain where you define APEX applications. Each workspace is linked to one or more database schemas (database users) which are used to store the database objects, such as tables, views, packages, and more.

1. Navigate to the Oracle Autonomous Transaction Processing database instance named DB2 (Display Name), containing the inventory schema, created in Lab 1. Click the **Tools** tab and then the **Open APEX** button.

    ![Open APEX](images/click-open-apex.png)

2. Enter the password for the Administration Services and click **Sign In to Administration**. The password should match the one you used when creating the Oracle Autonomous Transaction Processing instance.

    ![Sign In](images/log-in-as-admin-inv.png)

3. Click **Create Workspace**.

    ![Create Workspace Screen](images/welcome-create-workspace-inv.png)

4. Set **Database User** to **INVENTORYUSER** and then click **Create Workspace**.

    ![Create Workspace](images/create-workspace-inv.png)

5. After the workspace has been created, click the **INVENTORYUSER** link in the success message. This will log you out of APEX administration so that you can log into your new workspace.

    ![Select Inventory User](images/select-inv.png)

6. Enter the password you used when creating the database during setup, check the **Remember workspace and username** checkbox, and then click **Sign In**.

    ![Sign In](images/log-in-to-workspace-inv.png)

    You have successfully created an APEX workspace where you can begin creating applications.

7. Click the **Set APEX Account Password** button.

    ![Set Password](images/set-apex-account-password.png)

8. Enter your **Email Address** and a new password.

    ![Edit Profile](images/edit-profile.png)

## Task 2: Create a New APEX App Based on the Inventory Table

In this task, you will create a new APEX app based on the inventory table.

1. Click the **App Builder** button.

    ![Navigate to App Builder](images/click-app-builder-inv.png)

2. Click the **Create** button.

    ![Create Button](images/click-create-inv.png)

3. Click the **New Application** button.

    ![New Application Button](images/click-new-application-inv.png)

4. Enter **INVENTORY** for the application name and click the **Add page** button.

    ![Add Page](images/create-an-application-inv.png)

5. Click the **Interactive Grid** button.

    ![Interactive Page](images/select-interactive-grid-inv.png)

6. Enter **INVENTORY** for the page name and select the **INVENTORY** table. Click **Add Page**.

    ![Enter Page Name](images/grid-page-details.png)

7. Click the **Create Application** button.

    ![Create Application](images/create-application-inv.png)

8. Click the **Run Application** button.

    ![Run Application](images/run-application-inv.png)

9. Enter the password that you entered in Task 1 step 8.

    ![Sign In](images/app-login-inv.png)

10. Click the **INVENTORY** page.

    ![Access Inventory Page](images/click-inv.png)

11. The INVENTORY table data will be displayed and can be edited.

    ![Inventory Table](images/inv-app.png)

12. Now that you've logged into the application, take a few moments to explore what you get out of the box. Of course, this is just the starting point for a real app, but it's not bad for not having written any lines of code!


## Task 3: Create a New APEX App based on Order history data 
In this task you will create a new APEX app for analytics purpouse based on an extended database schema based on a list of orders, order time, time to delivery and so on that will not be implemented through a microservice because is out of scope. In order to facilitate an easier approach to build this analytics dashboard, we provide instead a CSV file from [here](AnalyticsDataForLab6.csv?raw=1) to go straight to the APEX app development.

1.  Repeat same steps in Task 1, choosing **DB1** as Autonomous DB, and **ORDERUSER** as user and Workspace name. After that, proceed in building the new app. 

2. Click the **App Builder** button:

    ![App Builder](images/app-builder-1.png)

3. Click the **Create** button:
    ![Create App](images/create-app-1.png)

4. Click the **From a File** button:

    ![Create from CSV](images/create-from-csv-1.png)

5. Click on **Choose File** button and upload CSV to download [here](AnalyticsDataForLab6.csv?raw=1).

    ![Drag & Drop file](images/drag-and-drop-1.png)

6. Set Table Name **ORDER_HISTORY**:
    ![Set Table Name](images/set-table-1.png)

8. Click on **Identity Column**:
    ![Identify Column](images/identify-column-1.png)

9. Click on **Configure** button to adapt table schema to csv data:
    ![Configure Button](images/configure-button-1.png)

10. On parsed schema:
    ![Schema orig](images/schema-1.png)
    
     * uncheck **ID** in **Column Name**
     * set as **VARCHAR2** **Column Type** **ORDERID**, **ITEMID**, **DELIVERYZIP**
     * for columns changed in Column Type, set **100** as **Max Length**
     * click on **Save Changes** at the end 

     before save, schema should appear as follow:

    ![Schema orig](images/schema-new-1.png)

11. Click on **Load Data** button on bottom-right corner: 

    ![Schema orig](images/load-data-1.png)

12. CSV should successfully be uploaded and on following dialog window click on **Create Application** button:
    ![Create App Order History Dashboard](images/create-app-order-1.png)

13. It will be proposed a standard application template that you could be customized as you like. We'll lerverage Dashboard page. **For Features**, please click on **Check All** and leave the rest as proposed. Then click on **Create Application** button.

    ![Customize Dashboard](images/create-dashboard-app-1.png)

    At the end of app generation, you should see as follow:
    
    ![Generated Dashboard](images/generated-app-1.png)

14. Click on **Run Application** button on top-left corner to see home page generated app. You should see as follow:

    ![Home Page](images/home-page-1.png)

## Task 4: Customize as Analytics Dashboard the APEX app created on Order history data: let's show KPIs

1. Back to **App Builder** page, and on **Order Histories** app, click on **2 - Dashboard** page in order to customize it:

    ![Home Page](images/customize-dashboard-1.png)

2. Create a **Region** under **Components** to show a list of KPIs about Grabdish business.
    ![Home Page](images/create-region-1.png)

3. In right pane, under **Region** tab and **Layout**/**Position**, choose **Full Width Content**

    ![Full Width Position](images/full-width-pos-1.png)

4. In right pane, under **Region** tab, uncheck **Start New Row**:

    ![Full Width Position](images/uncheck-newrow-1.png)

5. Repeat for 3 times the same steps from Task 4 - Step 2. At the end you should have this page layout:
    ![Full Width 4](images/full-width-4-1.png)

6. We'll use PL/SQL Dynamic Content to show a SQL query result as an HTML snippet code in the region. Select each region created at the steps before, and on the right pane, set:
 **Identification** / **Type**: **PL/SQL Dynamic Content**

    ![Dynamic Content](images/dynamic-content-1.png)
* with the information provided in the next step, i.e.:
    * **Identification** / **Title**
    * **Appearence** / **Template Options** / **Accent**
    * **Source** / **PL/SQL Code**  
    ![PL/SQL code](images/plsql-code-1.png)
    
    customize each region.
    
* Specific sets for each region named **New** from left to right:
    * First Region **New**
        * **Title**: **Top ZipCode Deliveries**
        * **Accent**: **Accent1**
        * **PL/SQL Code**: 
        ```
        <copy>
        DECLARE
         CURSOR zip_cur
        IS
            select count(DISTINCT (TO_CHAR( date_, 'MM/DD' ) || ' ord:' || orderid)) ord_n_zip, deliveryzip from order_history group by deliveryzip order by ord_n_zip desc ;
        topZip   zip_cur%ROWTYPE;
  
        BEGIN
          OPEN zip_cur;
          Htp.p('<div class="zip-container">');
          FETCH zip_cur INTO topZip;
          Htp.p('<h1>' || topZip.deliveryzip || '</h1>');
          CLOSE zip_cur;
          Htp.p('</div>');
        END;
        </copy>
        ```
    * Second Region **New**
        * **Title**: **Top Dish**
        * **Accent**: **Accent4**
        * **PL/SQL Code**: 
        ```
        <copy>
        DECLARE
            CURSOR dish_cur
                IS
                select ITEM_NAME,sum(ITEMCOUNT) value
                from ORDER_HISTORY
                group by ITEM_NAME
                order by 2 desc;
            topDish   dish_cur%ROWTYPE;
  
        BEGIN
            OPEN dish_cur;
            Htp.p('<div class="dish-container">');
            FETCH dish_cur INTO topDish;
            Htp.p('<h1>' || topDish.ITEM_NAME || '</h1>');
            CLOSE dish_cur;
            Htp.p('</div>');
        END;
        </copy>
        ```

    * Third Region **New**
        * **Title**: **TOP Busiest Hour**
        * **Accent**: **Accent8**
        * **PL/SQL Code**: 
        ```
        <copy>

        DECLARE
            CURSOR c_Order 
                IS    
                with orders_by_day as
                (select count(distinct orderid) orders,date_  order_day,to_char(orderreceivedtime,'HH24') order_hour from order_history
                group by date_,to_char(orderreceivedtime,'HH24'))
                select avg(orders) avg_order ,order_hour from orders_by_day
                where rownum < 2
                group by order_hour
                order by avg_order desc;
        BEGIN  
            
            Htp.p('<div class="busiest-container">');
            For Rec_d In c_Order Loop
                Htp.p('<h1>' || Rec_d.order_hour || ':00 </h1>');
            End Loop;
           
            Htp.p('</div>');
        END;        

        
        </copy>
        ```

    * Fourth Region **New**
        * **Title**: **Top Delay**
        * **Accent: Accent15**
        * **PL/SQL Code**: 
        ```
        <copy>
        DECLARE
            CURSOR delay_cur
                IS
                SELECT DISTINCT (TO_CHAR( date_, 'MM/DD' ) || ' ord:' || orderid) orderCode ,actualdeliverytime , date_,promisedtime,((promisedtime - actualdeliverytime) * 1440) delay
                from order_history
                order by delay ;
            topDelay   delay_cur%ROWTYPE;
  
        BEGIN
            OPEN delay_cur;
            Htp.p('<div class="delay-container">');
                FETCH delay_cur INTO topDelay;
                Htp.p('<h1>' || -1*trunc(topDelay.delay) || ' Min.</h1>');
            CLOSE delay_cur;
            Htp.p('</div>');
        END;


        </copy>
        ```


    At the end, you shoud have the Dashboard page like this:
    ![Full Width Final](images/full-width-final1.png)

    click on run button and you should see:
    ![Full Width Run](images/full-wdth-run-1.png)

## Task 5: Customize charts 
1. Now we are going to customized the four regions under **Components**/**Body** page structure, already generated by default with process shown so far. 

2. Select **OrderId** region, then on the right pane, under **Identification**/**Title**, change: **Orderid** with **Orders number by Zip Code**. At the end, select tab **Attributes**: 
![Order by zip code](images/orders-by-zipcode-1.png)

    * Select **Pie** under **Chart**/**Type**:

        ![Select Pie](images/select-pie-1.png)

    * Select **Series 1** under **Body**/**Orders number by Zip Code**:

        ![Select Series1 Zip ](images/series1-zip-1.png)

    * Copy in **Series** tab, under **Source**/**SQL Query** on right pane:

        ```
        <copy>
        
        select count(DISTINCT (TO_CHAR( date_, 'MM/DD' ) || ' ord:' || orderid)) ord_n_zip, deliveryzip from order_history group by deliveryzip;
        
        </copy>
        ```
    * Under **Column Mapping**, set **Label** as **DELIVERYZIP** and **Value** as **ORD**\_**N**\_**ZIP** :

        ![Select Series 1 SQL ](images/series1-sql-zip-1.png)

    * Finally, select from right pane **Orders number by Zip Code** component and **Region** under **Appearence**/**Template Options**, set these values for parameters:
        * **General**: **Show Maximize Button**
        * **Body Height**: **Auto - Default**
        * **Accent**: **Accent 1**
        * **Body Overflow**: **Scroll - Default**
        * **Item Width**: **Stretch Form Fields**

            ![Select Appearance Zip ](images/appearance1-1.png)


3. Select **Itemid** region, then on the right pane, under **Identification**/**Title**, change: **Itemid** with **Top Dishes**. At the end, select tab **Attributes**. 

    * Select **Combination** under **Chart**/**Type**:

        ![Select Combination](images/select-combination-1.png)

    * Select **Series 1** under **Body**/**Top Dishes**, and set **Name** with **Series 2**

    * Copy in **Series** tab, under **Source**/**SQL Query** on right pane:

        ```
        <copy>
        
        select ITEM_NAME,sum(ITEMCOUNT) dish_num
        from ORDER_HISTORY
        group by ITEM_NAME
        order by 2 desc
        
        </copy>
        ```
    * Under **Column Mapping**, set **Label** as **ITEM_NAME** and **Value** as **dish**\_**num** :

        ![Select Series1 SQL ](images/dish-num-1.png)

    * Finally, select from right pane **Top Dishes** component and under **Appearance**/**Template Options**, set these values for parameters:
        * **Body Height**: **Auto - Default**
        * **Accent**: **Accent 4**
        * **Body Overflow**: **Scroll - Default**
        * **Item Width**: **Stretch Form Fields**

            ![Templeate options 2 ](images/appearance2-1.png)


4. Select **Item Name** region, then on the right pane, under **Identification**/**Title**, change: **Item Name** with **Busiest Hours**. At the end, select tab **Attributes**.

    * Select **Series 1** under **Body** / **Busiest Hours**, and set **Name** with **Series 3**

    * Copy in **Series** tab, under **Source** / **SQL Query** on right pane:

        ```
        <copy>
        
        with orders_by_day as
        (select count(distinct orderid) orders,date_  order_day,to_char(orderreceivedtime,'HH24') order_hour from order_history
        group by date_,to_char(orderreceivedtime,'HH24'))
        select avg(orders) avg_order ,order_hour from orders_by_day
        --where rownum < 2
        group by order_hour
        order by avg_order desc
        
        </copy>
        ```
    * Under **Column Mapping**, set **Label** as **ORDER_HOUR** and **Value** as **AVG**\_**ORDER** :

        ![Select Series1 SQL ](images/ord-hours-1.png)

    * Finally,select from right pane **Busiest Hours** component under **Appearence**/**Template Options**, set these values for parameters:
        * **Body Height**: **Auto - Default**
        * **Accent**: **Accent 8**
        * **Body Overflow**: **Scroll - Default**
    

5. Select **Item Price** region, then on the right pane, under **Identification**/**Title**, change: **Item Price** with **Late Deliveries**. At the end, select tab **Attributes**.

    * Select **Series 1** under **Body** / **Late Deliveries**, and set **Name** with **Series 4**

    * Copy in **Series** tab, under **Source** / **SQL Query** on right pane:

        ```
        <copy>
        
        SELECT DISTINCT (TO_CHAR( date_, 'MM/DD' ) || ' ord:' || orderid) order_code ,actualdeliverytime , date_,
        promisedtime,-1*((promisedtime - actualdeliverytime) * 1440) delay
        from order_history
        order by date_ ;
        
        </copy>
        ```
    * Under **Column Mapping**, set **Label** as **ORDER_CODE** and **Value** as **DELAY**:

        ![Select Series4 SQL ](images/delay-1.png)

    * Under **Attributes** tabs, **Appearance** / **Orientation**, choose **Horizontal**:

      ![Select Series 4 SQL ](images/appearance4-1.png)

    * Finally, select from right pane **Late Deliveries** component under **Appearence**/**Template Options**, set these values for parameters:
        * **Body Height**: **Auto - Default**
        * **Accent**: **Accent 15**
        * **Body Overflow**: **Scroll - Default**

            ![Appearence  ](images/appearance4-1-1.png)
    
5. Run the application and you should see the Dashboard complete:

![Dashboard Final ](images/dashboard-final-1.png)


You may now proceed to the next lab.


## Learn More

* Ask for help and connect with developers on the [Oracle DB Microservices Slack Channel](https://bit.ly/oracle-database-microservices-slack)  
Search for and join the `oracle-db-microservices` channel.


## Acknowledgements
* **Author** - Paul Parkinson, Developer Evangelist;
               Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata;
               Corrado De Bari, Developer Evangelist
* **Adapted for Cloud by** - Nenad Jovicic, Enterprise Strategist, North America Technology Enterprise Architect Solution Engineering Team
* **Documentation** - Lisa Jamen, User Assistance Developer - Helidon
* **Contributors** - Jaden McElvey, Technical Lead - Oracle LiveLabs Intern
* **Last Updated By/Date** - Kamryn Vinson, June 2022
