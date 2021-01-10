#Backup certs
kubectl get -o yaml \
     --all-namespaces \
     issuer,clusterissuer,certificates,certificaterequests > cert-manager-backup.yaml

#Restore certs
kubectl apply -f cert-manager-backup.yaml