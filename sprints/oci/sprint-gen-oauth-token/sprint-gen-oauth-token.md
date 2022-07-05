# How can I create an OCI Auth Token?
Duration: 1 minute

To load data from the OCI Object Storage, you will need an OCI user with the appropriate privileges to read data (or upload) data to the Object Store.

## Creating an OCI Authentication Token

* In your OCI Console, click on the person icon at the far upper right. From the drop-down menu, select your user’s name (remember this user name could also be an email).

  **Note**:
  If you don’t see your user name in the drop-down menu, you might be a “federated” user. In that case, go instead to the menu on the left side and open Users. Federated users are “federated” from another user service.

* Click the user’s name to view the details. Also, remember the user name as you will need that in the next step. This username could also be an email address.
* On the left side of the page, click Auth Tokens.

* Click Generate Token.

  ![Click generate token](images/task2-img4.png "Click on generate token")

* Enter a meaningful description for the token and click Generate Token.

* The new Auth Token is displayed. Click Copy to copy the Auth Token to the clipboard. Save the contents of the clipboard in your text notepad file as you will need it later. Click Close to close the Generate Token dialog.

  **Note**:
  You can’t retrieve the Auth Token again after closing the dialog box. So make sure you save it before closing the window.
