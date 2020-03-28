pipeline {
   agent any

   stages {
      stage('Build docker-compose') {
         steps {
             sh "docker-compose build"
         }
      }
      stage('Run tor&tor consumer images') {
         steps {
            // Get some code from a GitHub repository
            // manipulate tor project to listen on port 7343
            sh "docker-compose up --abort-on-container-exit --exit-code-from ubuntu"
         }
      }
   }
   post {
       always {
           echo 'Pipeline finished'
           sh "docker-compose down"
       }
       success {
           echo 'Build ended sucessfully'
       }
       failure {
           echo 'Build failed'
       }
   }
}
