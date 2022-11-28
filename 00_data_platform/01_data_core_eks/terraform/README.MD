# Connect to cluster

```console
configure_kubectl = "aws eks --region us-east-2 update-kubeconfig --name staging"
```

# Connect as riker member

```console
dataform output 04_eks_blueprint
TEAM_RIKER_ROLE_ARN=$(cat stages/04_eks_blueprint/envs/staging/tmp.json  | jq '.team_riker.value[]' -r) && rm -f stages/04_eks_blueprint/envs/staging/tmp.json
echo "TEAM_RIKER_ROLE_ARN is $TEAM_RIKER_ROLE_ARN"
CREDENTIALS=$(aws sts assume-role --role-arn $TEAM_RIKER_ROLE_ARN --role-session-name riker)
export AWS_ACCESS_KEY_ID="$(echo ${CREDENTIALS} | jq -r '.Credentials.AccessKeyId')"
export AWS_SECRET_ACCESS_KEY="$(echo ${CREDENTIALS} | jq -r '.Credentials.SecretAccessKey')"
export AWS_SESSION_TOKEN="$(echo ${CREDENTIALS} | jq -r '.Credentials.SessionToken')"
export AWS_EXPIRATION=$(echo ${CREDENTIALS} | jq -r '.Credentials.Expiration')
aws sts get-caller-identity
```

Test accesses : 

```console
# list nodes ?
kgn
# List nodes in team-riker namespace ?
kgp -n team-riker
# list all pods in all namespaces ?
kubectl get pods -A
# can i create pods in kube-system namespace ?
kubectl auth can-i create pods --namespace kube-system
# list service accounts in team-riker namespace ?
kubectl get sa -n team-riker
# list service accounts in default namespace ?
kubectl get sa -n default
# can i create pods in team-riker namespace ?
kubectl auth can-i create pods --namespace team-riker
# can i list pods in team-riker namespace ?
kubectl auth can-i list pods --namespace team-riker
```

Clear : 

```console
unset AWS_SESSION_TOKEN
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_EXPIRATION
aws sts get-caller-identity
```