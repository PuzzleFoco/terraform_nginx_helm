controller:
  service:
    enabled: ${controller_service.enabled}
    loadBalancerIP: ${controller_service.loadBalancerIP}
    annotations:
%{ for annotation in annotations }
      ${annotation.annotation_key} : ${annotation.annotation_value}
%{ endfor }