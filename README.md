# docker-btsync

## Build

```
docker build --no-cache -t denisura/btsync .
```

## Usage

### Init new shared folder

```
docker run -d --name btsync-client denisura/btsync
```

### Get secret key for shared folder

```
docker exec -it btsync-client cat /btsync/secret
```

### Get RO secret key for shared folder

```
docker exec -it btsync-client cat /btsync/ro_secret
```

### Sync existing shared folder

```
docker run  -e BTSYNC_SECRET=ATJO57IKDQVC2S6KTCJTLEKECQSK5WMBZ -d --name btsync-client denisura/btsync
```

### Show Btsync help

```
docker exec -it btsync-client btsync --help
docker run --rm -it denisura/btsync btsync --help
```

### Generate new secret key 

```
docker exec -it btsync-client btsync --generate-secret
docker run --rm -it denisura/btsync btsync --generate-secret
```

### Get read-only secret key for existing master secret

```
docker exec -it btsync-client btsync --get-ro-secret <master secret>
docker run --rm -it denisura/btsync btsync --get-ro-secret <master secret>
```

### Run btsync with custom config file

```
docker run -v /tmp/btsync/config:/btsync/btsync.conf  \
           -d --name btsync-client denisura/btsync
```

Verify successful launch

```
docker logs btsync-client
```