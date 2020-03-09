controller:
  extraArgs:
    default-ssl-certificate: cert-manager/wildcard
  service:
    enabled: ${controller_service.enabled}
    loadBalancerIP: ${controller_service.loadBalancerIP}
    annotations:
%{ for annotation in annotations }
      ${annotation.annotation_key} : ${annotation.annotation_value}
%{ endfor }