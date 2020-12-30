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
			    def result = response.findAll { it.contains('twitter') }
      
			    if (result) {
				echo "its there%%%%%%%%%%%%%%%%%%"
                            
                        }
            
		    }
            }
        }
    }
}
