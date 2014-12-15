
FROM rjrobinson/ttc

# Install Ruby.
RUN \
apt-get update && \
apt-get install -y ruby ruby-dev ruby-bundler && \
rm -rf /var/lib/apt/lists/*

# Define working directory.
WORKDIR /

# Define default command.
CMD ruby client.rb
