#  Stage 1: alpine jdk image to build the app
FROM openjdk:8-jdk-alpine AS builder

WORKDIR code
#WORKDIR used to set the working directory (named directory as 'code') for any instruction.
COPY ./src .
#COPY takes all files within my src folder and copies them to 'code' directory of container.

RUN javac org/AzinTelecom/Main.java #reads java files and compile them into class files
RUN pwd                             #shows the working directory
RUN ls org/AzinTelecom/             #lists the files inside AzinTelecom folder: which is Main class


# STAGE 2: alpine jre image to run the app
FROM openjdk:8u212-jre-alpine3.9
WORKDIR /java
#set the working directory named as java
COPY --from=builder /code/org/AzinTelecom/Main.class ./
#COPY used to take compiled Main.class and copies it to java directory
CMD java Main
#CMD used to run the Main class



# -----------------PLEASE FOLLOW THIS COMMANDS TO RUN DOCKERFILE: -----------------------
# docker build  -t devops-task:1.0 .
# docker run devops-task:1.0