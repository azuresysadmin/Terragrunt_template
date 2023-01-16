# Terragrunt - write more, to write less

### Disclaimer: I recently begun using Terragrunt and I am still a novice. I created this repository to learn, but at the same time it might be useful for someone else. I am not saying that this is the optimal way of working, but it is how I am using the tool, for now. It will be continuously updated. 

## 1. Why Terragrunt?
Terragrunt is a wrapper for Terraform, that sort of modifies the way you'd normally define a deployment. The whole concept of Terragrunt is the term "DRY", i.e *"Don't repeat yourself"*. <br> You define a good parent configuration, that you can re-use for any environment.

This is also the reason why I begun to learn about Terragrunt, becasue I was a bit irritated that I couldn't use variables for my remote backend in Terraform. <br> Eventually I figured that it would lead to human errors about the name convention, overwrites etc of the state file; especially in a larger project. Hence why Terragrunt came to my mind.

Terragrunt can help with the deploy automation in many other aspects, other than just providing me with usable variables in the remote backend configuration. This will just be a short introduction on how to get started with Terragrunt.

## 2. Installation
Installing Terragrunt is just as easy as any other application. If you are as I am on macOS, the easiest way is to simply install it through Homebrew. *'brew install terragrunt'*. Obviously, in order to get this to work, you need to have Terraform/HCL Language Server and Azure CLI installed as well. For further installation instructions, please refer to Gruntwork's official Terragrunt documentation. - https://terragrunt.gruntwork.io/docs/#getting-started

## 3. Commands
Terragrunt is using the same commands as Terraform, such as "init", "plan" and "apply". If you know your way around the CLI, you won't have any issues with adopting to Terragrunt from Terraform. Terragrunt also has a new command, "run-all". Which is combined with any of the other default Terraform commands. Example: *'terragrunt run-all plan'*. <br>This command grants us the possibility to run commands on several modules combined. More on that later.

## 4. How does it work? 
The main purpose of Terragrunt is to remove as much of manual inputs as possible, so that you can easily swap to a different region, subscription or environment without having to alter a lot of inputs. I will describe the thought of my template and a tad bit on how Terragrunt works. 

#### *<ins>File structure</ins>*
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
*Obviously, this structure is supposed to be mirrored if you're using a different environment, such as "production".*

_Most resources or configurations in the repository has comments added in the code, so if something isn't be explained within the README., it will probably be exaplined within the configuration files._
#### *<ins>Defining your root configuration - terragrunt.hcl</ins>*
Terragrunt's configuration is defined in a file called 'terragrunt.hcl' that you create in your root directory. This is a parent file, that all other sub-configuration files will refer to. Terragrunt will always climb up the tree structure to find a matching parent configuration. In this particular file you define the default settings and variables, that all of your sub-directories can use and will refer to. This includes the provider(s) and its required versions, subscription and remote backend configuration. As you can see in the parent file, you can use variables within your backend configuration.

Another brilliant DRY feature is that you can define the provider directly in the parent configuration, which means that you'll never have to define the provider in your modules, as you have to do with a vanilla Terraform configuration.

This is also where you specify your inputs and locals. I have specified the locals within each region/environment etc. By merging these in the root file, as you can see for "region_vars" and "environment_vars", you can specify several within one child configuration file. For instance I have stored the local inputs for the remote backend in the same "env.hcl" file. 

This grants you the opportunity to write as little as code as possible. Some locals will probably be permanent for each environment, such as "env=dev" and "location=westeurope", etc. Terragrunt will also automatically create a file structure for your state file, based on from where you initiate the command. 
If I were to say, run a Terragrunt apply from within the resource_group directory under "/Customer_root/dev/westeurope/resource_group, the folder structure would be automatically built by Terragrunt in your remote backend (i.e Storage Account container).

#### *<ins>Creating .hcl files for your directories</ins>*
If I were to initiate Terragrunt from within the resource_group (region/dev), it would firstly look in that directory to find an input to the defined variables, if Terragrunt won't find it there, it will move one level up, and then again and again until it reaches the parent configuration. This means that you can do very delicate definitions, but you can also refer to the parent configuration directly, if that's what you want. 

Firstly, I have created an "env.hcl" in my Development/Production directory, which is where I will define my locals for that specific region. After that, I have created a "region.hcl" in the region folder, that I define based on where that resource will be run/created, such as "westeurope". These inputs will most likely be permanent for this directory. 

We can then move further down in the directory, to resource specific Terragrunt configurations. In this file, you will tell Terragrunt to look for the parent configuration, which is what I described previously on how Terragrunt will search for the necessary inputs and configurations. This is also were you'd define your inputs, so that your resource blocks can consist of variables, instead of hardcoded inputs. 

#### *<ins>Working with modules</ins>*
Take a look at the "module1" directory and you'll notice that I am using an example from the public module repository. In this case, I am using a Vnet Module as an example. As you can see, you can create this resource solely without having to use any regular .tf files. 

- Refer to the module URL and its version
- Once again, include the "find in parent folders" configuration, just as you did with your RG
- Define dependencies if needed
- You need to create a mock RG, this won't be deployed, but Terragrunt needs a virtual resource group for it to be able to do the initialization, as it won't refer to the dependency until the resource gets planned/created. This can be named w/e and won't actually be created. 
- As always, refer to the locals
- Define the mandatory/optional inputs for your module

You can even run all of your modules simultaneously, by moving into the root folder and execute a "terragrunt run-all init/plan/apply" from there.

#### *<ins>Terraform configuration</ins>*
As this is a wrapper to Terraform, you still require your general .tf files, such as variables.tf, main.tf and outputs.tf. You define this just as you'd do with a regular Terraform configuration. 

## 5. Conclusion
Terragrunt might take some time to configure initially, especially if you want to define the .hcl configurations on a very deep level. 
I found it quite easy to use after I had a few hours of proper trial and error. I, for one, will most likely depend upon Terragrunt for my next project, whether if it's a personal or billed project. <br>It makes IaC more secure against human error and the whole concept of *DRY* really shines through as you start to get the hang of it. But yeah, that's it and that's all. You should be able to understand the basics of Terragrunt. Fire away.

![alt text](https://i.imgur.com/l0msF1l.gif)


