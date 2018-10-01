# DevOpsDays Terraform workshop code outcomes
In this repository you can find an example of code, which we've built during the hands-on workshop at the DevOpsDays Berlin 2018.

## Folders structure
This repository contains three folders.
1. `Pre-setup`. This folder includes code, which in production environment should be applied before everything else. It contains of Github repository, AWS S3 bucket for Terraform state storing and AWS DynamoDB table for Terraform state lock.
2. `Network`. This folder has the code, which has the purpose of providing you with a basic networking infrastructure for the future EC2 instance. Please keep in mind, it's not the setup you should go production, it exists just for educational purpose and some improvements (and complications) should be made before you can actually use it live.
3. `Machine`. This folder uses the shared state of the `Network` Terraform module and after applying provides you the EC2 machine with SSH access from the `95.91.245.0/24` IP group. If you want to apply it - don't forget to change the IP range, as well as use your own keypair name (in `machine/instance.tf` `key_name` attribute).

The code should be applied the way it described above. The apply command is `terraform apply`. Terraform by itself can be installed on OSX with Homebrew and on Linux by the standard way you install packages on your machine.

P.S. Thanks [Babbel Team](https://grnh.se/e52f67451) for support.
