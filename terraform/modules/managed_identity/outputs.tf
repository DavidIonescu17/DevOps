output "principal_ids" {
    value = {
        for name, identity in azurerm_user_assigned_identity.this :
        name => identity.principal_id
    }
}

output "identity_ids" {
    value = {
        for name, identity in azurerm_user_assigned_identity.this :
        name => identity.id
    }
}