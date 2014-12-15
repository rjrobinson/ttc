
FROM rjrobinson/ttc

# Install Ruby.
RUN \
apt-get update && \
apt-get install -y ruby ruby-dev && \
rm -rf /var/lib/apt/lists/*

RUN gem install bundler

# Define working directory.
WORKDIR /data

# Define default command.
CMD ruby client.rb
