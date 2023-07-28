variable "gh_pat_token" {
  type        = string
  sensitive   = true
  description = "GitHub PAT code with access to repo(s)/org."
}

variable "repositories" {
  type        = string
  description = "Comma separated list of repositories to create runners for"
}
