### Common ###
environment              = "prod"
project_id               = "fynd-konnect-prod"
region                   = "asia-south1"
location                 = "ASIA"
name                     = "konnect"
routing_mode             = "GLOBAL"
private_ip_google_access = true
service = {
  gcs = "Storage"
}
service_type = {
  gcs = "Object-Storage"
}
common_labels = {
  domain      = "regrowth"
  environment = "prod"
  realm       = "konnect"
  galaxy      = "konnect"
  arena       = "m1"
  product     = "konnect"
}

### VPC ###
cidr = "10.187.0.0/16" # for allowing communication in subnet range
# do not update the order of items in the lists below, it is append only
public_subnets_block = [
  "10.187.88.0/21|asia-south1|lb-az1",
  "10.187.72.0/21|asia-south1|gen-az1",
]
private_subnets_block = [
  "10.187.0.0/19|asia-south1|k8s-servers-az1",
  "10.187.32.0/20|asia-south1|databases-az1",
  "10.187.48.0/20|asia-south1|data-platform-apps-az1",
  "10.187.64.0/21|asia-south1|gen-az1",
  "10.187.80.0/22|asia-south1|lb-az1",
]
proxy_only_subnets_block = [
  "10.187.84.0/22|asia-south1|lb-az1",
]

pvt_svc_connect_subnets_block = [
  "10.187.104.0/24|asia-south1|connect1-az1",
]

### GCS ###
gcs_variable = {
  nearline_transition_days    = 30
  archive_transition_days     = 90
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  gcs_bucket_prefix           = "konnect"

}
kafka_gcs_variable = {
  versioning = true
}

privatelink = {
  name          = "konnect"
  address_type  = "INTERNAL"
  prefix_length = 16
  purpose       = "VPC_PEERING"
  address       = "172.16.0.0"
  service       = "servicenetworking.googleapis.com"
}