pipeline {
    agent {
        label "lead-toolchain-skaffold"
    }
    stages {
        stage('Images Artifactory') {
            when {
                branch 'master'
            }
            steps {
                container('skaffold') {
                    sh "printenv"
                    script {
                       env.SKAFFOLD_DEFAULT_REPO = "artifactory.toolchain.lead.sandbox.liatr.io/docker-registry/jordan-ignitetest"
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
