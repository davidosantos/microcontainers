# microcontainers


## Passo a Passo


### Preparação do Ambiente

```

# Acessar usuário root
sudo su
# Instalar K3S com kubectl
curl -sfL https://get.k3s.io | sh -
# Habilitar permissão para usuário ubuntu obter configuração de acesso ao K8S
echo K3S_KUBECONFIG_MODE=\"644\" >> /etc/systemd/system/k3s.service.env
# Restart do serviço k3s para carregar nova config
systemctl restart k3s

```

### Obtendo os artefatos

```

git clone https://github.com/davidosantos/microcontainers.git

cd microcontainers

```

###  Subindo os recursos

```

kubectl apply -f .

```

###  Verificando os pods criados

```

kubectl get pods -o wide

```

###  Removendo uma instancia

```

kubectl delete pod <POD_NAME>

```