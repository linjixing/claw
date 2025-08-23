# From Ubuntu 22.04

# Softwares

software | version
--- | ---
python | 3.10.12
supervisord | 4.2.1
ttyd | 1.7.7
trzsz | 1.1.8

# Variables

```
export UNAME="linjixing"
export PASSWD="password"
export RSA="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQ51EmSCCjZHF0JGaDeZai2B2GBMEhcB4VxggLm92J8qHiLAL+OXv6qjhDn8Ip1bOdedODI0/RLg6jLXdcg3IgeLnxDQ4MOk79k7terEbeR49Vln5oFkJjoiiVB4u6OsDPf3x2BEX7fCMPlUB2OQrmJbU1hTIZKZCq0kfQN1w4kIomPsqLLq/4x1lUtwZZm3pJMKv+pNq22NkSeFn8/cUIoSEgP7rQeRV7V8sWG87FtZTdr1bYEY6x8Bsijcqv+8ZASI0JKWklKT71VFSqd6CYwkL+1SUk4LOyI9DraxUEXMPdMc5fQgP7ZY8yz/I0d6UsEmXRLeu4GE7mEpjvqEeB"
export TTYD_PORT=7681
export CONTAINER="claw"
export TAG="$(date +'%y.%-m.%-d')"
```

# Build

```
docker build -t $CONTAINER:$TAG .
```

# Usage

- Login as root

```
docker stop $CONTAINER
docker rm $CONTAINER
docker run -dit --name $CONTAINER -h $CONTAINER -p $TTYD_PORT:$TTYD_PORT $CONTAINER:$TAG
```

- Login as $UNAME with $PASSWD

```
docker stop $CONTAINER
docker rm $CONTAINER
docker run -dit --name $CONTAINER -h $CONTAINER -p $TTYD_PORT:$TTYD_PORT -e USER=$UNAME -e PASSWD=$PASSWD $CONTAINER:$TAG
```

- Login as $UNAME with $PASSWD and $RSA

```
docker stop $CONTAINER
docker rm $CONTAINER
docker run -dit --name $CONTAINER -h $CONTAINER -p $TTYD_PORT:$TTYD_PORT -e USER=$UNAME -e PASSWD=$PASSWD -e RSA="$RSA" $CONTAINER:$TAG
```

# Push

```
docker logout
docker login -u $UNAME
```

```
docker tag $CONTAINER:$TAG $UNAME/$CONTAINER:$TAG
docker push $UNAME/$CONTAINER:$TAG

docker tag $CONTAINER:$TAG $UNAME/$CONTAINER:latest
docker push $UNAME/$CONTAINER:latest
```

# Docs

