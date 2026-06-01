resource "google_container_cluster" "default" {
  name               = "demo"
  description        = "Demo cluster"
  location           = "asia-northeast1-b"
  initial_node_count = 1

  node_config {
    machine_type = "e2-standard-4"
  }
}
