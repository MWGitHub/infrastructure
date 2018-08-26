storage "dynamodb" {
  ha_enabled = "false"
  region = "us-east-1"
  table = "vault"

  ready_capacity = 10
  write_capacity = 5
}

listener "tcp" {
  address = "127.0.0.1:8200",
  tls_disable = 1
}
