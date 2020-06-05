controller:
  defaultTLS:
    secret: cert-manager/wildcard
  wildcardTLS:
    secret: cert-manager/wildcard
  service:
    enabled: ${controller_service.enabled}
    type: LoadBalancer
    loadBalancerIP: ${controller_service.loadBalancerIP}
    annotations:
%{ for annotation in annotations }
      ${annotation.annotation_key} : ${annotation.annotation_value}
%{ endfor }