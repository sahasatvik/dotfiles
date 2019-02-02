#
#  Kubernetes (kubectl)
#
# Kubernetes is an open-source system for deployment, scaling,
# and management of containerized applications.
# Link: https://kubernetes.io/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_KUBECONTEXT_SHOW="${SPACESHIP_KUBECONTEXT_SHOW=true}"
SPACESHIP_KUBECONTEXT_PREFIX="${SPACESHIP_KUBECONTEXT_PREFIX="at "}"
SPACESHIP_KUBECONTEXT_SUFFIX="${SPACESHIP_KUBECONTEXT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
# Additional space is added because ☸️ is much bigger than the other symbols
# See: https://github.com/denysdovhan/spaceship-prompt/pull/432
SPACESHIP_KUBECONTEXT_SYMBOL="${SPACESHIP_KUBECONTEXT_SYMBOL="☸️  "}"
SPACESHIP_KUBECONTEXT_COLOR="${SPACESHIP_KUBECONTEXT_COLOR="cyan"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current context in kubectl
spaceship_kubecontext() {
  [[ $SPACESHIP_KUBECONTEXT_SHOW == false ]] && return

  spaceship::exists kubectl || return

  local kube_context=$(kubectl config current-context 2>/dev/null)

  [[ -z $kube_context ]] && return

  spaceship::section \
    "$SPACESHIP_KUBECONTEXT_COLOR" \
    "$SPACESHIP_KUBECONTEXT_PREFIX" \
    "${SPACESHIP_KUBECONTEXT_SYMBOL}${kube_context}" \
    "$SPACESHIP_KUBECONTEXT_SUFFIX"
}
