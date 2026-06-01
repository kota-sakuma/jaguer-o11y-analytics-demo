resource "google_project_service" "observability" {
  project = data.google_project.default.project_id
  service = "observability.googleapis.com"
}

resource "google_project_service" "telemetry" {
  project = data.google_project.default.project_id
  service = "telemetry.googleapis.com"
}
