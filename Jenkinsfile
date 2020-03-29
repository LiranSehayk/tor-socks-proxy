pipeline {
   agent any 

   options {
       disableConcurrentBuilds()
   }
   stages {
      stage('Build docker-compose') {
         steps {
             // build images from docker-compose file
            ansiColor('xterm') {
                sh "docker-compose build"
            }
         }
      }
      stage('Run tor&tor consumer images') {
         steps {
            // start docker-compose
            // stop all containers once one of them is exiting 
            // get the exit code from ubuntu service
            ansiColor('xterm') {
                sh "docker-compose up --abort-on-container-exit --exit-code-from ubuntu"
            }
            
         }
      }
   }
   post {
       always {
           echo 'Pipeline finished'
           // stop docker-compose on any build status 
           sh "docker-compose down"
           cleanWs()
       }
       success {
           echo 'Build ended sucessfully'
       }
       failure {
           echo 'Build failed'
       }
   }
}

