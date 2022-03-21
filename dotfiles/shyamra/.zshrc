alias okta='bw get password zillow.okta.com | pbcopy'
alias unixpass='bw get password zillow.local | pbcopy'

alias s='spotify'
alias sp='s play'
alias spa='s pause'
alias ss='s status'

#SPRINTER_sprinter
[ -r /Users/shyamra/.sprinter/sprinter/.rc ] && . /Users/shyamra/.sprinter/sprinter/.rc
#SPRINTER_sprinter


#SPRINTER_zillow
[ -r /Users/shyamra/.sprinter/zillow/.rc ] && . /Users/shyamra/.sprinter/zillow/.rc
#SPRINTER_zillow

export VAULT_ADDR=https://vault.zo.zillow.net:443

complete -C /usr/local/bin/vault vault
source <(kubectl completion bash)

export KUBECONFIG=~/.kube/config:~/.kube/config.streamz
