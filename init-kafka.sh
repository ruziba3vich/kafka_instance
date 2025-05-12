#!/bin/bash
echo "Waiting for Kafka to be ready..."
sleep 10

if [ ! -f /topics.json ]; then
  echo "Error: topics.json not found"
  exit 1
fi

jq -c '.[]' /topics.json | while read -r topic; do
  name=$(echo "$topic" | jq -r '.name')
  partitions=$(echo "$topic" | jq -r '.partitions')
  replication_factor=$(echo "$topic" | jq -r '.replication_factor')
  
  echo "Creating topic: $name with $partitions partitions and replication factor $replication_factor"
  kafka-topics.sh --create \
    --topic "$name" \
    --bootstrap-server kafka:9092 \
    --partitions "$partitions" \
    --replication-factor "$replication_factor" \
    --if-not-exists
  if [ $? -eq 0 ]; then
    echo "Topic '$name' created or already exists"
  else
    echo "Failed to create topic '$name'"
  fi
done

echo "Topic creation completed"
