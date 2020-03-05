# okta-assume-role-action

This action uses okta cli assume role to login to AWS and outputs aws creds to be used latter on

## Inputs

Required:

### `OKTA_ORG`

### `OKTA_AWS_APP_URL`

### `OKTA_USERNAME`

### `OKTA_PASSWORD`

### `OKTA_AWS_ROLE_TO_ASSUME`

Optional:

### `OKTA_PROFILE`

### `OKTA_STS_DURATION`

### `OKTA_AWS_REGION`

## Outputs

### `aws_access_key_id`

### `aws_secret_access_key`

### `region`

### `aws_session_token`

### `aws_profile`

### `user_id`

### `account`

### `arn`

## Example usage

```yaml
uses: MGMDV-Orb/okta-assume-role-action@master
with:
  OKTA_ORG: ${{ secrets.OKTA_ORG }}
  OKTA_AWS_APP_URL: ${{ secrets.OKTA_AWS_APP_URL }}
  OKTA_USERNAME: ${{ secrets.OKTA_USERNAME }}
  OKTA_PASSWORD: ${{ secrets.OKTA_PASSWORD }}
  OKTA_AWS_ROLE_TO_ASSUME: ${{ secrets.OKTA_AWS_ROLE_TO_ASSUME }}
```
