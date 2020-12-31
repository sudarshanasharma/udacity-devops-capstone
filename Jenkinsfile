pipeline {
  environment {
    registry = 'sudarshanas/capstone'
    registryCredential = 'dockerhub'
	  dockerTag = sh(returnStdout: true, script: 'echo ${BUILD_ID}')
}
	agent any
	stages {
		stage('Lint HTML'){
			steps {
				sh 'tidy -q -e index.html'
				
			}
		}
        
		
	  stage('Build and push Docker Image') {
              steps {
		      script {
			      docker.withRegistry('', registryCredential){
				      sh 'docker build  --no-cache=true -t ${registry}:${dockerTag}  .'
				      sh 'docker push ${registry}:${dockerTag}'
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
                      sh "kubectl set image deployments/capstone-project-cloud-devops capstone-project-cloud-devops=${registry}:${dockerTag}"
		      sh "template = cat deployment.yml | sed 's/{{LATEST_IMAGE}}/${registry}:${dockerTag}/g' "
		      sh 'echo "$template" | kubectl apply -f -'
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
		                 def response = sh(script: 'curl http://a55df19728a8649e7995c96d038e9d52-1142176442.us-west-2.elb.amazonaws.com:8000', returnStdout: true)
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
