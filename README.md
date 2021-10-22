# What is a module
A module is unit of code that can be used again and again.

## A module
- Is a portion of code that performs a specific task
- Can be loaded from a larger application
- oversimplified, think of a module as a lego unit that can be used to create bigger toys

## Modules should be:
- Independent
    - As much as possible should not depend on other pieces of code
- Specific
    - Needs to do one thing, as much as possible
- Reusable
    - Has to be easy to integrate into bigger applications

## Directory structure example
To use a module means load another file from another directory
![directory-structure](./source/screenshots/2021-10-22-11-14-48.png)


# Create a module
In the current directory of your project create main.tf
```
touch main.tf
```

In the main.tf add following content. \
This will load the module that prints "Hello World!" on the cli. \
_Module and directory structure seen in the 'source = "./ "' will be created in following steps._
```
module "sum_two_numbers" {
    source = "./modules_placeholder/hello_on_cli_module"
}
```

Create a directory named modules_placeholder. \ 
This directory will contain one or more module directories.
```
mkdir modules_placeholder
```

cd into the modules_placeholder and create a new directory called hello_on_cli_module.
```
cd modules_placeholder && mkdir hello_on_cli_module
```

Create a new terraform file that will contain code that prints "Hello World!" on the cli.
```
touch main.tf
```

Add this code that prints "Hello World!":
```
resource "null_resource" "print_on_cli_hello_world" {
  provisioner "local-exec" {
    command = "echo Hello World!"
  }
}
# in bellow comment is the expected output after it's loaded and run
# module.name.null_resource.fake_resource (local-exec): Hello World!
```

Change directory back to the top of your project:
```
cd ../../
```

Type tree to list the contents:
```
tree
```
Make sure you see this structure:
```
$ tree
├── main.tf
├── module_placeholder
│   └── hello_on_cli_module
│       └── main.tf
```

Initialize the directory using terraform init:
```
terraform init
```

Tell terraform to create and display the plan on how it's going to print "Hello World!" on the cli:
```
terraform plan
```

Apply the changes if the plan looks good:
```
terraform apply
```


# How to use the code from this repository

Clone the repository:
```
git clone https://github.com/ion-training/terraform_example_module.git
```

Change directory into the newly downloaded repo:
```
cd  terraform_example_module
```

Initialize the project, it will load the module:
```
terraform init
```

Ask terraform to plan and output what steps it's going to take:
```
terraform plan
```

Apply the changes from the plan:
```
terraform apply
```

To destroy the resources (even if it's null resource):
```
terraform destroy
```

## Sample code output
```
$ terraform init
Initializing modules...

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/null from the dependency lock file
- Using previously-installed hashicorp/null v3.1.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
$
```

```
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.sum_two_numbers.null_resource.print_on_cli_hello_world will be created
  + resource "null_resource" "print_on_cli_hello_world" {
      + id = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply"
now.
$
```


For next step look for the line
> module.sum_two_numbers.null_resource.print_on_cli_hello_world (local-exec): Hello World!
```
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.sum_two_numbers.null_resource.print_on_cli_hello_world will be created
  + resource "null_resource" "print_on_cli_hello_world" {
      + id = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.sum_two_numbers.null_resource.print_on_cli_hello_world: Creating...
module.sum_two_numbers.null_resource.print_on_cli_hello_world: Provisioning with 'local-exec'...
module.sum_two_numbers.null_resource.print_on_cli_hello_world (local-exec): Executing: ["/bin/sh" "-c" "echo 'Hello World!'"]
module.sum_two_numbers.null_resource.print_on_cli_hello_world (local-exec): Hello World!
module.sum_two_numbers.null_resource.print_on_cli_hello_world: Creation complete after 0s [id=6966888167922514127]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
$
```

```
$ terraform destroy
module.sum_two_numbers.null_resource.print_on_cli_hello_world: Refreshing state... [id=6966888167922514127]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # module.sum_two_numbers.null_resource.print_on_cli_hello_world will be destroyed
  - resource "null_resource" "print_on_cli_hello_world" {
      - id = "6966888167922514127" -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.sum_two_numbers.null_resource.print_on_cli_hello_world: Destroying... [id=6966888167922514127]
module.sum_two_numbers.null_resource.print_on_cli_hello_world: Destruction complete after 0s

Destroy complete! Resources: 1 destroyed.
$
```