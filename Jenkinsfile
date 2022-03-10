pipeline {
  agent any
  environment {
      registry = "jproigg/backend-devops-ci-cd"
      registryCredential = 'dockerhub'
      dockerImage = ''
  }

  stages {
    stage('Checks images') {
      steps {
        sh 'docker ps'
      }
    }

    stage ('Lint test') {
        agent {
            docker { image 'eeacms/pylint'}
            }
        steps {
            sh "pylint app.py --exit-zero"
        }
    }

    stage('Install dependencies and compile application') {
      agent { dockerfile true }
      steps {
        echo 'success'
      }
    }

    stage('Stops and removes running container') {
        agent any
        steps {
            sh 'docker stop backend-Devops-ci-cd || true && docker rm backend-Devops-ci-cd || true'
            }
        }    

    stage('Builds docker image') {
      agent any
      steps {
          script {
            dockerImage = docker.build registry
          }
        }
    }

     stage('Pushes image to docker hub') {
        agent any
        steps{    
            script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                }
            }
        }
     }


      stage('Deploys application') {
            agent any
            steps{
                script {
                    dockerImage.run("-p 8096:5000 --rm --name backend-Devops-ci-cd")
                }
            }
        }
     
  }
}
