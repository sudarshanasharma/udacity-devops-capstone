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
        stage('Clean Docker up') {
            steps {
                script {
                    sh "echo 'Cleaning Docker up'"
                    sh "docker system prune -f"
                    }
                }
            }
        stage('Deploy to cluster') {
            steps{
                  echo 'Deploying to AWS...'
                  withAWS(credentials: 'awscli', region: 'us-west-2') {
                      sh "aws eks --region us-west-2 update-kubeconfig --name capstonecluster"
                      sh "kubectl config use-context arn:aws:eks:us-west-2:556332433231:cluster/capstonecluster"
		      sh "kubectl set image deployments/capstone-project-cloud-devops capstone-project-cloud-devops=sudarshanas/capstone:latest" 
		      sh "kubectl apply -f deployment.yml --record"  
                      sh "kubectl get nodes "
                      sh "kubectl get deployment"
                      sh "kubectl get pod -o wide"
                      sh "kubectl get service/capstone-project-cloud-devops"
                  }
              }
        }
        stage ('Check curl response to URL and revert if needed') {
            steps {
		    script {
		                 def response = sh(script: 'curl http://afa2a891f22f346919416363ec94c19d-1994734675.us-west-2.elb.amazonaws.com:8000', returnStdout: true)
                            echo response
			    if (response.contains("Udacity") == true) {
				 withAWS(credentials: 'awscli', region: 'us-west-2') {
			            	sh "kubectl rollout undo deployment capstone-project-cloud-devops"
					sh "kubectl rollout history deployment/capstone-project-cloud-devops"
                                        sh "kubectl get deployment"
                                        sh "kubectl get pod -o wide"
                                        sh "kubectl get service/capstone-project-cloud-devops"
				 }
                        }
		      }
            }
        }
    }
}
