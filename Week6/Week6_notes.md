# KAFKA

## What is Kafka?
- Open-source distributed event streaming platform
- Acts as message broker in between consumers & producers (of data)

### Messages in Kafka
- Data that is pushed to Kafka are called as Messages
- Consist generally of 3 components
  -- Keys
  -- Value
  -- Timestamp

### Topic in Kafka
- Kafka is a distributed event streaming platform that lets you read, write, store, and process events (also called records or messages in the documentation) 
across many machines.
- Example events are payment transactions, geolocation updates from mobile phones, shipping orders, sensor measurements from IoT devices or medical equipment, 
and much more. These events are organized and stored in **_topics_**. Very simplified, a **_topic_** is similar to a folder in a filesystem, and the events are 
the files in that folder.

### Kafka Broker
- Is a physical machine on which Kafka is running
- Kafka Cluster is when multiple Kafka brokers are working together.

### Kafka Logs
- Helps store data in orderly fashion by assigning sequence ids to each message before storing them in Kafka

