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
        stage('Deploying') {
            steps{
                  echo 'Deploying to AWS...'
                  withAWS(credentials: 'awscli', region: 'us-west-2') {
                      sh "aws eks --region us-west-2 update-kubeconfig --name capstonecluster"
                      sh "kubectl config use-context arn:aws:eks:us-west-2:556332433231:cluster/capstonecluster --record"
		      sh "kubectl set image deployments/capstone-project-cloud-devops capstone-project-cloud-devops=sudarshanas/capstone:latest --record" 
		      sh "kubectl apply -f deployment.yml --record"  
                      sh "kubectl get nodes "
                      sh "kubectl get deployment"
                      sh "kubectl get pod -o wide"
                      sh "kubectl get service/capstone-project-cloud-devops"
                  }
              }
        }
        stage ('Checking curl response') {
            steps {
		    script {
			    final String url = "http://a57f410fc160c4be08dd2434bc07457e-1373923847.us-west-2.elb.amazonaws.com:8000"
			    final def (String response, int code) =
                            sh(script: "curl -s -w '\\n%{response_code}' $url", returnStdout: true)
                                .trim()
                                .tokenize("\n")

                        echo "HTTP response status code: $code"
			echo $response
			flag = ( $response | grep "Welcome")
			echo $flag
                        if (!flag) {
				sh "kubectl rollout undo deployment capstone-project-cloud-devops"
                            
                        }
            
		    }
            }
        }
    }
}
