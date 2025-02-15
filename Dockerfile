FROM quay.io/keycloak/keycloak:latest

# Set environment variables for the database connection
ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://keycloak_postgres:5432/keycloak
ENV KC_DB_USERNAME=keycloak
ENV KC_DB_PASSWORD=password
ENV KC_HOSTNAME=localhost

# Copy the custom theme to Keycloak
RUN mkdir -p /opt/keycloak/themes/custom-theme
# Copy the custom theme into the Keycloak themes directory
COPY themes/custom-theme/custom.v2 /opt/keycloak/themes/custom-theme

# Copy the realm export file to the Keycloak import directory
COPY export_data_export /opt/keycloak/data/import

# Expose port 8080
EXPOSE 8080

# Command to start Keycloak and import the realm with OVERWRITE_EXISTING strategy
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--import-realm", "--import-strategy=OVERWRITE_EXISTING"]