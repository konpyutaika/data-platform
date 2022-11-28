env = "staging"
aws_vpc_id = "vpc-05f864f8b836539bf"
aws_private_subnets_id = [
  "subnet-0b53fa3fd21644178",
  "subnet-0c8f1ff432a98270a",
  "subnet-075ba9946e3f44df6",
]

repositories = {
  zuora = [
    {
      name = "demo1"
      image = {
        repository = "docker.io/dagster/user-code-example"
        tag = "latest"
      }
      repo_path = "/example_project/example_repo/repo.py"
    },
    {
      name = "demo2"
      image = {
        repository = "docker.io/dagster/user-code-example"
        tag = "latest"
      }
      repo_path = "/example_project/example_repo/repo.py"
    },
  ],
  default = [
    {
      name = "project1"
      image = {
        repository = "docker.io/dagster/user-code-example"
        tag = "latest"
      }
      repo_path = "/example_project/example_repo/repo.py"
    },
  ],
}
