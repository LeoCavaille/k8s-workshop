git clone https://github.com/LeoCavaille/k8s-workshop
ln -s /root/k8s-workshop/assets/ /root/assets

# Deleting permissive rbac policy
until curl -ksf https://localhost:6443/healthz ;
do 
    sleep 5
done
kubectl delete clusterrolebinding permissive-binding

# add audit logs to the apiserver
mkdir -p /etc/kubernetes/audit-policies
cp assets/00-env-prep/policy.yaml /etc/kubernetes/audit-policies/policy.yaml

# update apiserver config
grep "audit-policy-file" /etc/kubernetes/manifests/kube-apiserver.yaml || \
	sed -i '/tls-private-key-file/a \ \ \ \ - --audit-policy-file=/etc/kubernetes/audit-policies/policy.yaml' /etc/kubernetes/manifests/kube-apiserver.yaml

grep "audit-log-path" /etc/kubernetes/manifests/kube-apiserver.yaml || \
	sed -i '/audit-policy-file/a \ \ \ \ - --audit-log-path=/var/log/kubernetes/apiserver/audit.log' /etc/kubernetes/manifests/kube-apiserver.yaml

grep "path: /etc/kubernetes/audit-policies" /etc/kubernetes/manifests/kube-apiserver.yaml || \
	sed -i '/volumes:/a \ \ - {hostPath: {path: /etc/kubernetes/audit-policies, type: DirectoryOrCreate}, name: k8s-audit-policies}' /etc/kubernetes/manifests/kube-apiserver.yaml

grep "mountPath: /etc/kubernetes/audit-policies" /etc/kubernetes/manifests/kube-apiserver.yaml || \
	sed -i '/volumeMounts:/a \ \ \ \ - {mountPath: /etc/kubernetes/audit-policies, name: k8s-audit-policies, readOnly: true}' /etc/kubernetes/manifests/kube-apiserver.yaml

grep "path: /var/log/kubernetes" /etc/kubernetes/manifests/kube-apiserver.yaml || \
	sed -i '/volumes:/a \ \ - {hostPath: {path: /var/log/kubernetes, type: DirectoryOrCreate}, name: k8s-logs}' /etc/kubernetes/manifests/kube-apiserver.yaml

grep "mountPath: /var/log/kubernetes" /etc/kubernetes/manifests/kube-apiserver.yaml || \
	sed -i '/volumeMounts:/a \ \ \ \ - {mountPath: /var/log/kubernetes, name: k8s-logs}' /etc/kubernetes/manifests/kube-apiserver.yaml
