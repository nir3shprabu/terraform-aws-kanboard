# terraform-aws-kanboard

This repo contains a Terraform plan for deploying [kanboard](https://github.com/kanboard/kanboard)
 instance and **postgresql** database  on  two different AWS EC2 instance

# Kanboard
```
The Kanban board is a tool for workflow visualization, designed to help you bring clarity to your work process and enhance efficiency by limiting work in progress. With this new level of transparency, you will quickly identify problematic work stages, and by improving those, your team will soon work more efficiently.
```

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