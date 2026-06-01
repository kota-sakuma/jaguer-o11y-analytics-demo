variable "project_id" {
  type        = string
  description = "The ID of the project to deploy the infrastructure to"

  validation {
    condition     = length(var.project_id) >= 6 && length(var.project_id) <= 30
    error_message = "The project ID must be between 6 and 30 characters long"
  }
}
