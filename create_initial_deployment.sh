 #!/bin/sh
 
aws eks --region us-west-2 update-kubeconfig --name capstonecluster
kubectl config use-context arn:aws:eks:us-west-2:556332433231:cluster/capstonecluster
kubectl apply -f deployment.yml --record
sleep 2m
kubectl get nodes
kubectl get deployment                      
kubectl get pod -o wide
kubectl get service/capstone-project-cloud-devops
