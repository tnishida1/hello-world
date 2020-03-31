pipeline {
    agent {
        label "lead-toolchain-skaffold"
    }
    stages {
        stage('Images Harbor') {
            steps {
                container('skaffold') {
                    sh "sleep 500"
                    sh "make artifactory_creds"
                    sh "printenv"
                    sh "make build"
                }
            }
        }
        stage('Chart Harbor') {
            steps {
                container('skaffold') {
                    sh "make charts_v1"
                    sh "make helm_push_harbor_v1"
                }
            }
        }
    }
}
