# Add Navigation and Data

## Introduction

This lab shows you how to set up navigation between pages in a web app. It also shows how you can add data to the app.

Estimated Time: 10 minutes

### About this Lab
With your changes committed to a remote branch, you'll now create buttons that help users navigate between the Departments page and the Employees page in the web app. Each button is associated with an event that sets off a series of actions when you click it. In VB Studio, this sequence of actions is called an _action chain_. You can use and customize predefined actions, or define your own.

You'll also populate your business objects by importing data from a file. You did this for the Location business object in a previous lab, and you'll do the same for the Department and Employee business objects here.

### Objectives
In this lab, you will:
* Set up navigation between web pages
* Import data for your business objects

### Prerequisites

This lab assumes you have:
* A Chrome browser
* All previous labs successfully completed

## Task 1: Create an action chain to navigate from the Departments page to the Employees page

1.  Click **Workspaces**![Workspaces icon](images/vbs-workspaces-icon.png), then click **HR Visual Application** in the Workspaces table.
2.  Click **Web Applications** ![Web Applications icon](images/web-applications-icon.png), then **main-departments** under the hrwebapp and main nodes.
3.  In the Page Designer, click **Components** to open the Components palette. Then, drag a **Button** from the Common components to the Toolbar, to the right of the Create Department button on the main-departments page.

    ![](images/departments-button.png " ")

4.  If necessary, click **Properties**. Then in the General tab of the Properties pane, change the **Text** field to `Display Employees`.
5.  Select the button (if necessary) and click the **Events** tab, then click the **\+ New Event** button. From the menu, select **On 'ojAction'**, the default action for a button click.

    ![](images/departments-button-events.png " ")

    An action chain with the ID ButtonActionChain is created. It contains only the Start action.

6.  From the Navigation section of the Actions palette, drag the **Navigate** action to the **+** sign pointed to by the Start action.
7.  In the Navigate action's properties, select **main-employees** from the **Page** list.

    ![](images/departments-button-events-navigate.png)

    The action now has the label `Navigate main-employees`.

8.  Click **Preview** ![Preview icon](images/preview-icon.png) in the header to see how the pages will appear to the user. The application opens in another browser tab.
9.  Click **Create Department** and add another department (`IT` on `Floor 2`, for example), then click **Save**. A success message is displayed briefly.
10.  Click **Display Employees**, then click **Create Employee**. Add another employee, specifying the new department, and click **Save**. You'll notice there's no way to get back to the main-departments page from the main-employees page. Close the browser tab.


## Task 2: Create an action chain to navigate from the Employees page to the Departments page

1.  In the Web Apps pane, click **main-employees** under the hrwebapp and main nodes. If necessary, click **Reload page** ![Reload page icon](images/reload-icon.png) to display the new employee you created.
2.  In the Components palette, drag a **Button** component to the Toolbar, to the right of the Create Employee button.
3.  In the button's Properties pane, change the **Text** field to `Display Departments`.
4.  Select the button (if necessary) and click the **Events** tab, then click **+ New Event** and select **On 'ojAction'**.

    Another empty action chain with the ID ButtonActionChain is created. Because this action chain is for a different page, it doesn't matter that it has the same name as the one for the main-departments page.

5.  Drag the **Navigate** action from the Navigation section to the **+** sign pointed to by the Start action.
6.  In the Properties pane, select **main-departments** from the **Page** list.

    The action now has the label `Navigate main-departments`.

7.  Click **Preview** ![Preview icon](images/preview-icon.png) to test the pages and navigation. The application opens in another browser tab. Make sure you can get to the Departments page from the Employees page. Close the browser tab.
8.  Click **main**, then **Diagram** to view the application's modified page flow. Click the main-departments page to see two navigation icons (![Green navigation icon](images/diagram-navigation-icon-green.png) ![Black navigation icon](images/diagram-navigation-icon-black.png)) appear on the main-employees page, indicating that you can now navigate from  main-departments to main-employees and back.

    ![](images/page-flow.png " ")

## Task 3: Import data for the business objects

Let's now add data for the Department and Employee business objects. Instead of using the Data Manager to import data, this time you'll use each business object's Data tab to do the same thing.

1.  Click [this link](https://objectstorage.us-ashburn-1.oraclecloud.com/p/j1n-byE7426PGyqNj45YCdChr96rDHZ6QglebWEK0fFrs34_fiSV_BYlWMaLQszx/n/c4u03/b/oci-library/o/WMS7601-Department.csv) and save the `Department.csv` file to your file system. The file contains six departments for the application.

2.  Click [this link](https://objectstorage.us-ashburn-1.oraclecloud.com/p/VxjVFSn6YZBie6bD9l-JMYGwY5cZkBbiHb8z65AZAVVuI5s1hRKGx3dORVG6YM9M/n/c4u03/b/oci-library/o/WMS7601-Employee.csv) and save the `Employee.csv` file to your file system. The file contains nine employees for the application.

3.  In the navigator, click **Business Objects** ![Business Objects icon](images/bo-icon.png), then **Objects**. The business objects you created are displayed.

4.  Click **Department**, then **Data**.

5.  Click **Import from File** ![Import from File icon](images/import-icon.png).

6.  In the Import Data dialog box, select the **Replace** option if it's not already selected. Then click the upload box, browse to select the `Department.csv` file, and click **Import**.

   ![](images/department-data-import.png " ")

	Click **Close** after the file has been successfully imported. Six departments are displayed in the table.

	![](images/department-data-import-result.png " ")

7.  Click **Employee** under Business Objects, then click **Data**.

8.  Click **Import from File** ![Import from File icon](images/import-icon.png).

9.  In the Import Data dialog box, select the **Replace** option if it's not already selected. Then click the upload box, browse to select the `Employee.csv` file, and click **Import**.

   Click **Close** after the file has been successfully imported. Nine employees are displayed in the table.

	![](images/employees-data-import-result.png " ")

   You may **proceed to the next lab**.

## Acknowledgements
* **Created By/Date** - Sheryl Manoharan, VB Studio User Assistance, November 2021
<!--* **Last Updated By/Date** - October 2021 --!>
