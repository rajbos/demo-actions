FROM ubuntu:20.04

LABEL "com.github.actions.name"="My Docker Action"
LABEL "com.github.actions.description"="My Docker Action"
LABEL "com.github.actions.icon"="mic"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/devops-actions/docker-action-demo"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
