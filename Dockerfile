FROM alpine:latest
MAINTAINER ardroci

ENV seed_qakbot '0'
ENV seed_corebot '498698544'
ENV nr_domains '5'
ENV tld 'ardroci.com'
ENV dns_query_type 'udp'
ENV dns_name_server '8.8.8.8'
ENV dns_timeout '5'
ENV dns_source_ip_address '0.0.0.0'
ENV dns_source_port '0'

RUN apk update \
	&& apk add git python3 \
	&& ln -sf python3 /usr/bin/python \
	&& python3 -m ensurepip \
	&& pip3 install --no-cache --upgrade pip setuptools \
	&& git clone https://github.com/ardroci/domain-generation-algorithm.git

WORKDIR /domain-generation-algorithm
RUN pip3 install -r requirements.txt

ENTRYPOINT ["sh", "-c", "python3 skeleton.py --seed-qakbot $seed_qakbot --seed-corebot $seed_corebot --nr-domains $nr_domains --tld $tld --dns-query-type $dns_query_type $type --dns-name-server $dns_name_server --dns-timeout $dns_timeout  --dns-source $dns_source_ip_address --dns-source-port $dns_source_port"]