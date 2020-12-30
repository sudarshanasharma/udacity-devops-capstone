import groovy.json.JsonSlurper
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
			     def response = httpRequest "https://www.google.com"
			     def json = new JsonSlurper().parseText(response.content)
                             echo "*********************************************"
                             echo "Status: ${response.status}"
                             echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
                    
			    if (${response.status} != 200) {
				sh "kubectl rollout undo deployment capstone-project-cloud-devops"
                            
                        }
            
		    }
            }
        }
    }
}
