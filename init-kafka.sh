#!/bin/bash
echo "Waiting for Kafka to be ready..."
sleep 10
kafka-topics.sh --create --topic user.notifications --bootstrap-server kafka:9092 --partitions 1 --replication-factor 1 --if-not-exists
echo "Topic 'user.notifications' created or already exists."
