echo "== nodeup node config starting =="
ensure-install-dir

cat > kube_env.yaml << __EOF_KUBE_ENV
Assets:
- ${kubelet_sha}@https://storage.googleapis.com/kubernetes-release/release/v${kubernetes_version}/bin/linux/amd64/kubelet
- ${kubectl_sha}@https://storage.googleapis.com/kubernetes-release/release/v${kubernetes_version}/bin/linux/amd64/kubectl
- 1d9788b0f5420e1a219aad2cb8681823fc515e7c@https://storage.googleapis.com/kubernetes-release/network-plugins/cni-0799f5732f2a11b329d9e3d51b9c8f2e3759f2ff.tar.gz
- ${utils_sha}@https://kubeupv2.s3.amazonaws.com/kops/${kops_version}/linux/amd64/utils.tar.gz
ClusterName: ${cluster_fqdn}
ConfigBase: s3://${kops_s3_bucket_id}/${cluster_fqdn}
InstanceGroupName: ${autoscaling_group_name}
Tags:
- _automatic_upgrades
- _aws
${kubernetes_master_tag}
- _networking_cni
channels:
- s3://${kops_s3_bucket_id}/${cluster_fqdn}/addons/bootstrap-channel.yaml
protokubeImage:
  hash: ${protokube_sha}
  name: protokube:${kops_version}
  source: https://kubeupv2.s3.amazonaws.com/kops/${kops_version}/images/protokube.tar.gz

__EOF_KUBE_ENV

download-release
echo "== nodeup node config done =="
