terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.14.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "usecase-2-412812"
  region = "us-cental1"
  credentials = "keys.json"
}
