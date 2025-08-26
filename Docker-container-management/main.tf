provider "docker" {}

resource "docker_network" "tx_net" {
  name = "tx-net"
}

resource "docker_image" "nginx" {
  name         = "nginx:stable"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "tx-web"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }

  networks_advanced {
    name = docker_network.tx_net.name
  }
}

resource "docker_image" "redis" {
  name         = "redis:7"
  keep_locally = true
}

resource "docker_container" "cache" {
  name  = "tx-redis"
  image = docker_image.redis.image_id

  ports {
    internal = 6379
    external = 6379
  }

  networks_advanced {
    name = docker_network.tx_net.name
  }
}


