resource "google_container_cluster" "default" {
  name                = "demo"
  description         = "Demo cluster"
  location            = "asia-northeast1"
  deletion_protection = false
  initial_node_count  = 1

  node_config {
    machine_type = "e2-standard-4"
  }

  workload_identity_config {
    workload_pool = "${data.google_project.default.project_id}.svc.id.goog"
  }
}
