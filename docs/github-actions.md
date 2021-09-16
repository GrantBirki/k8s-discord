# GitHub Actions

The following documents is a rough guide for setting up your cluster to be deployed with GitHub actions

Note: Due to race conditions, it is advisable (but not 100% required) to run the `make build` script locally first to deploy your project before integrating it with CICD. If you know what you are doing and are okay with a little a few hiccups on the first run, then you can just build it all from CICD on your first go. The hiccups mostly involve a Docker build attempting to push images to ACR before it has been created by the Terraform job that runs afterwards.

## Prerequisites

Terraform:

- Your **two** Terraform workspaces have been configured - [Terraform Docs](terraform-cloud.md)

GitHub Secrets:

This part is important for CI/CD to pass! You will need to configure the following GitHub secrets as `key` / `value` pairs

- Azure Credentials
  - Key: `AZURE_CREDENTIALS`
  - Value: (string of json below)

    ```json
    {"clientId": "<GUID>",
    "clientSecret": "<GUID>",
    "subscriptionId": "<GUID>",
    "tenantId": "<GUID>"}
    ```

    > Note: The formatting of the `AZURE_CREDENTIALS` json is important. See the [docs](https://github.com/marketplace/actions/azure-login)

- ACR Registry Server
  - Key: `REGISTRY_LOGIN_SERVER`
  - Value: `<example.azurecr.io>`

  > This is essentially a variable for the `deployment.yml` action and is not *really* a secret

- ACR Registry Username
  - Key: `REGISTRY_USERNAME`
  - Value: `<username>`

  > See the [docs](https://github.com/marketplace/actions/azure-container-registry-login) for more info

- ACR Registry Password
  - Key: `REGISTRY_PASSWORD`
  - Value: `<password>`

  > See the [docs](https://github.com/marketplace/actions/azure-container-registry-login) for more info

- Terraform API Token
  - Key: `TF_API_TOKEN`
  - Value: `<terraform api key>`

  > See the [docs](https://www.terraform.io/docs/cloud/users-teams-organizations/api-tokens.html) for more info

- Azure RBAC appId
  - Key: `AZURE_APP_ID`
  - Value: `<appId>`

  > Note: This value is created and displayed from the command run during the main prerequisites `az ad sp create-for-rbac --skip-assignment`

- Azure RBAC Password
  - Key: `AZURE_PASSWORD`
  - Value: `<password>`

> Note: This value is created and displayed from the command run during the main prerequisites `az ad sp create-for-rbac --skip-assignment`

- Discord Token
  - Key: `DISCORD_TOKEN`
  - Value: `<base64_encoded_token>`

  > This is your Discord bot token. It MUST be `base64` encoded since it is injected as a native Kubernetes secret

  - Azure CLIENT_ID
    - Key: `CLIENT_ID`
    - Value: `<clientId>`

    > See the [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli) for more info

  - Azure CLIENT_SECRET
    - Key: `CLIENT_SECRET`
    - Value: `<clientSecret>`

    > See the [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli) for more info

  - Azure TENANT_ID
    - Key: `TENANT_ID`
    - Value: `<tenantId>`

    > See the [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli) for more info

  - Azure SUBSCRIPTION_ID
    - Key: `SUBSCRIPTION_ID`
    - Value: `<subscriptionId>`

    > See the [docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli) for more info
