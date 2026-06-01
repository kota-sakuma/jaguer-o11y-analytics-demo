locals {
  ksa_otel_collector    = "principal://iam.googleapis.com/projects/${data.google_project.default.number}/locations/global/workloadIdentityPools/${data.google_project.default.project_id}.svc.id.goog/subject/ns/default/sa/otel-collector"
  role_telemetry_writer = "roles/telemetry.writer"
}

resource "google_project_iam_member" "default" {
  project = data.google_project.default.project_id
  role    = local.role_telemetry_writer
  member  = local.ksa_otel_collector
}
