#!/bin/bash -l

HOME=/root
# mkdir -p ~/.okta/
# ln -s /okta ~/.okta

[[ ! -z "$INPUT_OKTA_ORG" ]] && echo "OKTA_ORG=$INPUT_OKTA_ORG" > ~/.okta/config.properties || exit 99
[[ ! -z "$INPUT_OKTA_AWS_APP_URL" ]] && echo "OKTA_AWS_APP_URL=$INPUT_OKTA_AWS_APP_URL" >> ~/.okta/config.properties || exit 100
[[ ! -z "$INPUT_OKTA_USERNAME" ]] && echo "OKTA_USERNAME=$INPUT_OKTA_USERNAME" >> ~/.okta/config.properties || exit 101
[[ ! -z "$INPUT_OKTA_PASSWORD" ]] && echo "OKTA_PASSWORD_CMD=/bin/echo $INPUT_OKTA_PASSWORD" >> ~/.okta/config.properties || exit 102
[[ ! -z "$INPUT_OKTA_AWS_ROLE_TO_ASSUME" ]] && echo "OKTA_AWS_ROLE_TO_ASSUME=$INPUT_OKTA_AWS_ROLE_TO_ASSUME" >> ~/.okta/config.properties || exit 103
[[ ! -z "$INPUT_OKTA_PROFILE" ]] && echo "OKTA_PROFILE=$INPUT_OKTA_PROFILE" >> ~/.okta/config.properties || echo "OKTA_PROFILE=default" >> ~/.okta/config.properties
[[ ! -z "$INPUT_OKTA_STS_DURATION" ]] && echo "OKTA_STS_DURATION=$INPUT_OKTA_STS_DURATION" >> ~/.okta/config.properties || echo "OKTA_STS_DURATION=3600" >> ~/.okta/config.properties
[[ ! -z "$INPUT_OKTA_AWS_REGION" ]] && echo "OKTA_AWS_REGION=$INPUT_OKTA_AWS_REGION" >> ~/.okta/config.properties || echo "OKTA_AWS_REGION=us-west-2" >> ~/.okta/config.properties
echo "OKTA_BROWSER_AUTH=false" >> ~/.okta/config.properties

result=$(PATH=/usr/local/openjdk-8/bin:$PATH java -jar /okta/okta-aws-cli.jar sts get-caller-identity)
# java -jar /okta/okta-aws-cli.jar sts get-caller-identity

user_id=$(echo $result | jq -r ".UserId")
account=$(echo $result | jq -r ".Account")
arn=$(echo $result | jq -r ".Arn")
aws_access_key_id=$(cat ~/.aws/credentials | grep aws_access_key_id | cut -d' ' -f 3)
aws_secret_access_key=$(cat ~/.aws/credentials | grep aws_secret_access_key | cut -d' ' -f 3)
region=$INPUT_OKTA_AWS_REGION
aws_session_token=$(cat ~/.aws/credentials | grep aws_session_token | cut -d' ' -f 3)
aws_profile=$INPUT_OKTA_PROFILE

echo "::add-mask::$aws_access_key_id"
echo "::add-mask::$aws_secret_access_key"
echo "::add-mask::$aws_session_token"

echo "the user id is $user_id"

run: echo "user_id=$user_id" >> $GITHUB_OUTPUT
run: echo "account=$account" >> $GITHUB_OUTPUT
run: echo "arn=$arn" >> $GITHUB_OUTPUT
run: echo "aws_access_key_id=$aws_access_key_id" >> $GITHUB_OUTPUT
run: echo "aws_secret_access_key=$aws_secret_access_key" >> $GITHUB_OUTPUT
run: echo "region=$region" >> $GITHUB_OUTPUT
run: echo "aws_session_token=$aws_session_token" >> $GITHUB_OUTPUT
run: echo "aws_profile=$aws_profile" >> $GITHUB_OUTPUT
echo $result
