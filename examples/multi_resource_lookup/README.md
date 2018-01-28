# Multi Resource Lookup example

This example requires applying the terraform in 2 stages. The easiest way to do this is to comment
out everything in `multi_resource_lookup.tf` run `terraform apply`, allow the aws instances to be created,
and then uncomment `multi_resource_lookup.tf`

## COSTS!

Be warned, this example will cost money to perform, it requires starting up 2 t2.nano instances. You are solely
responsible for any resources.

I strongly recommend running `terraform destroy` once you have finished running the test to remove all the resources
that the test created.
