# terraform-aws-kanboard

This repo contains a Terraform plan for deploying [kanboard](https://github.com/kanboard/kanboard) on an AWS EC2 instance

Kanboard is a project management open source software application that uses a Kanban board to implement the Kanban process management system. Features[2] include a minimal drag-and-drop web user interface, a command line interface[3] and ability to automate repetitive tasks. Kanboard uses SQLite by default and can use other SQL databases. Various plugins by external authors provide additional customisation and expansion capabilities, e.g. custom CSS themes to change the default appearance.


## Requirements

| Name | Version |
| ---- | ------- |
| terraform | >=1.0.0 |
| aws | >=4.0 |

## Providers

|Name | Version |
| --- | ------- |
| aws | >=4.0 |

## Terraform Resources

| Name | Type |
| ---------| ------------|
| `vpc` | Resource |
| `aws_internet_gateway` | Resource |
| `aws_subnet` | Resource |
| `aws_route_table` | Resource |
| `aws_instance` | Resource |
| `aws_route_table_association` | Resource |
| `aws_security_group` | Resource |
| `aws_key_pair` | Resource |

## Inputs

| Name |  Type | Required|
| ---- |  ---- | ------- |
| `aws_access_key` |  string | yes
| `aws_secret_key` | string | yes |
| `region` | string | yes |
| `key_name` | string | yes |
| `public_key` |  string | yes |
| `ami_id` |  string | yes
| `vpc_name` | string | yes |
| `public-subnets-data`| array | yes |
| `private-subnets-data`| array | yes |
| `vpc_name`| string | yes |
| `availability_zone`| string | yes |
| `availability_zone1`| string | yes |
| `instance_name`  | string | yes |
| `private_instance_name` |  string | yes
| `instance_type`| string | yes |

## Contributing

Dont hesitate to create a pull request