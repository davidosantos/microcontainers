#!/bin/bash
# Instalar K3S com kubectl

wait_for_pods() {

    while true; do
        kubectl get pods -n "$1"
        local running=$(kubectl get pods -n "$1" --no-headers | awk '{print $3}' | grep "Running")

        if test -n "$running"; then
            echo "Há Pods rodando no namespace $1."
            break

        else
            echo "Aguardando os pods no namespace $1..."
            sleep 1
        fi
    done
}

curl -sfL https://get.k3s.io | sh -
# Habilitar permissão para usuário ubuntu obter configuração de acesso ao K8S
echo K3S_KUBECONFIG_MODE=\"644\" >>/etc/systemd/system/k3s.service.env
# Restart do serviço k3s para carregar nova config
systemctl restart k3s

# Obter informações dos nós do cluster K8S
kubectl get nodes

wait_for_pods "kube-system"

kubectl apply -f .

wait_for_pods "default"
