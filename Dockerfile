FROM alpine:3.11

LABEL "maintainer"="ryof <ryo.furuyama@gmail.com>" \
      "com.github.actions.name"="CloudFormation lint action" \
      "com.github.actions.description"="CloudFormation lint action using cfn-lint" \
      "com.github.actions.icon"="check-circle" \
      "com.github.actions.color"="green"

RUN apk --no-cache add python3 ca-certificates && update-ca-certificates
RUN pip3 install --upgrade pip && \
    pip3 install cfn-lint
RUN cfn-lint --update-specs

COPY matcher.json /matcher.json
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["**/*.yaml", "**/*.yml"]