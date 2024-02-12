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
  project = "sinuous-tuner-414107"
  region = "asia-southeast1"
  credentials = "keys.json"
}
