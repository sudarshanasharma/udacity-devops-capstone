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
			    if (!{response.contains("dgffhwefq")}) {
				echo "its there%%%%%%%%%%%%%%%%%%"
                            
                        }
            
		    }
            }
        }
    }
}
