FROM bibichannel/ubuntu:v1

COPY ./docker-entrypoint.sh /snort_src/
COPY ./snort.conf /etc/snort/snort.config
WORKDIR /snort_src

RUN chmod +x ./docker-entrypoint.sh

RUN wget https://www.snort.org/downloads/snort/daq-2.0.7.tar.gz
RUN tar -xvzf daq-2.0.7.tar.gz 
RUN cd daq-2.0.7 && autoreconf -f -i
RUN cd daq-2.0.7 && ./configure && make && make install

RUN wget https://www.snort.org/downloads/snort/snort-2.9.20.tar.gz
RUN tar -xvzf snort-2.9.20.tar.gz

RUN ln -s /usr/include/tirpc/rpc/* /usr/include/rpc
RUN ln -s /usr/include/tirpc/rpcsvc/* /usr/include/rpcsvc
RUN ln -s /usr/include/tirpc/netconfig.h /usr/include

RUN cd snort-2.9.20 && ./configure --enable-sourcefire && make && make install

ENTRYPOINT ["bash","docker-entrypoint.sh"]
