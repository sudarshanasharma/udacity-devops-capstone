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
        stage('Deploying') {
            steps{
                  echo 'Deploying to AWS...'
                  withAWS(credentials: 'awscli', region: 'us-west-2') {
                      sh "aws eks --region us-west-2 update-kubeconfig --name capstonecluster"
                      sh "kubectl config use-context arn:aws:eks:us-west-2:556332433231:cluster/capstonecluster"
		      sh "kubectl apply -f videodeploy.yml"
                      sh "kubectl set image deployments/capstone-project-cloud-devops capstone-project-cloud-devops=sudarshanas/capstone:latest" 
                      sh "kubectl get nodes"
                      sh "kubectl get deployment"
                      sh "kubectl get pod -o wide"
                      sh "kubectl get service/capstone-project-cloud-devops"
                  }
              }
        }
    }
}
