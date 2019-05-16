pipeline {
  agent none 
  triggers {
      pollSCM('* * * * *')
  }
  stages {
    stage('Stop  previous Docker container') {
        agent any 
        steps {
            sh 'docker exec -i Docker_example pkill node || true && docker stop Docker_example || true && docker rm Docker_example || true'
        }
    }

  stage('Run app in Docker container') {
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
        stage('Delivery') {
          steps {
            sh 'npm start'
          }
        }
      }
    }
  }
}