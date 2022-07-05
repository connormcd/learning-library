# How can I load data from local files to my Oracle ADB instance using Database Tools?

Let's explore how to load data from spreadsheets stored on your local computer into an Oracle Autonomous Database instance using Data Tools.

Duration: 5 minutes

## Load data from local files to your Oracle ADB instance using Data Tools

1. On the Oracle Cloud Console, make sure you are in the region where your ADB instance is provisioned. Click the navigation menu, search **Oracle Database**, and click on **Autonomous Database**.

2. From the compartment drop-down menu, select the **Compartment** where your Oracle Autonomous Database resource is provisioned. If there were a long list of databases, you could filter the list by the **State** of the databases, and sort by **Workload Type**.

3. From the databases displayed, click **Display Name** of the database you wish to add a cloud storage connection to navigate to the **Details** page of your Autonomous Database and click the **Database Actions** button.

4. In the Database Action login form, enter your username and click **Next**. On the next form, enter the password for the user.

5. On the Database Actions launchpad page, under Data Tools, click the **DATA LOAD** card.

6. On the Data Load main page, under "What do you want to do with your data?" click **LOAD DATA**, and under "Where is your data?" choose **LOCAL FILE**, then click **Next**.

7. **Drag and drop** the files you want to load or click on **Select Files** to choose files to load into the ADB instance.

8. Click the pencil icon on the right side of the card to inspect the data loading properties.

9. Add load data from the local file dialog box will appear on the right-hand side of your browser window. There are links for Settings, File, Table, and an Error Log in the bar on the left. Observe that this shows the structural information and intelligent default values created by the data wizard simply looking at the file. On the **Settings** tab view, for a table, view or modify the below settings:

    - **Option:** The default option to **Create Table** from the source is chosen
    - **Name:** Update the name of the table if needed.
    - **Properties:** Update the properties as required. Choose the **Field delimiter** from the drop-down depending on the data in the file. Most CSV files contain structural information about the data within the file in the first row. Update the number of **Rows to skip** if needed. Notice that a tick box is selected, **Get from file header**.
    - **Mapping:** Under Mapping, notice the data loader derived the column names and data types from the file contents, update or modify the datatypes as needed.

10. Click **Close** after updating the details. If you have more files to load, repeat steps 7 to 10.

11. When you are ready to load the tables into the database, click the Play button to run the data load job. On the Run Data Load Job dialog box, click **Run**. The time to load each file depends on factors including file size and network speed. The progress of the job can be monitored from the status bar and the ring to the left of each job card. When the ring is complete, the file has been uploaded successfully.

12. Check that all the data load cards have green tick marks, indicating that the data load tasks have been completed successfully.

13. To inspect the table(s) that were automatically created during the data load process, click on a tile where you wish to view the data. The load data from the local file dialog box will appear on the right-hand side of your browser window. Select the **Table** tab in the left-hand side listing. You will see the data from the source. Then, click **Close** to dismiss the dialog.

Congratulations! In a few clicks, you were able to load data into your new tables without having to write any SQL code. It was all done with a few mouse clicks.

## Learn More

- [Data Loading](https://docs.oracle.com/en/database/oracle/sql-developer-web/sdwad/data-load.html#GUID-E810061A-42B3-485F-92B8-3B872D790D85)
