# capstone-project-cloud-devops

<h2>Project Overview</h2>

<p> In this project, I applied the skills and knowledge which was developed throughout the Cloud DevOps Nanodegree program. These include:</p>

<ul>
	<li>Working in AWS</li>
	<li>Using Jenkins to implement Continuous Integration and Continuous Deployment</li>
	<li>Building pipelines</li>
	<li>Working with Ansible and CloudFormation to deploy clusters</li>
	<li>Building Kubernetes clusters</li>
	<li>Building Docker containers in pipelines</li>
</ul>

***

<p>I developed a CI/CD pipeline for kubernetes microservices application with Rolling deployment. I opted for Rolling deployment instead of "Blue/Green", as this feature is already present in Kubernetes, and can be implemented by specifying strategy type as "RollingUpdate" in deployment specifications.  using  I developed Continuous Integration steps, such as typographical checking (aka “linting”). I also developed Continuous Deployment steps. These includes:</p>

<ul>
	<li>Pushing the built Docker containers to the Docker repository</li>
	<li>Deploying these Docker containers to a small Kubernetes cluster. For Kubernetes cluster I used AWS EKS. To deploy my Kubernetes cluster using Cloudformation. I ran these from Jenkins as an independent pipeline.</li>
</ul>

***

<h2>Environment Setup</h2>

<ul>
  <li>Create a <code>Dockerfile</code></li>
  <li>Create a <code>Jenkinsfile</code> including all the necessary steps</li>
  <li>Launch EC2 instance with security group configured to allow the SSH port 22, Jenkins port 8080 and Container port 8000 </li>
  <li>Install Jenkins and all the necessary plugins in the EC2 Instance</li>
  <li>Install Jenkins and all the necessary plugins in the EC2 Instance</li>
</ul>


<h2>Deploy App in cluster</h2>

<ul>
  <li>SSH into the EC2 instance configured in <code>Environment Setup</code></li>
  <li>Run script to create cluster with eksctl: <code>./createcluster.sh</code></li>
  <li>Run command to check if cluster is created : <code>eksctl get clusters </code></li>
  <li>When the above command returns EKSCTL CREATED as True, cluster is ready for deployment</li>
  <li>Edit deployment.yml if you wish to change any of the specifications of the deployment or service</li>
  <li>Run script to deploy the application: <code>./create_initial_deployment.sh</code></li>
  <li>The App-URL can be checked by opening browser @ http://EXTERNAL-IP:8000, when the service information is displayed on the console</li>
  
</ul>


<h2>Implement Rolling Deployment on CI/CD pipeline</h2>
<ul>
  <li>From Jenkins UI, select <code>Manage Jenkins</code> and check the box "Scan Repository Trigger Periodically", and assign a short time interval  </li>
  <li>Make any change in the App code from the Github Repository. A new build will be triggered on Jenkins CI/CD pipeline</li>
  <li>Verify that all steps are excecuted correctly and build is successful.Kindly clear the browser cache or use incognito mode to check the App-URL </li>
  <li>If code changes are not proper , and the App crashes, kubernetes will roll back the deployment to the previous image </li>
</ul>
