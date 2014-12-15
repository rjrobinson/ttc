
FROM dockerfile/ubuntu

# Install Ruby.
RUN \
apt-get update && \
apt-get install -y ruby ruby-dev ruby-bundler && \
rm -rf /var/lib/apt/lists/*
gem install bundler
bundle exec install


# Define working directory.
WORKDIR /

# Define default command.
CMD ["bash"]
