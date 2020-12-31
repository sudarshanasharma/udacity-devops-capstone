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
        
		
	  stage('Build Docker Image') {
              steps {
                  sh 'docker build  --no-cache=true -t sudarshanas/capstone:latest .'
              }
         }
 
        stage('Build & Push to dockerhub'){
            steps {
                    script {
                docker.withRegistry('', registryCredential) {
                          sh 'docker push sudarshanas/capstone:latest'
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
		      sh "kubectl apply -f deployment.yml"
		      sh "kubectl rollout status deployment capstone-project-cloud-devops"
                      sh "kubectl get nodes"
                      sh "kubectl get deployment"
                      sh "kubectl get pod -o wide"
                      sh "kubectl get service/capstone-project-cloud-devops"
                  }
              }
        }
        stage ('Check curl response to URL and revert if needed') {
            steps {
		    script {
		                 def response = sh(script: 'curl http://ae76f0ccf426e44b0b14acee14cbd17e-1789899296.us-west-2.elb.amazonaws.com:8000', returnStdout: true)
                            echo response
			    if (response.contains("Udacity") == false) {
				 withAWS(credentials: 'awscli', region: 'us-west-2') {
			            	sh "kubectl rollout undo deployment capstone-project-cloud-devops"
					sh "kubectl rollout status deployment capstone-project-cloud-devops"
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
