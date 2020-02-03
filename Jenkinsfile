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
                    sh "printenv"
                    script {
                        env.SKAFFOLD_DEFAULT_REPO = "harbor.toolchain.lead.sandbox.liatr.io/jlab"
                    }
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
                    sh "make charts"
                    sh "make helm_push_harbor"
                    script {
                        def version = sh ( script: "make version", returnStdout: true).trim()
                        stageMessage "Published new chart: ${version}"
                    }
                }
            }
        }
    }
}
