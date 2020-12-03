
### Mongo Db stack

``` sh
docker stack deploy -c mongo-stack.yml mongo-stack-idp
docker stack rm mongo-stack-idp
```

### MySql Db stack

``` sh
docker stack deploy -c mysql-stack.yml mysql-stack-idp
docker stack rm mysql-stack-idp
```



### Other examples

``` sh
docker network create --driver bridge mongonetwork
docker run --name mongo-idp --network mongonetwork --hostname mongo-idp -p 27017:27017 -d mongo:latest
docker run -it --rm --name mongo-express --network mongonetwork -p 8181:8081 -e ME_CONFIG_OPTIONS_EDITORTHEME="ambiance" -e ME_CONFIG_MONGODB_SERVER="mongo-idp" -e ME_CONFIG_BASICAUTH_USERNAME="root" -e ME_CONFIG_BASICAUTH_PASSWORD="12345" mongo-express
```
