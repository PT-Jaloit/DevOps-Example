pipeline {
  agent none 
  triggers {
      pollSCM('* * * * *')
  }
  stages {
    stage('Run tests') {
        agent {
          docker {
            image 'node:8-alpine'
            args '-p 3000:3000 --name Docker_example'
          }

        }
        stages {
          stage('Build') {
            steps {
              sh 'npm install'
            }
          }
          stage('Test') {
            steps {
              sh 'npm test'
            }
          }
        }
      }

      stage('Deploy app to development') {
          when {
              branch 'Development'
          }
          agent any 
          steps {
              sh 'echo hello'
          }
      }

    stage('Deploy app to production') {
        when {
            branch 'master'
        }
        agent any 
        steps {
            sh 'echo hello'
        }
    }
  }
}