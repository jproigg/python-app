pipeline {
  agent any
  environment {
      registry = "jproigg/backend-devops-ci-cd"
      registryCredential = 'dockerhub'
      dockerImage = ''
  }

  stages {
    stage('docker version') {
      steps {
        sh 'docker ps'
      }
    }

    stage ('Lint test') {
        agent {
            docker { image 'cytopia/pylint'}
            }
        steps {
            sh "pylint --exit-zero --output-format=parseable --reports=n app.py > reports/pylint.log"
            echo "test results"
        }
    }

    /*stage('compile application and install dependencies') {
      agent { dockerfile true }
      steps {
        echo 'success'
      }
    }

    stage('build docker image') {
      agent any
      steps {
          script {
            dockerImage = docker.build registry
          }
        }
    }

     stage('push to docker hub') {
        agent any
        steps{    
            script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                }
            }
        }
     }

      stage('Stop running container') {
          agent any
          steps {
              sh 'docker ps -f backend-Devops-ci-cd -q | xargs --no-run-if empty docker container stop'
              sh 'docker container ls -a -f backend-Devops-ci-cd -q | xargs -r docker container rm'
            }
        }


      stage('Deploy') {
            agent any
            steps{
                script {
                    dockerImage.run("-p 8096:5000 --rm --name backend-Devops-ci-cd")
                }
            }
        }*/
     
  }
}
