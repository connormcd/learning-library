# How can I connect Oracle Virtual DB System and SQL Developer using SSH tunneling?

Duration: 10 minutes

This sprint demonstrates connecting to a 21c DB System instance from SQL Developer using SSH tunneling. However, this should work with the 19c DB System instance and DB's running in DBCS as well. We assume that you must have provisioned a Virtual DB system and have SSH keys created in your local machine.

## Connect to a Oracle Virtual DB System from SQL Developer using SSH tunneling

### Gather DB System Details

1. On the Oracle home page, click on the hamburger menu and click on **Bare Metal, VM and Exadata**.

    ![On the Oracle home page, click on the hamburger menu and click on Bare Metal, VM and Exadata](./images/vm.png " ")

2. Choose your compartment and click on your DB system.

    ![Choose your compartment and click on your DB system.](./images/db.png " ")

3. On the DB System Information of your DB VM instance, make note of the **Host Domain Name**.

    ![On the DB System Information of your DB VM instance, make note of the Host Domain Name](./images/host-domain-name.png " ")

4. Click on **Databases** under Resources and copy the **Database Unique Name** of your database.

    ![Click on Databases under Resources and copy the Database Unique Name of your database](./images/db-unique-name.png " ")

5. The concatenated string of your Database Unique Name followed by Host Domain Name is the **Service Name**.

    **Service Name**:
    ```
    Unique Name.Host Domain Name
    ```

    For example, service name looks like this *`cdb1_example.sub01150011500.examplevcn.oraclevcn.com`* is the service name.

6. Click on **Nodes** under Resources and make note of the **Public IP Address** and **Private IP** of your DB system.

    ![Click on Nodes under Resources and make note of the Public IP Address and Private IP of your DB system](./images/ipaddress.png " ")

### Create a New SSH Host in SQL Developer

1. Open SQL Developer, click on **View**, and select **SSH** from the drop-down list.

    ![Open SQL Developer, click on View, and select **SSH** from the drop-down list](./images/view.png " ")

2. Now you can see the SSH Hosts on the left pane. Right-click on **SSH Hosts** and click on **New SSH Host**.

    ![On the left pane, right-click on SSH Hosts and click on New SSH Host](./images/new-host.png " ")

3. On the New SSH Host dialog box, provide the below details and click **OK**.

    * **Name:** Give your SSH host a name. In this example, it is **db21c**.
    * **Host:** Provide the **Public IP address** of the DB system noted earlier in step 1.
    * **Port:** Leave the value default to **22**.
    * **Username:** **opc**
    * **Use key file:** Select the use key file checkbox and browse the Private key of your local machine. If you don't have ssh keys created in your machine, click [here](https://raw.githubusercontent.com/oracle/learning-library/master/common/labs/generate-ssh-key/generate-ssh-keys.md) for instructions to create SSH keys.
    * **Add a Local Port Forward:** Select the Add a Local Port Forward checkbox.
    * **Name:** Give a name to the local port forwarding of your SSH Host. In this example, it is db21c.
    * **Port:** Leave the value default to **1521**.
    * **Host:** Provide the **Private IP address** of the DB system noted earlier in step 1.
    * **Automatically assign local port:** To assign the local port automatically, select this default radio button. In this example, we are using the default.
    * **Use specific local port:** Select this radio button if you want to use a specific local port and specify the port number.

    ![On the New SSH Host dialog box, provide the details](./images/ssh-host.png " ")

4. Now you can see that `db21c ssh host` is created in the SSH hosts pane. Click on the `+` symbol of the db21c ssh host to drill down and notice that `db21c local port forward` is also created.

    ![View the db21c ssh host created in the SSH hosts pane](./images/expand.png " ")
    ![Click on the plus symbol of the db21c ssh host to drill down to view that db21c local port forward is also created](./images/expand2.png " ")

5. To connect to ssh host, right-click on `db21c ssh host` and click **connect**.

    ![Right-click on db21c ssh host and click connect](./images/connect-ssh-host.png " ")

6. To check if `db21c ssh host` is connected, right-click on it and notice that `connect` is disabled i.e., the db21c ssh host is connected.

    ![Right-click on db21c ssh host and notice that connect is disabled which means db21c ssh host is connected](./images/connect-ssh-host2.png " ")

7. To establish local port forwarding, right-click on `db21c local port forward` and click **connect**.

    ![To establish local port forwarding, right-click on db21c local port forward and click connect](./images/connect-ssh.png " ")

8. To check if `db21c local port forward` is connected, right-click on it and notice that `connect` is disabled i.e., db21c local port forward is connected.

    ![Right-click on db21c local port forward and notice that connect is disabled which means db21c local port forward is connected](./images/connect-ssh2.png " ")

### Create a New Database Connection in SQL Developer

1. Once you have successfully created the new SSH host connection, click on the green `+` on the top left corner of the window to create a new database connection.

    ![Click on the green plus on the top left corner of the window to create a new database connection](./images/new-connection.png " ")

2. On the New Database Connection dialog box, click on **Connection Type** drop-down and choose **SSH**.

    ![Click on Connection Type drop-down and choose SSH](./images/choose-ssh.png " ")

3. Now create a new database connection using SSH tunneling by providing the below details and click **Test**.

    * **Name:** Give your database connection a name. In this example, **db21c** is the database connection name.
    * **Username:** **sys**
    * **Password:** Give the password that was used to create the DB system for the sys user.
    * **Role:** Click on the Role drop-down and select **SYSDBA** as the role for the sys user.
    * **Port Forward:** If there are multiple ssh hosts, choose the ssh host and local port forward you created earlier in step 2. In this example, db21c SSH host and db21c local port forward - **db21c(db21c)** is chosen.
    * **Service Name:** Choose the service name radio button and provide the **Service Name** i.e., the concatenated string of database unique name and host domain name that was noted earlier in step 1.

    ![Provide the details and click Test](./images/new-connection-details.png " ")

4. If the connection is successful, the status will be updated as "Status: Success". Then click **connect** to create the new database connection.

    ![If the connection is successful, the status will be updated as Status colon Success. Then click connect](./images/connect.png " ")

5. Once the database is connected, you can see your database under Oracle connections. In this example, the db21c database is created under Oracle connections.

    ![Once the database is connected, you can see your database under Oracle connections](./images/connected.png " ")

### Verify the Database Connection

1. To verify the new database connection, click on your database - db21c `+` symbol to drill-down and click on the `+` symbol before Tables to view the tables in the database.

    ![Click on your database db21c plus symbol to drill-down](./images/db-drill-down.png " ")

    ![Click on the plus symbol before Tables](./images/tables-drill-down.png " ")

    ![View the tables in the database](./images/view-tables.png " ")

2. To know your database name, copy and paste the query in the worksheet and click run statement button to run the query.

    ```
    <copy>select ora_database_name from dual;</copy>
    ```

    ![Copy and paste the query in the worksheet and click run statement button to run the query](./images/know-db-name.png " ")

You have successfully connected to a Oracle Virtual DB System from SQL Developer using SSH tunneling.