locals {
  cluster_name = "cf-on-k8s"
  project       = "cf-on-k8s-cepler"
  region        = "europe-west3"
}

provider "google" {
  version = "~> 3.42.0"
  project = local.project
  region  = local.region
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google"
  version = "11.1.0"
  project_id             = local.project
  name                   =local.cluster_name
  regional               = true
  region                 = local.region
  network                = google_compute_network.vpc.name
  subnetwork             = google_compute_subnetwork.cluster.name
  ip_range_pods          = local.pods_range_name
  ip_range_services      = local.svc_range_name
  create_service_account = false
  service_account        = google_service_account.cluster_service_account.email
}
