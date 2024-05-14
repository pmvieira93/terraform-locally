FROM hashicorp/terraform:1.8

COPY terraform /work
COPY terraform-run.sh /work/run.sh

RUN chmod u+x,g+x,o+x /work/run.sh

WORKDIR /work


#ENTRYPOINT ["/bin/sh"]

ENTRYPOINT ["./run.sh"]
