pipeline {
  agent any
  environment {
      registry = "jproigg/backend-devops-ci-cd"
      registryCredential = 'dockerhub'
      dockerImage = ''
  }

  stages {
    stage('check images') {
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

    stage('install dependencies and compile application') {
      agent { dockerfile true }
      steps {
        echo 'success'
      }
    }

    stage('stops and removes running container') {
        agent any
        steps {
            sh 'docker stop backend-Devops-ci-cd || true && docker rm backend-Devops-ci-cd || true'
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


      stage('Deploy') {
            agent any
            steps{
                script {
                    dockerImage.run("-p 8096:5000 --rm --name backend-Devops-ci-cd")
                }
            }
        }
     
  }
}
