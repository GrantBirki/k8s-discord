<h1 align="center">k8s-discord</h1>
<h1 align="center">
    <img src="docs/assets/k8s.png" alt="k8s" align="center" width="64px"/>
    <img src="docs/assets/discord.svg" alt="discord" align="center" width="64px"/>
    <img src="docs/assets/terraform.png" alt="terraform" align="center" width="64px"/>
</h1>

<p align="center">
  Create a K8s cluster running a Discord bot using pure Terraform
</p>

<p align="center">
  <a href="https://github.com/GrantBirki/k8s-discord/actions/workflows/deployment.yml"><img src="https://github.com/GrantBirki/k8s-discord/actions/workflows/deployment.yml/badge.svg?event=push" alt="deployment" height="18"></a>
  <a href="https://github.com/GrantBirki/k8s-discord/actions/workflows/review.yml"><img src="https://github.com/GrantBirki/k8s-discord/actions/workflows/review.yml/badge.svg?event=push" alt="review"/></a>
  <a href="https://github.com/GrantBirki/k8s-discord/actions/workflows/tfsec.yml"><img src="https://github.com/GrantBirki/k8s-discord/actions/workflows/tfsec.yml/badge.svg?event=push" alt="tfsec"/></a>
</p>

<hr>

## What You Will Create ⭐

A distributed Discord bot using Slash commands in Kubernetes!

- A Kubernetes Cluster running on Azure Kubernetes Service ([AKS](https://azure.microsoft.com/en-us/services/kubernetes-service/#overview))
- A "frontend" app that listens and forwards incoming Discord Slash commands (uses [Discord.js](https://github.com/discordjs/discord.js))
- A "backend" app that reponds to HTTP requets from the frontend app and runs all your bots custom logic! (Using Python and Flask)

> Note: This is a "sister" repo to my other project [`kong-k8s-terraform`](https://github.com/GrantBirki/k8s-kong-terraform) feel free to checkout both and learn more about K8s and Terraform!

## Prerequisites 🚩

You will need a few things to use this project:

1. Fork me! 🍴
1. An [Azure](https://azure.microsoft.com/en-us/free/) account (this project uses AKS)
1. [tfenv](https://github.com/tfutils/tfenv) (for managing Terraform versions)
1. [kubectl](https://kubernetes.io/docs/tasks/tools/) (for applying K8s manifests)
1. [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
1. A [Terraform Cloud](https://www.terraform.io/cloud) account to store your TF state remotely
    - See the [`terraform-cloud`](docs/terraform-cloud.md) docs in this repo for more info (required if you are using Terraform Cloud)
1. An Azure Service Principal for deploying your Terraform changes - [Create a Service Principal](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)
1. Your Azure Service Principal will need `owner` permissions to your Azure Subscription. This is due to K8s needing to bind your ACR registiry to your K8s cluster with pull permissions - [Assign Roles to a Service Principal](https://docs.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal?tabs=current)
1. You will need to skim through the following files and edit the lines with "`(CHANGE ME)`" comments:
    - [`terraform\k8s-cluster\versions.tf`](terraform\k8s-cluster\versions.tf)
    - [`terraform\k8s-cluster\variables.tf`](terraform\k8s-cluster\variables.tf)
    - [`terraform\k8s\k8s-cluster.tf`](terraform\k8s\k8s-cluster.tf)

    > Example: Updating values with your own unique K8s cluster name and pointing to your own Terraform cloud workspaces
1. A Discord bot with Slash command permissions set and a token + client id - [Discord Documentation](https://discord.com/developers/docs/interactions/application-commands)

## Usage 💻

Build a K8s cluster with a single command!

> Go make a coffee while this runs because it can take up to 15 minutes

```console
$ make build

🔨 Let's build a K8s cluster!
✅ tfenv is installed
✅ Azure CLI is installed
✅ kubectl is installed
✅ terraform/k8s-cluster/terraform.auto.tfvars.json exists
✅ terraform/k8s-cluster/terraform.auto.tfvars.json contains non-default credentials
🚀 Deploying 'terraform/k8s-cluster'...
⛵ Configuring kubectl environment
🔨 Time to build K8s resources and apply their manifests on the cluster!
✅ All manifests applied successfully
✨ Done! ✨
```

Now that your bot is up and running in Kubernetes, you will need to [register](https://discordjs.guide/interactions/registering-slash-commands.html#guild-commands) your Slash commands. To make this easy, I added a helper script which does this for you. It relies on the correct `src/frontend/.env` file being setup with your Discord `CLIENT_ID` and `DISCORD_TOKEN`. Below is an example of me registering my commands for my test Guild:

```console
$ make register
Started refreshing application (/) commands.
Successfully registered application commands for development guild
Successfully reloaded application (/) commands.
[#] Registered all slash commands in the src/frontend/commands folder!
```

If all went as planned you should now have a very simple Discord bot running that can respond to (now registered) Slash commands!

You can use either of the commands to test:

- `/ping` - Returns `pong`
- `/health` - Returns the health of the "backend" app

When you are done using your K8s cluster, you may destroy it by executing the following command:

```console
$ make destroy

💥 Let's DESTROY your K8s cluster!
Continue with the complete destruction of your K8s cluster (y/n)? y
✅ Approval for destroy accepted
✅ tfenv is installed
✅ terraform/k8s-cluster/terraform.auto.tfvars.json exists
✅ terraform/k8s-cluster/terraform.auto.tfvars.json contains non-default credentials
💥 Destroying 'terraform/k8s'...
💥 Destroying 'terraform/k8s-cluster'...
✨ Done! ✨
```

## Developing Locally 🛠️

If you want to test out the bot locally, rather than deploy to Azure AKS right away you can do so with `docker-compose`

### Prerequisites

- You have created a Discord bot with [Slash command permissions](https://canary.discord.com/developers/docs/interactions/slash-commands#slash-commands)
- You have invited your Discord bot to a Guild (channel) with the Slash command permissions
- You have filled out the variables in the `src/frontend/.env.example` and renamed it to `src/frontend/.env`
- You have run the `make register` command which registers your Slash commands with Discord

Now you can run the bot locally:

```console
$ make run
[#] Killing old docker processes
[#] Building docker containers
[+] Building 2.4s (17/17) FINISHED
[+] Building 1.9s (11/11) FINISHED
Creating frontend ... done
Creating backend  ... done
[#] The Docker stack is now running!
```

Open up Discord and run `/ping` to test the bot in the Discord channel you added it to!

## Project Folder Information 📂

- `script/` - Contains various scripts for deployments and maintenance
- `src/` - Contains the source code for the bot (frontend and backend)
- `terraform/k8s-cluster` - The main terraform files for building the infrastructure of the K8s cluster. This folder contains configurations for the amount of K8s nodes, their VM size, their storage, etc
- `terraform/k8s/*` - Kubernetes deployment manifests and Terraform files for Kong, Grafana/Prometheus, and the NGINX example http server

## GitHub Actions ⚡

Once you have successfully built your K8s cluster and tested its functionality, you can deploy it using CI/CD with GitHub actions!

To do so, check out the following documentation in this repo: [`github-actions`](docs/github-actions.md)

## Purpose 💡

The purpose of this project/repo is to quickly build a minimal K8s cluster with Terraform to get a Discord bot with Slash commands going.

## Contributing 👩‍💻

All contributions are welcome! If you have any questions or suggestions, please open an issue or fork this repo and create a pull request!
