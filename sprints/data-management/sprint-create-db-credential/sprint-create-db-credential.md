# How can I create a database credential for an OCI User?
Duration: 5 minutes

To access data in the Object Store, you have to enable your database user to authenticate itself with the Object Store using your OCI object store account and Auth Token. You do this by creating a private CREDENTIAL object for your user that stores this information encrypted in your ADB.

## Creating database credentials

Connected as your ADMIN user in Oracle SQL Developer Web, copy and paste this code snippet to an Oracle SQL Developer Web worksheet. Run the script.

**Note**:

Be sure that you keep the single quotes!

```
<copy>
set define off
begin
  DBMS_CLOUD.create_credential(
    credential_name => 'OBJ_STORE_CRED',
    username => '<Username>',
    password => '<Auth Token>'
  );
end;
/
set define on
</copy>
```
where
- username - Replace <Username> with the OCI Username
- password - Replace <Auth Token> with the OCI Object Store Auth Token you generated

**Note:**
This credential information is only usable for your user schema.

