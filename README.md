# Terragrunt - simplify your deployment with this nifty little wrapper

### Disclaimer: I recently started learning Terragrunt and created this repository for my own purposes. This will gradually be updated. I am not suggesting that is how you should do it, just how I am using the tool for my own purposes.

## 1. Why Terragrunt?
Terragrunt is a wrapper for Terraform, that sort of re-configures the way you'd normally define a deployment. The whole concept of Terragrunt is the term "DRY", which I am certain that you're probably familiar with. i.e *"Don't repeat yourself"*.

This is also the reason why I begun to learn about Terragrunt, becasue I was a bit irritated that I couldn't use variables for my remote backend in Terraform. Eventually I figured that it would lead to human errors about the name convention, overwrites etc of the state file; especially in a larger project. Hence why Terragrunt came to my mind.

Eventually I understood that Terragrunt can help with the deploy automation in many other aspects, other than just providing me with usable variables, in the remote backend configuration. This will just be a short introduction on how to get started with Terragrunt.

## 2. Installation
Installing Terragrunt is just as easy as any other application. If you are, as I am on macOS, the easiest way is to simply install it through Homebrew. *'brew install terragrunt'*. Obviously, in order to get this to work, you need to have Terraform/HCL Language Server installed as well. For further installation instructions, please refer to Gruntwork's official Terragrunt documentation. - https://terragrunt.gruntwork.io/docs/#getting-started

## 3. Commands
Terragrunt is using the same commands as Terraform, such as "init", "plan" and "apply". If you know your way around the CLI, you won't have any issues with adopting to Terragrunt from Terraform. Terragrunt also has a new command, "run-all". Which is combined with any of the default Terraform commands. Example: *'terragrunt run-all plan'*. This command grants us the possibility to run commands on several modules combined. More on that later.

## 4. How does it work? 
The main purporse of Terragrunt is to remove as much of manual inputs as possible, so that you can easily swap to a different region, subscription or environment without having to alter that many inputs. I will describe the thought of my template and a tad bit on how Terragrunt works. 

- *File structure*
```
📦Customer_root
 ┣ 📂Development
 ┃ ┣ 📂region
 ┃ ┃ ┣ 📂modules
 ┃ ┃ ┃ ┗ 📂module1
 ┃ ┃ ┃ ┃ ┗ 📜terragrunt.hcl
 ┃ ┃ ┣ 📂resource_group
 ┃ ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┃ ┣ 📜terragrunt.hcl
 ┃ ┃ ┃ ┗ 📜variables.tf
 ┃ ┃ ┗ 📜region.hcl
 ┃ ┣ 📂region2
 ┃ ┃ ┣ 📂modules
 ┃ ┃ ┃ ┗ 📂module1
 ┃ ┃ ┃ ┃ ┗ 📜terragrunt.hcl
 ┃ ┃ ┣ 📂resource_group
 ┃ ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┃ ┣ 📜terragrunt.hcl
 ┃ ┃ ┃ ┗ 📜variables.tf
 ┃ ┃ ┗ 📜region.hcl
 ┃ ┗ 📜env.hcl
 ┗ 📜terragrunt.hcl
```
 Obviously, this structure is supposed to be mirrored if you're using a different environment, such as "production".

![alt text](https://i.imgur.com/l0msF1l.gif)


