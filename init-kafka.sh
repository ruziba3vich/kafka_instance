#!/bin/bash
echo "Waiting for Kafka to be ready..."
sleep 15

echo "Creating topics..."
jq -c '.[]' /topics.json | while read -r topic; do
  topic_name=$(echo "$topic" | jq -r '.name')
  partitions=$(echo "$topic" | jq -r '.partitions')
  replication_factor=$(echo "$topic" | jq -r '.replication_factor')

  echo "Creating topic: $topic_name"
  /usr/bin/kafka-topics.sh --create \
    --topic "$topic_name" \
    --partitions "$partitions" \
    --replication-factor "$replication_factor" \
    --if-not-exists \
    --bootstrap-server localhost:9092
done

echo "Topic creation script finished."
