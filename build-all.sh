#!/bin/bash
# Acessar usuário root
sudo su
# Instalar K3S com kubectl
curl -sfL https://get.k3s.io | sh -
# Habilitar permissão para usuário ubuntu obter configuração de acesso ao K8S
echo K3S_KUBECONFIG_MODE=\"644\" >> /etc/systemd/system/k3s.service.env
# Restart do serviço k3s para carregar nova config
systemctl restart k3s

# Obter informações dos nós do cluster K8S
kubectl get nodes

# Usage example:
NAMESPACE="kube-system"
wait_for_pods "$NAMESPACE"


kubectl apply -f .

NAMESPACE="default"
wait_for_pods "$NAMESPACE"



wait_for_pods() {
  local NAMESPACE="$1"

  while true; do
    PODS_RUNNING=$(kubectl get pods -n "$NAMESPACE" --no-headers | awk '{print $3}' | grep -v "Running")

    if [ -z "$PODS_RUNNING" ]; then
      echo "All Pods are running in namespace $NAMESPACE."
      break
    else
      echo "Waiting for Pods to be in the 'Running' state in namespace $NAMESPACE..."
      sleep 1
    fi
  done
}
