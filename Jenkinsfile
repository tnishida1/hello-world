pipeline {
  agent none
  stages {
    stage('Build') {
      agent any
      steps {
        echo "building"
        sleep 6
      }
    }
    stage('Test') {
      agent any
      steps {
        echo "testing"
        sleep 6
      }
    }
  }
}
