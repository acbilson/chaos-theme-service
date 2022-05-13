FROM docker.io/library/python:3.9.7-alpine3.14 as build

# used by app to determine where the client-side code lives
ENV STATIC_PATH /app/app/static

# install uwsgi dependencies
RUN apk add python3-dev build-base linux-headers pcre-dev

# Installs python packages to the users local folder
WORKDIR /app
COPY ./src/requirements.txt /app/
RUN pip install --user -r requirements.txt

FROM docker.io/library/python:3.9.7-alpine3.14 as base
COPY --from=build /root/.local /root/.local

# (re)installs a few dependencies
RUN apk add pcre-dev git

# load uwsgi config
RUN mkdir -p /etc/chaos-theme-service
COPY ./dist/chaos-theme-service.ini /etc/chaos-theme-service

# install source code
COPY ./src /app/src

#############
# Development
#############

FROM base as dev

# mount content directories here
RUN mkdir -p /mnt/chaos/content

# mount source code volume here
WORKDIR /mnt/src

ENV FLASK_ENV development
ENTRYPOINT ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=80"]

#####
# UAT
#####

FROM base as uat
EXPOSE 80
WORKDIR /app/src
ENV FLASK_ENV production
ENTRYPOINT ["/root/.local/bin/uwsgi", "--ini", "/etc/chaos-theme-service/chaos-theme-service.ini"]

############
# Production
############

FROM base as prod
EXPOSE 80
WORKDIR /app/src
ENV FLASK_ENV production
ENTRYPOINT ["/root/.local/bin/uwsgi", "--ini", "/etc/chaos-theme-service/chaos-theme-service.ini"]
