resource "random_password" "password" {
  length           = 16
  special          = false
  #override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_string" "random" {
  length           = 10
  number           = false
  special          = false
}