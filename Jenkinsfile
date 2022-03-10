pipeline {
  agent none
  environment {
      registry = "jproigg/backend-devops-ci-cd"
      registryCredential = 'dockerhub'
      dockerImage = ''
  }

  stages {
    stage('Check images') {
      agent any
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

    stage("unit test") {
      agent any
      steps {
        sh 'python3 test.py'
      }
    }

    stage('Scan') {
      agent any
      steps {
        withSonarQubeEnv(installationName: 'jenkins-sonar') { 
          sh 'python app.py sonar:sonar'
        }
      }
    }

    stage("Quality Gate") {
      agent any
      steps {
        timeout(time: 1, unit: 'MINUTES') {
          waitForQualityGate abortPipeline: true
        }
      }
    }

    stage('Install dependencies and compile application') {
      agent { dockerfile true }
      steps {
        echo 'success'
      }
    }

    stage('Stop and remove running container') {
        agent any
        steps {
            sh 'docker stop backend-Devops-ci-cd || true && docker rm backend-Devops-ci-cd || true'
            }
        }    

    stage('Build docker image') {
      agent any
      steps {
          script {
            dockerImage = docker.build registry
          }
        }
    }

     stage('Push image to docker hub') {
        agent any
        steps{    
            script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                }
            }
        }
     }


      stage('Deploy application') {
            agent any
            steps{
                script {
                    dockerImage.run("-p 8096:5000 --rm --name backend-Devops-ci-cd")
                }
            }
        }
     
  }
}
