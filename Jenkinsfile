pipeline {
  agent none
  stages {
    stage('Build') {
      agent any
      steps {
        echo "building"
        sleep 10
      }
    }
    stage('Test') {
      agent any
      steps {
        echo "testing"
        sleep 30
      }
    }
    stage('Deploy') {
      agent any
      steps {
        echo "deploying"
        stageMessage "sample stage message"
      }
    }
  }
}
