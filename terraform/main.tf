terraform {
  backend "remote" {
    organization = "mfkimbell"

    workspaces {
      name = "dev-react"
    }
  }
}