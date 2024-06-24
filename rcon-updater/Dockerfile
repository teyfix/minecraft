FROM itzg/rcon-cli:1.6.7-ubuntu

WORKDIR /usr/src/app

COPY ./scripts ./

RUN chmod +x *.sh

ENTRYPOINT [ "/bin/bash" ]

CMD [ "/usr/src/app/update.sh" ]
