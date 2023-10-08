# etcd-discoveryserver
A self-hosted etcd Discovery Service

Source: https://github.com/etcd-io/discoveryserver

## Discovery service protocol

Discover other etcd members in a cluster bootstrap phase

Discovery service protocol helps new etcd member to discover all other members in cluster bootstrap phase using a shared discovery URL.

Discovery service protocol is only used in cluster bootstrap phase, and cannot be used for runtime reconfiguration or cluster monitoring.

The protocol uses a new discovery token to bootstrap one unique etcd cluster. Remember that one discovery token can represent only one etcd cluster. As long as discovery protocol on this token starts, even if it fails halfway, it must not be used to bootstrap another etcd cluster.

### Creating a new discovery token

To create a private discovery URL using the “new” endpoint, use the command:

```sh
$ curl https://discovery.etcd.io/new?size=3
# https://discovery.etcd.io/3e86b59982e49066c5d813af1c2e2579cbf573de
```

This will create the cluster with an initial size of 3 members. If no size is specified, a default of 3 is used.

```
ETCD_DISCOVERY=https://discovery.etcd.io/3e86b59982e49066c5d813af1c2e2579cbf573de
```

```
--discovery https://discovery.etcd.io/3e86b59982e49066c5d813af1c2e2579cbf573de
```

> Each member must have a different name flag specified or else discovery will fail due to duplicated names. Hostname or machine-id can be a good choice.

Now we start etcd with those relevant flags for each member. This will cause each member to register itself with the discovery service and begin the cluster once all members have been registered.

## Getting started

You can run your own etcd discovery service using the `etcd-discoveryserver` image.

The image is available on [Docker Hub](https://hub.docker.com/r/youmightnotneedkubernetes/etcd-discoveryserver)

```sh
$ docker pull youmightnotneedkubernetes/etcd-discoveryserver
```

### Configuration
The service has three configuration options, and can be configured with either runtime arguments or environment variables.

- `--addr` / `DISC_ADDR`: the address to run the service on, including port.
- `--host` / `DISC_HOST`: the host url to prepend to `/new` requests.
- `--etcd` / `DISC_ETCD`: the url of the etcd endpoint backing the instance.
- `--minage` / `DISC_MINAGE`: min age of a token for garbage collection.

## History
This package implements a super minimal etcd v2 API built on the currently incomplete [v2v3 package]. We need to do this because the public etcd discovery service has been running on the inefficient v2 storage engine and causing operational burden.

Further, to solve operational issues using the v3 API will enable us to use the backup features of the etcd Operator.
