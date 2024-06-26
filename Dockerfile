FROM quay.io/keycloak/keycloak:latest
# change these values to point to a running postgres instance
ENV KC_DB=mysql
ENV KC_DB_URL=jdbc:mysql://ip:3306/keycloak
ENV KC_DB_USERNAME=*******
ENV KC_DB_PASSWORD="*****"
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
ENV KC_HOSTNAME=https://keycloak-cloudrun-ghyk7w5isa-uc.a.run.app
ENTRYPOINT ["/opt/keycloak/bin/kc.sh","start-dev","--features=persistent-user-sessions"]



