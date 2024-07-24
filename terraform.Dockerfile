FROM hashicorp/terraform:1.8

COPY ./terraform /terraform

#RUN rm -rf /terraform/provider.tf /terraform/variables.tf /terraform/data.tf
#COPY ./local-dev/terraform/*.tf /terraform

COPY ./terraform-run.sh /terraform/apply.sh


RUN dos2unix /terraform/apply.sh
RUN chmod u+x,g+x,o+x /terraform/apply.sh

WORKDIR /terraform

ENTRYPOINT ["/bin/sh","/terraform/apply.sh"]