pipeline {
    agent {
        label "lead-toolchain-skaffold"
    }
    stages {
        stage('Images') {
            when {
                branch 'master'
            }
            steps {
                container('skaffold') {
                    sh "make build"
                }
            }
        }
        stage('Chart') {
            when {
                branch 'master'
            }
            steps {
                container('skaffold') {
                    sh "sleep 600"
                    sh "make charts"
                    script {
                        def version = sh ( script: "make version", returnStdout: true).trim()
                        stageMessage "Published new chart: ${version}"
                    }
                }
            }
        }
    }
}
