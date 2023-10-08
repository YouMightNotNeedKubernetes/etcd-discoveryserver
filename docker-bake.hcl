target "docker-metadata-action" {}

target "default" {
    inherits = ["docker-metadata-action"]

    contexts = {
        discoveryserver = "target:discoveryserver"
    }

    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
}

target "discoveryserver" {
    context = "https://github.com/etcd-io/discoveryserver.git#master"
    dockerfile = "Dockerfile"
}
