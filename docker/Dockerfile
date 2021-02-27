FROM swaggerapi/swagger-ui:v3.44.0

ENV API_URL="http://localhost:8080/swagger.yaml"
ENV API_KEY="**None**"
ENV OAUTH_CLIENT_ID="**None**"
ENV OAUTH_CLIENT_SECRET="**None**"
ENV OAUTH_REALM="**None**"
ENV OAUTH_APP_NAME="**None**"
ENV OAUTH_ADDITIONAL_PARAMS="**None**"
ENV SWAGGER_JSON="/app/swagger.yaml"
ENV PORT=80

WORKDIR /app

COPY ./nginx.conf /etc/nginx/
COPY ./docker-run.sh /usr/share/nginx/

EXPOSE $PORT

ENTRYPOINT ["sh", "/usr/share/nginx/docker-run.sh"]