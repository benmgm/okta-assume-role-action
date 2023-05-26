FROM openjdk:8
COPY entrypoint.sh /entrypoint.sh
SHELL ["bash", "-c"]
RUN apt-get update && apt-get install --no-install-recommends -y curl awscli jq && rm -rf /var/lib/apt/lists/*
RUN PREFIX="/okta" releaseTag="v3.0.0" bash <(curl -fsSL https://raw.githubusercontent.com/oktadeveloper/okta-aws-cli-assume-role/dedd2ab/bin/install.sh | grep -v "^releaseTag") -i
ENTRYPOINT ["/entrypoint.sh"]