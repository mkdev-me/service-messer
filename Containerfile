FROM public.ecr.aws/docker/library/ruby:2.7.3-slim

ADD ./ /app

WORKDIR /app

RUN apt-get update && \
    apt install ruby-dev build-essential libpq-dev -y && \
    bundle install && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt /var/lib/dpkg /var/lib/cache /var/lib/log && \
    chmod +x /app/bin/entrypoint.sh

ENTRYPOINT /app/bin/entrypoint.sh
