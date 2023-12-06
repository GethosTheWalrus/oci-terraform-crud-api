resource "aws_dynamodb_table" "demo_table" {
    name           = "demo_table"
    billing_mode   = "PROVISIONED"
    read_capacity  = 20
    write_capacity = 20
    hash_key       = "id"

    attribute {
        name = "id"
        type = "N"
    }

    attribute {
        name = "username"
        type = "S"
    }

    global_secondary_index {
        name               = "usernameIndex"
        hash_key           = "username"
        write_capacity     = 10
        read_capacity      = 10
        projection_type    = "INCLUDE"
        non_key_attributes = ["id"]
    }

    tags = {
        Name        = "demo_table"
    }
}

resource "aws_dynamodb_table_item" "user1" {
    table_name = aws_dynamodb_table.demo_table.name
    hash_key   = aws_dynamodb_table.demo_table.hash_key

    item = <<ITEM
        {
        "id": {"N": "1"},
        "username": {"S": "user1"}
        }
        ITEM
}

resource "aws_dynamodb_table_item" "user2" {
    table_name = aws_dynamodb_table.demo_table.name
    hash_key   = aws_dynamodb_table.demo_table.hash_key

    item = <<ITEM
        {
        "id": {"N": "2"},
        "username": {"S": "user2"}
        }
        ITEM
}

resource "aws_dynamodb_table_item" "user3" {
    table_name = aws_dynamodb_table.demo_table.name
    hash_key   = aws_dynamodb_table.demo_table.hash_key

    item = <<ITEM
        {
        "id": {"N": "3"},
        "username": {"S": "user3"}
        }
        ITEM
}

resource "aws_dynamodb_table_item" "user4" {
    table_name = aws_dynamodb_table.demo_table.name
    hash_key   = aws_dynamodb_table.demo_table.hash_key

    item = <<ITEM
        {
        "id": {"N": "4"},
        "username": {"S": "user4"}
        }
        ITEM
}

resource "aws_dynamodb_table_item" "user5" {
    table_name = aws_dynamodb_table.demo_table.name
    hash_key   = aws_dynamodb_table.demo_table.hash_key

    item = <<ITEM
        {
        "id": {"N": "5"},
        "username": {"S": "user5"}
        }
        ITEM
}

resource "aws_dynamodb_table_item" "user6" {
    table_name = aws_dynamodb_table.demo_table.name
    hash_key   = aws_dynamodb_table.demo_table.hash_key

    item = <<ITEM
        {
        "id": {"N": "6"},
        "username": {"S": "user6"}
        }
        ITEM
}

resource "aws_dynamodb_table_item" "user7" {
    table_name = aws_dynamodb_table.demo_table.name
    hash_key   = aws_dynamodb_table.demo_table.hash_key

    item = <<ITEM
        {
        "id": {"N": "7"},
        "username": {"S": "user7"}
        }
        ITEM
}