pipeline {
  agent none
  stages {
    stage('Build') {
      agent any
      steps {
        echo "building"
        sleep 5
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
