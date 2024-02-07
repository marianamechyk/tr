## Purpose﻿
The Terraform scripts are designed to automate the provisioning of Snowflake resources, including warehouses, databases, schemas, tables, and roles.These scripts enable Infrastructure as Code (IaC) practices.

## Prerequisites

- Terraform installed (https://developer.hashicorp.com/terraform/install)
- Snowflake account (https://signup.snowflake.com/)

## Configuration:

The configuration involves defining Terraform files (.tf files) that specify the desired Snowflake resources, their properties, and any dependencies between them.
Users need to provide input variables such as account credentials, resource names, and configuration details. These variables can be defined in a separate .tfvars file.
The Snowflake provider configuration includes specifying the Snowflake provider source and version, as well as providing authentication credentials (username, password, account).

## Prerequisites and Dependencies:

Users need access to a Snowflake account.
They should have the necessary permissions to run Terraform commands and modify infrastructure configurations.


## Running:

To run the Terraform script, users need to have Terraform installed on their system.
They initialize the Terraform project by running terraform init to download the required provider plugins and initialize the working directory.
After initialization, users can run terraform plan to preview the changes Terraform will make based on the configuration.
Finally, they execute terraform apply to apply the changes and provision the Snowflake resources according to the defined configuration.
