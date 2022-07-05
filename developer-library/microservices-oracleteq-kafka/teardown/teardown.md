# Teardown

## Introduction

In this lab, we will tear down the resources created in your tenancy and the directory in the Oracle cloud shell.

Estimates Time: 10 minutes

### Objectives

- Clean up your tenancy

### Prerequisites

- Have successfully completed the earlier labs

## **Task 1:** Delete the Workshop Resources

1. Run the following command to delete the resources created in you tenancy. It will delete all resources except the compartment.

    It will take some minutes to finish. The script will delete the GraalVM installation, the Object Storage bucket and the Oracle Autonomous Database.

    ```bash
        <copy>
        source $LAB_HOME/cloud-setup/destroy.sh
        </copy>
    ```

    In shell, it will print the following lines

    ```bash
    Executing java/graalvm-uninstall.sh in the background
    Executing objstore-destroy.sh in the background
    Executing terraform-destroy.sh in the background
    ```

2. Check Destroy script logs

    The following command help you check the object store deletion.

    ```bash
    $ cat $LAB_LOG/objstore-destroy.log 
    Deleting Object Store
    ```

    The following command show the terraform destroy command result.

    ```bash
    $ cat $LAB_LOG/terraform-destroy.log 
    Running terraform destroy

    Initializing the backend...

    Initializing provider plugins...
    - Reusing previous version of hashicorp/oci from the dependency lock file
    - Reusing previous version of hashicorp/random from the dependency lock file
    - Using previously-installed hashicorp/oci v4.68.0

    ........

    Terraform used the selected providers to generate the following execution
    plan. Resource actions are indicated with the following symbols:
    - destroy

    Terraform will perform the following actions:

    # oci_database_autonomous_database.autonomous_database_atp will be destroyed

    ........

    Plan: 0 to add, 0 to change, 3 to destroy.
    random_string.autonomous_database_wallet_password: Destroying... [id=6[H_fZKsDX88A&tK]
    random_string.autonomous_database_wallet_password: Destruction complete after 0s
    oci_database_autonomous_database.autonomous_database_atp: Destroying... [id=ocid1.autonomousdatabase.oc1.iad.....m4iaq]

    .........

    oci_database_autonomous_database.autonomous_database_atp: Still destroying... [id=ocid1.autonomousdatabase.oc1.iad.....m4iaq, 1m50s elapsed]
    oci_database_autonomous_database.autonomous_database_atp: Destruction complete after 1m52s
    random_password.database_admin_password: Destroying... [id=none]
    random_password.database_admin_password: Destruction complete after 0s

    Destroy complete! Resources: 3 destroyed.

    ```

3. Clean **.bashrc** lab setup

    You should clean the Laboratory setup inside the .bashrc file. Use the following command to delete the lines for LiveLabs setup.

    ```shell
    <copy>
    vi ${HOME}/.bashrc
    </copy>
    ```

    Delete the following five lines:

    ```text
    # LiveLab Setup -- BEGIN
    export LAB_HOME=/home/......./lab8022/microservices-datadriven/workshops/oracleteq-kafka
    export JAVA_HOME=/home/......./graalvm-ce-java11-22.0.0.2
    export PATH=/home/......./graalvm-ce-java11-22.0.0.2/bin/:/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.322.b06-1.el7_9.x86_64/bin/:/opt/oracle/sqlcl/bin:/usr/lib/oracle/21/client64/bin/:/home/oci/.pyenv/plugins/pyenv-virtualenv/shims:/home/oci/.pyenv/shims:......f
    # LiveLab Setup -- END
    ```

4. Clean the Docker containers

    The lab deploys some containers referring to the Kafka platform and also to microservices. You have to cleanup the local registry. The following command you present the current Containers deployed.

    ```bash
    <copy>
    docker ps -a
    </copy>
    ```

    The expected result should be similar to the block below:

    ```shell
    CONTAINER ID        IMAGE                                              COMMAND                  ......              NAMES
    e8d6ede6d3ec        oracle-developers-okafka-consumer:0.0.1-SNAPSHOT   "/bin/sh -c 'java -j…"                       okafka-consumer
    54d708b65e18        oracle-developers-okafka-producer:0.0.1-SNAPSHOT   "/bin/sh -c 'java -j…"                       okafka-producer
    b4e44dbac202        oracle-developers-kafka-consumer:0.0.1-SNAPSHOT    "/bin/sh -c 'java -j…"                       kafka-consumer
    b191bfd26d29        oracle-developers-kafka-producer:0.0.1-SNAPSHOT    "/bin/sh -c 'java -j…"                       kafka-producer
    50c7386b4311        cp-kafka-connect-custom:0.1.0                      "/etc/confluent/dock…"                       connect
    983d7e1ff05a        confluentinc/cp-schema-registry:7.0.1              "/etc/confluent/dock…"                       schema-registry
    c11987be2134        confluentinc/cp-server:7.0.1                       "/etc/confluent/dock…"                       broker
    cf081b95ee67        confluentinc/cp-zookeeper:7.0.1                    "/etc/confluent/dock…"                       zookeeper
    ```

    If you want to clean up all Containers, you can run the following command:

    ```bash
    <copy>
    docker rm -f $(docker container ls -aq)
    </copy>
    ```

    >**Note:** The above command removes all containers, don't use it if you have other containers and don't want to delete them.

5. Clean the Docker images

    The lab container images have to be deleted from the local registry too. The following command you present the current images deployed.

    ```bash
    <copy>
    docker images
    </copy>
    ```

    The expected result should be similar to the block below:

    ```shell
    REPOSITORY                          TAG                 IMAGE ID
    oracle-developers-okafka-consumer   0.0.1-SNAPSHOT      ......
    oracle-developers-okafka-producer   0.0.1-SNAPSHOT      ......
    oracle-developers-kafka-consumer    0.0.1-SNAPSHOT      ......
    oracle-developers-kafka-producer    0.0.1-SNAPSHOT      ......
    cp-kafka-connect-custom             0.1.0               ......
    ghcr.io/graalvm/graalvm-ce          ol8-java11          ......
    confluentinc/cp-kafka-connect       7.0.1               ......
    confluentinc/cp-server              7.0.1               ......
    confluentinc/cp-schema-registry     7.0.1               ......
    confluentinc/cp-zookeeper           7.0.1               ......
    ```

    To clean the local repository removing all images you can use the following command:

    ```bash
    <copy>
    docker image prune --all
    </copy>
    ```

    >**Note:** The above command removes all images from your local Docker Repository.

## **Task 2:** Delete the Directory

1. Delete the directory in your cloud shell where you installed the workshop.

    ```bash
     <copy>rm -rf <directory name, e.g. lab8022></copy>
    ```

## **Task 3:** Delete the Compartment

In the Oracle Cloud Infraestructure Console navigate to the Compartments screen in the Identity section. Select the compartment that was created for the workshop and delete it. Important, even when the script in step 1 has completed, it can take some time for Oracle Cloud Infrastructure to fully remove all the resources. It will not be possible to delete the compartment until this has completed.

## Acknowledgements

- **Authors** - Paulo Simoes, Developer Evangelist; Paul Parkinson, Developer Evangelist; Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
- **Contributors** - Mayank Tayal, Developer Evangelist; Sanjay Goil, VP Microservices and Oracle Database
- **Last Updated By/Date** - Paulo Simoes, March 2022
