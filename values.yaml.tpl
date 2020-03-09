controller:
  image:
    repository: quay.io/kubernetes-ingress-controller/nginx-ingress-controller
    tag: "0.24.1"
    pullPolicy: IfNotPresent
    # www-data -> uid 33
    runAsUser: 33
  extraArgs:
    default-ssl-certificate: cert-manager/wildcard
  service:
    enabled: ${controller_service.enabled}
    loadBalancerIP: ${controller_service.loadBalancerIP}
    annotations:
%{ for annotation in annotations }
      ${annotation.annotation_key} : ${annotation.annotation_value}
%{ endfor }