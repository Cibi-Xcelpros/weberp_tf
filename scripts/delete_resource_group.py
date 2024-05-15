from azure.identity import ClientSecretCredential
from azure.mgmt.resource import ResourceManagementClient

# Define your Azure subscription ID and resource group name
subscription_id = '<your-subscription-id>'
resource_group_name = '<your-resource-group-name>'
tenant_id = '<your-tenant-id>'
client_id = '<your-client-id>'
client_secret = '<your-client-secret>'

# Create Azure Resource Management client
credential = ClientSecretCredential(tenant_id, client_id, client_secret)
resource_client = ResourceManagementClient(credential, subscription_id)

# Delete the resource group
print(f"Deleting resource group '{resource_group_name}'...")
async_delete_operation = resource_client.resource_groups.begin_delete(resource_group_name)
async_delete_operation.wait()
print(f"Resource group '{resource_group_name}' deleted successfully.")
