# GitHub Actions

The following documents is a rough guide for setting up your cluster to be deployed with GitHub actions

Note: Due to race conditions, it is advisable (but not 100% required) to run the `make build` script locally first to deploy your project before integrating it with CICD. If you know what you are doing and are okay with a little a few hiccups on the first run, then you can just build it all from CICD on your first go. The hiccups mostly involve a Docker build attempting to push images to ACR before it has been created by the Terraform job that runs afterwards.

## Prerequisites

Terraform:

- Your **two** Terraform workspaces have been configured - [Terraform Docs](terraform-cloud.md)

Azure:

- An Azure Service Principal for deploying your Terraform changes
- Your Azure Service Principal will need `owner` permissions to your Azure Subscription. This is due to K8s needing to bind your ACR registiry to your K8s cluster with pull permissions

Here are two great documents to create an Azure Service Principal and assign permissions to it:

1. [Create a Service Principal](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)
1. [Assign Roles to a Service Principal](https://docs.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal?tabs=current)

GitHub Secrets:

This part is important for CI/CD to pass! You will need to configure the following GitHub secrets as `key` / `value` pairs.

> Note: Any of the items below with a 💡 deserve a little bit of extra attention

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

- ACR Registry Server 💡
  - Key: `REGISTRY_LOGIN_SERVER`
  - Value: `<example.azurecr.io>`

  > This is essentially a variable for the `deployment.yml` action and is not *really* a secret
  > Note: The ACR registry server domain is needed for the `build` job of the CI pipeline and also later Terraform jobs. This is a chicken and egg situation and therefore, it is advisable to run `make build` to get the cluster spun up before managing your cluster with GitHub Actions (CI).

- ACR Registry Username 💡
  - Key: `REGISTRY_USERNAME`
  - Value: `<username>`

  > See the [docs](https://github.com/marketplace/actions/azure-container-registry-login) for more info.
  > See `ACR Registry Server` above

- ACR Registry Password 💡
  - Key: `REGISTRY_PASSWORD`
  - Value: `<password>`

  > See the [docs](https://github.com/marketplace/actions/azure-container-registry-login) for more info
  > See `ACR Registry Server` above

- Terraform API Token
  - Key: `TF_API_TOKEN`
  - Value: `<terraform api key>`

  > See the [docs](https://www.terraform.io/docs/cloud/users-teams-organizations/api-tokens.html) for more info

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

- kubectl config file 💡
  - Key: `KUBE_CONFIG`
  - Value: `<raw_kubectl_config_file_contents>`

  > See the [docs](https://github.com/marketplace/actions/kubernetes-set-context) for more info. Note: This token is needed in the `terraform/k8s` job. However, you can only get the contents of the kubeconfig file from the `terraform/k8s` job once it has been deployed. This is a chicken and egg situation and therefore, it is advisable to run `make build` to get the cluster spun up before managing your cluster with GitHub Actions (CI). If you need to get the contents of the kubeconfig file, you can run `script/kubectl-config` and then check the contents of `~/.kube/config`. If any Terraform changes take place which destroy the cluster, you will need to grab your kubeconfig file again and apply it as a secret.. again
