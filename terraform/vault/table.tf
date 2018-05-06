variable "aws_arn_number" {}

resource "aws_dynamodb_table" "vault_backend" {
  name = "vault-backend"
  read_capacity = 5
  write_capacity = 5

  lifecycle {
    prevent_destroy = true
  }
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    actions = [
      "dynamodb:*"
    ],

    resources = [
      "${aws_dynamodb_table.vault_backend.arn}"
    ]
  }
}

resource "aws_iam_policy" "policy" {
  arn = "arn:aws:iam::${var.aws_arn_number}:policy/VaultCredentials"
  policy = "${aws_iam_policy_document.policy_document.json}"
}

resource "aws_iam_user" "user" {
  user_name = "vault-master"
  role = "${aws_iam_role.role.arn}"
}
