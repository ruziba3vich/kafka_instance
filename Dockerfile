FROM confluentinc/cp-kafka:7.4.0
RUN apt-get update && apt-get install -y jq && rm -rf /var/lib/apt/lists/*
