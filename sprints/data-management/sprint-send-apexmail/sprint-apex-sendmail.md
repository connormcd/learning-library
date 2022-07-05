# How can I send mail from Oracle Apex?
Duration: 10 minutes

You can use the APEX\_MAIL package to send an email from an Oracle Application Express application. This package is built on top of the Oracle supplied UTL_SMTP package. Use APEX\_MAIL.SEND to send an outbound email message from your application

## Send Mail Procedure

**Login to Apex environment create and run the following procedure:**

 
```
<copy>
declare
    l_body      clob;
    l_body_html clob;
begin
    l_body := 'To view the content of this message, please use an HTML enabled mail client.' || utl_tcp.crlf;
 
    l_body_html := '<html><body>' || utl_tcp.crlf ||
                   '<p>Please confirm your order on the <a href="' ||
                   apex_mail.get_instance_url || 'f?p=100:10">Order Confirmation</a> page.</p>' || utl_tcp.crlf ||
                   '</body></html>'; 
    apex_mail.send (
        p_to        => 'mail.receiver@domain.com',   -- change to your email address
        p_from      => 'mail.sender@domain.com', -- change to a real senders email address
        p_body      => l_body,
        p_body_html => l_body_html,
        p_subj      => 'Order Confirmation' );
end;
</copy>
```
 

## Learn More
* [Apex Mail](https://docs.oracle.com/database/121/AEAPI/apex_mail.htm)
