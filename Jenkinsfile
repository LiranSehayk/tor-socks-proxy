pipeline {
   agent any

   stages {
      stage('Checkout') {
         steps {
            // Get some code from a GitHub repository
            git 'https://github.com/liranSehayk/tor-socks-proxy.git'

            // manipulate tor project to listen on port 7343
            //sh "echo 'MaxCircuitDirtiness 10' >> torrc"
            //sh "sed -i 's/9150/7343/g' torrc"

         }
      }
      stage('Start the Tor&Sample containers') {
          steps {
              sh "echo aaaaaa"
          }
          
      }
   }
}

