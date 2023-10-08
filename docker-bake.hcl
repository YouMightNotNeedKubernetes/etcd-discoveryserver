target "docker-metadata-action" {}

target "discoveryserver" {
    context = "https://github.com/etcd-io/discoveryserver.git#master"
    dockerfile = "Dockerfile"
}

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

target "dev" {
    contexts = {
        discoveryserver = "target:discoveryserver"
    }

    tags = [
        "youmightnotneedkubernetes/etcd-discoveryserver:main"
    ]
}
