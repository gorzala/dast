FROM quay.io/keycloak/keycloak:20.0 as builder

ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:20.0
COPY --from=builder /opt/keycloak/ /opt/keycloak/
WORKDIR /opt/keycloak

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]