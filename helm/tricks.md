# Delete CRDs

1. remove the CRD finalizer blocking on custom resource cleanup
   kubectl patch crd/crontabs.stable.example.com -p '{"metadata":{"finalizers":[]}}' --type=merge

2. now the CRD can be deleted (orphaning custom resources in etcd)
  kubectl delete -f crd.yaml

3. when the CRD is recreated, it resurfaces the existing custom resources
   kubectl create -f crd.yaml

4. the custom resources can now be edited to remove finalizers
   kubectl patch crontab/my-new-cron-object -p '{"metadata":{"finalizers":[]}}' --type=merge

5. and now both custom resource and CRD can be deleted
   kubectl delete -f crd.yaml

# Purge kubedb
curl -fsSL https://github.com/kubedb/installer/raw/v0.13.0-rc.0/deploy/kubedb.sh \
    | bash -s -- --uninstall --purge

# Replace affinity
        #{{- tpl ( .Values.affinity) . | nindent 8 -}}

# glusterfs CLI
1. log into hekiti
2. HEKETI_CLI_KEY=$HEKETI_USER_KEY HEKETI_CLI_USER=admin heketi-cli volume list

# Template helpers
http://masterminds.github.io/sprig/
