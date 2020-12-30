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
                             echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + response
                    
			    if (0) {
				sh "kubectl rollout undo deployment capstone-project-cloud-devops"
                            
                        }
            
		    }
            }
        }
    }
}
