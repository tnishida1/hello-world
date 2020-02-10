pipeline {
    agent {
        label "lead-toolchain-skaffold"
    }
    stages {
        stage('Images Harbor') {
            when {
                branch 'master'
            }
            steps {
                container('skaffold') {
                    sh "make artifactory_creds"
                    sh "printenv"
                    sh "make build"
                }
            }
        }
        stage('Chart Harbor') {
            when {
                branch 'master'
            }
            steps {
                container('skaffold') {
                    sh "make charts_v1"
                    sh "make helm_push_harbor_v1"
                }
            }
        }
    }
}
