pipeline {
  environment {
    registry = "sudarshanas/capstone"
    registryCredential = 'dockerhub'
    dockerImage = ''
}
	agent any
	stages {
		stage('Lint HTML'){
			steps {
				sh 'tidy -q -e index.html'
				
			}
		}
        stage('Build Docker Container'){
            steps {
                    script {
              dockerImage = docker.build(registry)
            }
      }
    }
        stage('Build & Push to dockerhub'){
            steps {
                    script {
                docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Cleaning Docker up') {
            steps {
                script {
                    sh "echo 'Cleaning Docker up'"
                    sh "docker system prune -f"
                    }
                }
            }
        stage('Create K8s Cluster') {
            steps {
                withAWS(region:'us-west-2', credentials:'awscli'){
                    sh '''
                            eksctl create cluster \
                            --name capstonecluster \
                            --version 1.18 \
                            --region us-west-2 \
                            --nodegroup-name standard-nodes \
                            --node-type t2.micro \
                            --nodes 2 \
                            --nodes-min 1 \
                            --nodes-max 4 \
                            --zones us-west-2a \
						    --zones us-west-2b \
						    --zones us-west-2c \
                        '''
            }
        }
    }
    	stage('Create config file cluster') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscli') {
					sh '''
						aws eks --region us-west-2 update-kubeconfig --name capstonecluster
					'''
		    	}
    		}
	    }
		stage('Deploy blue container') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscli') {
					sh '''
						kubectl apply -f ./blue-controller.json
					'''
				}
			}
        }
		stage('Deploy green container') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscli') {
					sh '''
						kubectl apply -f ./green-controller.json
					'''
				}
			}
		}
		stage('Create the service in the cluster, redirect to blue') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscli') {
					sh '''				
						kubectl apply -f ./blue-service.json
					'''
				}
			}
		}
		stage('Waiting for Aproval') {
            steps {
                input "Route traffic to Green?"
            }
        }
		stage('Route Service to Cluster, redirecting to green') {
			steps {
				withAWS(region:'us-west-2', credentials:'awscli') {
					sh '''
						kubectl apply -f ./green-service.json
					'''
				}
			}
        }
    }
}
