# Install the container's OS.
#   Derived from: https://www.linode.com/docs/guides/deploy-container-image-to-kubernetes/
FROM alpine:latest as HUGOINSTALL

# Install Hugo.
RUN apk update
RUN apk add hugo

#ENV HUGO_VERSION="0.59.1"

#RUN apk add --update wget

# Install Hugo.
#RUN wget --quiet https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
#tar -xf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
#mv hugo /usr/local/bin/hugo && \
#rm -rf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

# Copy the contents of the current working directory to the hugo-site
# directory. The directory will be created if it doesn't exist.
COPY . /hugo-site

# Use Hugo to build the static site files.
RUN hugo -v --source=/hugo-site --destination=/hugo-site/public

# Install NGINX and deactivate NGINX's default index.html file.
# Move the static site files to NGINX's html directory.
# This directory is where the static site files will be served from by NGINX.
FROM nginx:stable-alpine
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/old-index.html
COPY --from=HUGOINSTALL /hugo-site/public/ /usr/share/nginx/html/

# The container will listen on port 80 using the TCP protocol.
EXPOSE 80