pipeline {
  agent none 
  triggers {
      pollSCM('* * * * *')
  }
  environment {
        GOOGLE_PROJECT_ID = 'turing-citizen-239109';
        GOOGLE_SERVICE_ACCOUNT_KEY = credentials('gcp_service_account');
  }
  stages {
    stage('Run tests') {
        agent {
          docker {
            image 'node:8-alpine'
            args '-p 3000:3000'
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
            sh '''
            curl -o /tmp/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-247.0.0-linux-x86_64.tar.gz;
					  tar -xvf /tmp/google-cloud-sdk.tar.gz -C /tmp/;
					  /tmp/google-cloud-sdk/install.sh -q;
            source /tmp/google-cloud-sdk/path.bash.inc;
            
					  gcloud config set project ${GOOGLE_PROJECT_ID};
            gcloud auth activate-service-account --key-file ${GOOGLE_SERVICE_ACCOUNT_KEY};
            gcloud config list;
            gcloud app deploy --version=v01;
            '''
        }
    }
  }
}
