#!groovy

properties([disableConcurrentBuilds()])

pipeline {
    agent any
    //triggers { pollSCM('* * * * *') }
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        timestamps()
    }
    stages {
        stage("terraform init cosmoDB") {
            steps {
                echo "================== start terraform init =================="
                dir ('terraform-cosmoDB') {
                    sh 'terraform init'
                }
            }
        }
        stage("terraform plan cosmoDB") {
            steps {
                echo "================== start terraform plan cosmoDB =================="
                dir ('terraform-cosmoDB') {
                    sh 'terraform plan -out cosmo.tfplan'
                }
            }
        }
        stage("terraform apply cosmoDB") {
            steps {
                echo "================== start terraform apply cosmoDB =================="
                dir ('terraform-cosmoDB') {
                    sh 'terraform apply cosmo.tfplan'
                }
            }
        }
        stage("create docker grafana container") {
            steps {
                echo "================== start up container =================="
                dir ("grafana") {
                    sh "docker-compose up -d"
                }
            }
        }
    }
}