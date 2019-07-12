git clone https://github.com/LeoCavaille/k8s-workshop
ln -s /root/k8s-workshop/assets/ /root/assets

# set labels for static pods
sed -i '/labels:/a \ \ \ \ pod_name: etcd-master' /etc/kubernetes/manifests/etcd.yaml
sed -i '/labels:/a \ \ \ \ kube_namespace: kube-system' /etc/kubernetes/manifests/etcd.yaml

sed -i '/labels:/a \ \ \ \ pod_name: kube-apiserver-master' /etc/kubernetes/manifests/kube-apiserver.yaml
sed -i '/labels:/a \ \ \ \ kube_namespace: kube-system' /etc/kubernetes/manifests/kube-apiserver.yaml

sed -i '/labels:/a \ \ \ \ pod_name: kube-controller-manager-master' /etc/kubernetes/manifests/kube-controller-manager.yaml
sed -i '/labels:/a \ \ \ \ kube_namespace: kube-system' /etc/kubernetes/manifests/kube-controller-manager.yaml

sed -i '/labels:/a \ \ \ \ pod_name: kube-scheduler-master' /etc/kubernetes/manifests/kube-scheduler.yaml
sed -i '/labels:/a \ \ \ \ kube_namespace: kube-system' /etc/kubernetes/manifests/kube-scheduler.yaml

# add audit logs to the apiserver
mkdir -p /etc/kubernetes/audit-policies
cp assets/00-env-prep/policy.yaml /etc/kubernetes/audit-policies/policy.yaml

# update apiserver config
sed -i '/tls-private-key-file/a \ \ \ \ - --audit-policy-file=/etc/kubernetes/audit-policies/policy.yaml' /etc/kubernetes/manifests/kube-apiserver.yaml
sed -i '/audit-policy-file/a \ \ \ \ - --audit-log-path=/var/log/kubernetes/apiserver/audit.log' /etc/kubernetes/manifests/kube-apiserver.yaml
sed -i '/volumes:/a \ \ - {hostPath: {path: /etc/kubernetes/audit-policies, type: DirectoryOrCreate}, name: k8s-audit-policies}' /etc/kubernetes/manifests/kube-apiserver.yaml
sed -i '/volumeMounts:/a \ \ \ \ - {mountPath: /etc/kubernetes/audit-policies, name: k8s-audit-policies, readOnly: true}' /etc/kubernetes/manifests/kube-apiserver.yaml
sed -i '/volumes:/a \ \ - {hostPath: {path: /var/log/kubernetes, type: DirectoryOrCreate}, name: k8s-logs}' /etc/kubernetes/manifests/kube-apiserver.yaml
sed -i '/volumeMounts:/a \ \ \ \ - {mountPath: /var/log/kubernetes, name: k8s-logs}' /etc/kubernetes/manifests/kube-apiserver.yaml
