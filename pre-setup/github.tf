provider "github" {
  organization = "lessonnine"
}

resource "github_repository" "removeme" {
  name    = "DevOpsDays workshop example"
  private = false
}
