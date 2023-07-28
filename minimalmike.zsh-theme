ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}[ "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}*%{$reset_color%}%{$fg[white]%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="]%{$reset_color%} "
ZSH_THEME_SVN_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_SVN_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_SVN_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_SVN_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN
ZSH_THEME_HG_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_HG_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_HG_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_HG_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN

vcs_status() {
    if [[ $(whence in_svn) != "" ]] && in_svn; then
        svn_prompt_info
    elif [[ $(whence in_hg) != "" ]] && in_hg; then
        hg_prompt_info
    else
        git_prompt_info
    fi
}

kube_status() {
	kubectl config view --minify --output 'jsonpath={..current-context}'
}

prompt_ip() {
	curl -s icanhazip.com
}


tf_prompt_info() {
  # dont show 'default' workspace in home dir
  [[ "$PWD" != ~ ]] || return
  if [ -d .terraform ]; then
    workspace=$(terraform workspace show 2> /dev/null) || return
    echo "[ ${workspace}]"
  fi
}

prompt_cf() {
  # print the cloudfoundry target information
  if [ -z $CF_HOME ]; then
    cf_home=~/.cf;
  else
    cf_home=$CF_HOME;
  fi
  organization=`cat $cf_home/config.json | jq '.OrganizationFields.Name' | tr -d '"'`
  space=`cat $cf_home/config.json | jq '.SpaceFields.Name' | tr -d '"'`
  echo "[ $organization/$space]"
}


RPS1='%{$fg_bold[blue]%}$(kube_status)%{$reset_color%} %{$fg_bold[red]%}$(prompt_ip)%{$reset_color%}'
PROMPT='%{$fg_bold[green]%}%2~%{$reset_color%} $(vcs_status) $(tf_prompt_info) $(prompt_cf) » %b '

