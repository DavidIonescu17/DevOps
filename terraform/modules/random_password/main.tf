# Rotate every rotation_days
resource "time_rotating" "this" {
  rotation_days = var.pass_rotation_days
}

resource "random_password" "this" {
  for_each = var.random_password_config

  length           = each.value.length
  special          = each.value.special
  override_special = each.value.override_special

  keepers = {
    rotation = time_rotating.this.id
  }
}