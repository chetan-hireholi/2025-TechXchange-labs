provider "docker" {
  # host = "tcp://localhost:2327"
}

resource "docker_network" "tx_net" {
  name = "tx-net"
}

resource "docker_image" "nginx" {
  name         = "tx-nginx:latest"
  keep_locally = true
  
  build {
    context = "./nginx-build"
    dockerfile = "Dockerfile.nginx"
  }
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

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }
}

resource "docker_image" "redis" {
  name         = "tx-redis:latest"
  keep_locally = true
  
  build {
    context = "./redis-build"
    dockerfile = "Dockerfile.redis"
  }
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

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }
}


