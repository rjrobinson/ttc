
FROM rjrobinson/ttc

# Install Ruby.
RUN \
apt-get update && \
apt-get install -y ruby ruby-dev && \
rm -rf /var/lib/apt/lists/*

RUN gem install bundler

ADD client.rb /
ADD Gemfile /

# Define working directory.
WORKDIR /

# Define default command.
CMD bundle install && ruby client.rb
