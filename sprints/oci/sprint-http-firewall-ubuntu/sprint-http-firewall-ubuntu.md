# How can I allow incoming http traffic (port 80) on an Ubuntu instance?
Duration: 5 minutes

## Update iptables

You need to update your iptables configuration to allow HTTP traffic. 
Update <code>iptables</code> with the following commands.

```
<copy>
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 80 -j ACCEPT
sudo netfilter-persistent save
</copy>
```

## Learn More

* [Example: Install PHP and Apache on Ubuntu in OCI](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/apache-on-ubuntu/01oci-ubuntu-apache-summary.htm)
* [Networking Documentation](https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/overview.htm)

