/*
 * # UniFi Host DNS Records Module
 * 
*/

terraform {
  required_version = ">= 1.11.0"
  required_providers {
    unifi = {
      source  = "ubiquiti-community/unifi"
      version = "0.41.2"
    }
  }
}
