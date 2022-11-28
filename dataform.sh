layer=""
stage=""
env=""
cmd=""

# FUNCTIONS
usage(){
    echo "Terraform commands wrapper" >&2
    echo "usage : $0 --env <env> --stage <stage> --layer <layer>" >&2
    echo "--layer layer where the stage is located" >&2
    echo "--env   terraform environment you want play" >&2
    echo "--stage terraform stage you want to terraform" >&2
    echo "--cmd   terraform command to play"
}


##################################################################
### MAIN
##################################################################
# Parse arguments
echo "$@"
while [ $# -gt 0 ]; do
  case $1 in
    --layer) layer=$2 ; shift 2 ;;
    --env) env=$2 ; shift 2 ;;
    --stage) stage=$2 ; shift 2 ;;
    --cmd) cmd=$2 ; shift 2 ;;
    -h|-help|--help) usage;;
    * ) break ;;
  esac
done


TERRAFORM_BASE_DIR="${layer}/${stage}/terraform"

echo "Initialise terraform: "
echo "TF_IN_AUTOMATION=true TF_DATA_DIR=\"envs/${env}/.terraform\" terraform -chdir=\"${TERRAFORM_BASE_DIR}\" init --backend-config=\"$(pwd)/backend.tfvars\""
TF_IN_AUTOMATION=true TF_DATA_DIR="envs/${env}/.terraform" terraform -chdir="${TERRAFORM_BASE_DIR}" init --backend-config="$(pwd)/backend.tfvars"

echo "$cmd terraform: "

if [ $cmd == "output" ]; then
  echo "TF_DATA_DIR=\"envs/${env}/.terraform\" terraform -chdir=\"${TERRAFORM_BASE_DIR}\" \"${cmd}\""
  TF_DATA_DIR="envs/${env}/.terraform" terraform -chdir="${TERRAFORM_BASE_DIR}" "${cmd}"
else
  echo "TF_DATA_DIR=\"envs/${env}/.terraform\" terraform -chdir=\"${TERRAFORM_BASE_DIR}\" \"${cmd}\" -var-file \"$(pwd)/${TERRAFORM_BASE_DIR}/envs/${env}/${stage}.tfvars\" -var-file \"$(pwd)/${TERRAFORM_BASE_DIR}/envs/common.tfvars\""
  TF_DATA_DIR="envs/${env}/.terraform" terraform -chdir="${TERRAFORM_BASE_DIR}" "${cmd}" -var-file "$(pwd)/${TERRAFORM_BASE_DIR}/envs/${env}/${stage}.tfvars" -var-file "$(pwd)/${TERRAFORM_BASE_DIR}/envs/common.tfvars"
fi