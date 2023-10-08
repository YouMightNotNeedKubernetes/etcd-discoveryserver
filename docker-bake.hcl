target "default" {
    contexts = {
        discoveryserver = "target:discoveryserver"
    }
    tags = [
        "etcd-discoveryserver:latest",
        "ghcr.io/youmightnotneedkubernetes/etcd-discoveryserver:latest",
    ]
    // platforms = [
    //     "linux/amd64",
    //     "linux/arm64",
    // ]
}

target "discoveryserver" {
    context = "https://github.com/etcd-io/discoveryserver.git#master"
    dockerfile = "Dockerfile"
}
