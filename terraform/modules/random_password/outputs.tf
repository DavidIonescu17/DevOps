output "random_password" {
  value = {
    for k, v in random_password.this : k => v.result
  }
  sensitive = true
}