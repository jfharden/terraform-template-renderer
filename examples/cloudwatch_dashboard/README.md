# Multi Resource Lookup example

This example requires applying the terraform in 2 stages. The easiest way to do this is to comment
out everything in `cloudwatch_dashboard.tf` run `terraform apply`, allow the aws instances to be created,
and then uncomment `cloudwatch_dashboard.tf`

This example directory includes a screenshot of the resultant dashboard which was a result of running terraform
apply as described above.

## COSTS!

Be warned, this example will cost money to perform, it requires starting up 2 t2.nano instances and an ELB.
You are solely responsible for any resources created and costs incurred.

I strongly recommend running `terraform destroy` once you have finished running the test to remove all the resources
that the test created.

