# From Ubuntu 22.04

# Softwares

software | version
--- | ---
supervisord | 4.2.1
nginx | 1.18.0
python | 3.10.12
ttyd | 1.7.7
trzsz | 1.1.8

# Environment Variables

```
export USER=linjixing
export CONTAINER=claw
export TAG=$(date +'%y.%-m.%-d')
```

# Build and Push

```
docker login
```

```
docker build --no-cache -t $CONTAINER:$TAG .

docker tag $CONTAINER:$TAG $USER/$CONTAINER:$TAG
docker push $USER/$CONTAINER:$TAG

docker tag ghcr.io/$CONTAINER:$TAG $USER/$CONTAINER:$TAG
docker push ghcr.io/$USER/$CONTAINER:$TAG
```

# Usage

```
docker run -dit --name $CONTAINER -h $CONTAINER -e USER=$USER -p 7681:7681 $CONTAINER:$TAG
```

```
docker pull $USER/$CONTAINER:$TAG
docker run -dit --name $CONTAINER -h $CONTAINER -e USER=$USER -p 7681:7681 $USER/$CONTAINER:$TAG
```

```
docker pull ghcr.io/$USER/$CONTAINER:$TAG
docker run -dit --name $CONTAINER -h $CONTAINER -e USER=$USER -p 7681:7681 ghcr.io/$USER/$CONTAINER:$TAG
```

# Docs
