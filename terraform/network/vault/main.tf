# Set up dynamodb
data "aws_iam_policy_document" "vault" {
  statement {
    actions = [
      "dynamodb:*"
    ],

    resources = [
      "arn:aws:dynamodb:::table/vault"
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name = "vault"
  description = "vault management"
  policy = "${data.aws_iam_policy_document.vault.json}"
}

resource "aws_iam_user" "user" {
  name = "vault"
}

resource "aws_iam_user_policy_attachment" "attachment" {
  user = "${aws_iam_user.user.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_access_key" "keys" {
  user = "${aws_iam_user.user.name}"
}

# Set up the server
resource "digitalocean_tag" "tag" {
  name = "vault"
}

resource "digitalocean_droplet" "vault" {
  name = "vault-1"
  region = "nyc1"
  size = "s-1vcpu-1gb"
  image = "ubuntu-18-04-x64"
  ssh_keys = ["${var.vault_ssh_id}"]
  backups = false
  ipv6 = true
  monitoring = true
  tags = ["${list(digitalocean_tag.tag.name, var.firewall_restricted_tag)}"]

  provisioner "file" {
    source = "provisioner/"
    destination = "$HOME/vault"

    connection {
      type = "ssh"
      user = "root"
      private_key = "${file(var.vault_private_key_path)}"
      agent = true
    }
  }

  provisioner "local-exec" {
    command = "bash echo $AWS_ID $AWS_SECRET $HOME/vault/execute.sh"

    environment {
      AWS_ID = "AWS_ACCESS_KEY_ID=${aws_iam_access_key.keys.id}"
      AWS_SECRET = "AWS_SECRET_ACCESS_KEY=${aws_iam_access_key.keys.secret}"
    }
  }
}
