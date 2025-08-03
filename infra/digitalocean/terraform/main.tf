resource "digitalocean_project" "lab" {
  name        = "Lab"
  description = "The experimental project used to try things out and mess around in."
  purpose     = "Experiments & Learning"
  environment = "Development"
}

resource "digitalocean_project" "autolab" {
  name        = "Auto Lab"
  description = "The project used as part of development automation such as CI driven terraform testing."
  purpose     = "CI Integration Testing"
  environment = "Development"
}

resource "digitalocean_project" "production" {
  name        = "Production"
  description = "The project that provides services for my homelab."
  purpose     = "HomeLab Production"
  environment = "Production"
}

resource "digitalocean_project" "staging" {
  name        = "Staging"
  description = "This is meant to be an exact copy of Production so that changes can first be rolled out here and validated before automatically rolling out to Production."
  purpose     = "HomeLab Staging"
  environment = "Staging"
}
