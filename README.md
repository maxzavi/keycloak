# KeyCloack

Link:  https://www.keycloak.org/


References:

https://www.youtube.com/watch?v=vCZXcCNppA0&list=PL4bT56Uw3S4wEZ0Sp7jrGAX8DMS-MKowg&index=2


Run mysql in docker:

```cmd
docker run -d -e MYSQL_ROOT_PASSWORD=admin -e MYSQL_DATABASE=keycloak -p3306:3306  mysql
```

Use by deploy keycloak with docker standalone, use local database H2:

```cmd
docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:25.0.1 start-dev
```


## Keycloak with mysql

Get IP from mysql: 

```cmd
docker inspect <dockerid>
````

replace in db-url ip

Run keycloak with database mysql:

```cmd
docker run -p 8080:8080 \
        -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=change_me \
        quay.io/keycloak/keycloak:latest \
        start-dev \
        --db=mysql --features=persistent-user-sessions \
        --db-url=jdbc:mysql://172.17.0.2:3306/keycloak --db-username=root --db-password=admin
```

Arg **--features=persistent-user-sessions** allow persist sessions in database


Admin console  in http//localhost:8080


Default realm is master

Create realm **testrealm**

Account users  in http://localhost:8080/realms/testrealm/account


In admin create user, set password and test in url account:  http://localhost:8080/realms/testrealm/account

Create client (app) **backendtest**, create roles reader and writer in client created.


In Realm Rol, create rol **Operator** and asign client rol reader.
In Realm Rol, create rol **Administrator** and asign client rol writer.


Get Access token with:

```cmd
curl --location 'http://localhost:8080/realms/testrealm/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'client_id=backendtest' \
--data-urlencode 'grant_type=password' \
--data-urlencode 'scope=openid' \
--data-urlencode 'username=mzavaletav@gmail.com' \
--data-urlencode 'password=mzavaleta'
```

Valid with

```cmd
curl --location 'http://localhost:8080/realms/testrealm/protocol/openid-connect/userinfo' \
--header 'Authorization: Bearer *****'
```

Add roles to userInfo, in client **backendtest** , go to tab **Client Scopes**, and select **backendtest-dedicated** and add **predefined mapper** named **realm roles** and **client roles**

Select both mappers, and check **Add to usernnfo**

Test in endpoint userInfo

##  Deploy in Cloud Run


User Dockerfile file, using environment variable **KC_HOSTNAME** with https and cloud run url:

```properties
ENV KC_HOSTNAME=https://keycloak-cloudrun-ghyk7w5isa-uc.a.run.app
```
