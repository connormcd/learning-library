# How can I add autocompletion to OCI CLI?
Duration: 2 minutes

## Adding autocompletion to OCI CLI

The following command allows you to add autocompletion for commands and parameters when using OCI CLI in your terminal application of choice.
Run the following command in your terminal:

```
<copy>
oci setup autocomplete
</copy>
```

The interactive script will guide you through the configuration. In case the script is not able to find a suitable .profile file, you can provide your own, for example ```.zshrc``` or ```.bashrc```.

Once configuration is completed restart your terminal (or source your .profile). Now you can use autocompletion with OCI CLI.

Try entering:
```oci <space><tab><tab>``` and you should see every possible parameter.

## Learn More

* [OCI CLI Command Reference](https://docs.oracle.com/en-us/iaas/tools/oci-cli/2.9.5/oci_cli_docs/index.html)
