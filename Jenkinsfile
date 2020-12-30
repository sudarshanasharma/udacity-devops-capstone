pipeline {
  environment {
    registry = "sudarshanas/capstone"
    registryCredential = 'dockerhub'
    dockerImage = ''
}
	agent any
	stages {
        stage ('Checking curl response') {
            steps {
		    script {
			    def response = sh(script: 'curl https://www.google.com', returnStdout: true)
                             echo "Status: ${response.status}"
                             echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + response
                    
			    if (${response.status} != 200) {
				sh "kubectl rollout undo deployment capstone-project-cloud-devops"
                            
                        }
            
		    }
            }
        }
    }
}
