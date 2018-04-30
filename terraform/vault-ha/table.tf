data "aws_dynamodb_table" "vault-backend" {
  name = "vault-backend"
  prevent_destroy = true
}

data "aws_iam_user" "user" {
  user_name = "vault-user"
}

data "aws_iam_policy" "policy" {
  arn = "arn:aws:iam:"
  name = "vault-user-policy"
}
