provider "google" {
  credentials = "${file("manawa-20009678-f4891b302707.json")}"
  region = "${var.region}"
  project     = "manawa-20009678"
}
