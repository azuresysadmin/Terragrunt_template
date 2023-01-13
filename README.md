<h1>Terragrunt - simplify your deployment with this nifty little wrapper</h1>

<h2>1. Why Terragrunt?</h2>
Terragrunt is a wrapper for Terraform, that sort of re-configures the way you'd normally define a deployment. The whole concept of Terragrunt is the term "DRY", which I am certain that you're probably familiar with. i.e <i>"Don't repeat yourself"</i>. 

This is also the reason why I begun to learn about Terragrunt, becasue I was a bit irritated that I couldn't use variables for my remote backend in Terraform. Eventually I figured that it would lead to human errors about the name convention, overwrites etc of the state file; especially in a larger project. Hence why Terragrunt came to my mind. 

Eventually I understood that Terragrunt can help with the deploy automation in many other aspects, than just granting me usable variables in the remote backend configuration.

![alt text](https://i.imgur.com/l0msF1l.gif)