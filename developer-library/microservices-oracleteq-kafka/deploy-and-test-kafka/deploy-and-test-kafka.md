# Build Event-driven microservices with Spring Boot and Apache Kafka

## Introduction

This laboratory helps you know how to build an Event-driven architecture based on Spring Boot microservices that “communicate” asynchronously using Apache Kafka. The laboratory have two microservices, a producer and a consumer, built using Spring Boot framework that connect with an Apache Kafka broker to exchange events.

Estimated Time: 10 minutes

### Objectives

- Deploy and access the Kafka Cluster
- Deploy and access the Kafka Producer Microservice
- Deploy and access the Kafka Consumer Microservice
- Learn how they work

### Prerequisites

- *[Optional]* An Oracle Cloud paid account or free trial. To sign up for a trial account with $300 in credits for 30 days, click [Sign Up](http://oracle.com/cloud/free).
- A Docker Engine accessible.

## **Task 1:** Run Kafka Broker and Create a Topic

1. Execute the following commands to start the Kafka cluster and connect Broker to Lab8022 Network:

    ```bash
    <copy>
    cd $LAB_HOME/cloud-setup/confluent-kafka
    </copy>
    ```

    ```bash
    <copy>
    ./docker-compose up -d
    </copy>
    ```

    ```bash
    <copy>
    docker network connect lab8022network broker
    </copy>
    ```

2. Once successfully executed, check that the services are running executing the follwing commands:

    ```bash
    <copy>
    cd $LAB_HOME/cloud-setup/confluent-kafka
    </copy>
    ```

    ```bash
    <copy>
    ./docker-compose ps
    </copy>
    ```

    First, you will see the four containers running, but the container from Connect Service will be *starting*
    ![Kafka Cluster Services Running with Connect starting](images/kafka-platform-containers-status-starting.png)

    After a few seconds, the container from Connect Service will be *healthy*
    ![Kafka Cluster Services Running with Connect starting](images/kafka-platform-containers-status-healthy.png)

    > **Note:** If your cloud shell connection interrupt during the process, may you will have to reconnect and executing the instructions from [Task 5](#task5restartkafkacomponentsoptional).

3. Create a Topic:

    You are ready to create the topic *LAB8022_TOPIC*. Run the following command to create a new topic into the Kafka Broker:

    ```bash
    <copy>
    docker exec broker \
    kafka-topics --bootstrap-server broker:9092 \
    --create \
    --topic LAB8022_TOPIC
    </copy>
    ```

    After a *WARNING* message that you can disregard, you will see the message **"Created topic LAB8022_TOPIC."**

## **Task 2:** Verify configurations and build applications

The Kafka Producer and Consumer adopt Spring Boot and Spring Kafka frameworks. The Producer exposes a REST service that will produce a message and publish it in the Kafka Broker created. And on the other side, the Consumer will subscribe to the same topic and consume messages—a straightforward and typical case but instructive and essential when compared with the next lab.

This workshop makes the source codes of the two microservices available; We invite you to investigate the code to familiarize yourself with Spring Boot and how it connects with Apache Kafka, which allows for asynchronous communication between microservices. After this navigation, you must confirm the microservices settings present in a properties file, following microservices [External Configuration Pattern](https://microservices.io/patterns/externalized-configuration.html) and also the third factor of [Twelve Factor Methodology](https://12factor.net).

1. Review Producer microservices properties

    You have to review the Producer microservice properties to confirm connecting with the right Apache Kafka Broker and Topic. Remember that both were configured during workshop setup tasks, and Kafka Broker runs at address Broker:9092. But, as we are working on the Docker engine from the Cloud Shell environment, Kafka broker is advertised for other nodes on port 29092.

    To verify the producer configuration, you can execute the follow command:

    ```bash
    <copy>cat $LAB_HOME/springboot-kafka/kafka-producer/src/main/resources/application.yaml</copy>
    ```

    The proper configuration should be:

    - bootstrap-servers: broker:29092
    - topic-name: LAB8022_TOPIC

    ![Spring Boot Producer App Configuration](images/springboot-kafka-config.png " ")

2. Review the Consumer Configurations

    Following the same concepts and practices of Producer, Consumer microservice has its configuration externalized and should point to the right Apache Kafka broker that Producer is connected. The following command allows you to list the contents of Consumer properties.

    ```bash
    <copy>cat $LAB_HOME/springboot-kafka/kafka-consumer/src/main/resources/application.yaml</copy>
    ```

    And, likewise in the Producer case, the Consumer should point to the above bootstrap servers and topic.

    > **Note:** If you change these configurations, you will have to modify these parameters.

3. Build the Applications

    Once you have confirmed that all configuration is correct, you have to build the microservices. To facilitate it, the workshop We use Maven to build the applications Producer and Consumer and the configuration module. Run the following commands to build both projects:

    ```bash
    <copy>cd $LAB_HOME/springboot-kafka</copy>
    ```

    ```bash
    <copy>mvn clean install -DskipTests</copy>
    ```

    As a result, all modules were built with success.

    ![Spring Boot Apps Build result](images/springboot-kafka-build-result.png " ")

## **Task 3:** Deploy and Test Spring Boot Kafka Producer

1. Deploy Kafka Producer Microservice

    Now that we have the applications successfully built, we can deploy them and test them. Let's start with the Producer. Run these commands to build the image and deploy the Producer inside the Docker Engine (the same running the Kafka Cluster):

    ```bash
    <copy>cd $LAB_HOME/springboot-kafka/kafka-producer</copy>
    ```

    ```bash
    <copy>./build.sh</copy>
    ```

    Now, let's run the Producer:

    ```bash
    <copy>
    docker run --detach --name=kafka-producer --network lab8022network -p 8080:8080 oracle-developers-kafka-producer:0.0.1-SNAPSHOT
    </copy>
    ```

    We can check the logs and see the Producer running and waiting for requests:

    ```bash
    <copy>
    docker logs kafka-producer
    </copy>
    ```

    ![Spring Boot Kafka Producer Running Logs](images/springboot-kafka-producer-running.png " ")

2. Test Kafka Producer Microservice

    We will use the cURL command to test our Producer.

    ```bash
    <copy>
    curl -X POST -H "Content-Type: application/json" \
    -d '{ "id": "id1", "message": "message1" } ' \
    http://localhost:8080/placeMessage | jq
    </copy>
    ```

    The result should be

    ```bash
    {
        "id": "0",
        "statusMessage": "Successful"
    }
    ```

    We also can validate if the message was published inside topic LAB8022_TOPIC.

    ```bash
    <copy>
    docker exec --interactive --tty broker \
    kafka-console-consumer --bootstrap-server broker:9092 \
    --topic LAB8022_TOPIC \
    --from-beginning
    </copy>
    ```

    The result will be similar to :

    ![Kafka Consumer inside Docker](images/kafka-consumer-docker.png " ")

    You will need to press Crtl+C to stop this process.

## **Task 4:** Deploy and Test Spring Boot Kafka Consumer

Now that we have Producer running and publishing events inside the Kafka Broker, you will do the same with Consumer.

1. Deploy Kafka Consumer Microservice

    We will follow the same steps to deploy and test the Kafka Consumer microservice. Run these commands to build the image and deploy the Consumer inside the Docker Engine (the same running the Kafka Cluster):

    ```bash
    <copy>cd $LAB_HOME/springboot-kafka/kafka-consumer</copy>
    ```

    ```bash
    <copy>./build.sh</copy>
    ```

    Now, let's run the Consumer :

    ```bash
    <copy>
    docker run --detach --name=kafka-consumer --network lab8022network oracle-developers-kafka-consumer:0.0.1-SNAPSHOT
    </copy>
    ```

    We can check the logs and see the Consumer running:

    ```bash
    <copy>
    docker logs kafka-consumer
    </copy>
    ```

    ![Spring Boot Kafka Consumer Running Logs](images/springboot-kafka-consumer-running.png " ")

    And finally, We can now produce and consume messages from Kafka Broker; the result inside logs of Consumer will be:

    ![Spring Boot Kafka Consumer Running Logs](images/springboot-kafka-consumer-test.png " ")

## **Task 5:** Restart Kafka Components (optional)

You session of cloud shell may expire or disconnect during the process [bellow image] thus you will have to check if the Kafka components are still running and if not restart them following the next commands:

![Cloud Shell disconnection message](images/cloud-shell-disconnection-message.png " ")

1. Setup environment.

    After reconnect you have to setup environment running the following command:

    ```bash
    <copy>
    source $LAB_HOME/cloud-setup/env.sh
    </copy>
    ```

2. Check if Kafka components are running.

    Execute the following command to check if Kafka Components are running:

    ```bash
    <copy>
    cd $LAB_HOME/cloud-setup/confluent-kafka
    </copy>
    ```

    ```bash
    <copy>
    ./docker-compose ps
    </copy>
    ```

    You should see the four containers running
    ![Kafka Cluster Services Running with Connect starting](images/kafka-platform-containers-status-healthy.png)

3. Restart components

    If they are not running like bellow image, execute again [Task 1](#task1runkafkabrokerandcreateatopic).

    ![Kafka Cluster Services exist 1](images/kafka-platform-containers-status-exit.png)

You may now **proceed to the next lab**

## Acknowledgements

- **Authors** - Paulo Simoes, Developer Evangelist; Paul Parkinson, Developer Evangelist; Richard Exley, Consulting Member of Technical Staff, Oracle MAA and Exadata
- **Contributors** - Mayank Tayal, Developer Evangelist; Sanjay Goil, VP Microservices and Oracle Database
- **Last Updated By/Date** - Paulo Simoes, March 2022
