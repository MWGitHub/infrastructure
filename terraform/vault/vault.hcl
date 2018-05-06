storage "dynamodb" {
    ha_enabled = "false"
    region = "us-east-1"
    table = "vault-backend"

    ready_capacity = 10
    write_capacity = 5
}
