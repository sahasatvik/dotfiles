# vim: filetype=sh

function git_status_short () {
	if [[ $(git_prompt_status) ]]; then
		echo "%{\033[90;1m%}[$(git_prompt_status)]%{$reset_color%} "
	fi
}

local dollar="%(!:#:$)"
PROMPT='%{$fg_bold[blue]%}%~%{$reset_color%} $(git_prompt_info)$(git_status_short)\
%(?:%{$fg_bold[white]%}$dollar%{$reset_color%}:%{$fg_bold[red]%}$dollar%{$reset_color%}) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{\033[90;1m%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="~"
ZSH_THEME_GIT_PROMPT_DELETED="-"
ZSH_THEME_GIT_PROMPT_RENAMED="^"
ZSH_THEME_GIT_PROMPT_UNMERGED="="
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
