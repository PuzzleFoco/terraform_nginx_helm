controller:
  service:
    enabled: ${controller_service.enabled}
    loadBalancerIP: ${controller_service.loadBalancerIP}
%{ for annotation in annotations }
    annotations:
      "${annotation}": "${annotation.*}"
%{ endfor }