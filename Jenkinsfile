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
			     def patchOrg = """
                                               {"description": "$description"}    
                                            """
			     def response = httpRequest acceptType: 'APPLICATION_JSON', contentType: 'APPLICATION_JSON', httpMode: 'PATCH', requestBody: patchOrg, url: "https://www.google.com"
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
