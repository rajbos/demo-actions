FROM ubuntu:20.04

LABEL "com.github.actions.name"="My Docker Action"
LABEL "com.github.actions.description"="My Docker Action"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
